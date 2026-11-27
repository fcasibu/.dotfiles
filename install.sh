#!/bin/sh
set -eu

// TODO(fcasibu): make use of yay

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

info() { printf "\033[34m[INFO]\033[0m  %s\n" "$1"; }
ok()   { printf "\033[32m[OK]\033[0m    %s\n" "$1"; }
warn() { printf "\033[33m[WARN]\033[0m  %s\n" "$1" >&2; }
err()  { printf "\033[31m[ERROR]\033[0m %s\n" "$1" >&2; }

USER_NAME="$(id -un)"

if [ ! -f /etc/arch-release ]; then
  err "This installer targets Arch Linux."
  exit 1
fi

for cmd in pacman stow git; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    err "$cmd is required but not found."
    exit 1
  fi
done

if [ "$(id -u)" -eq 0 ]; then
  SUDO=""
  warn "Running as root: dotfiles will be linked into $HOME, not a regular user's home."
else
  if ! command -v sudo >/dev/null 2>&1; then
    err "sudo is required when not running as root."
    exit 1
  fi
  SUDO="sudo"
fi

if [ ! -f packages/arch.txt ]; then
  err "packages/arch.txt not found."
  exit 1
fi

# ── Packages ─────────────────────────────────────────────────────────
info "Installing packages from packages/arch.txt..."
sed -e 's/[[:space:]]*#.*$//' -e '/^[[:space:]]*$/d' packages/arch.txt \
  | xargs -r $SUDO pacman -Syu --needed --noconfirm
ok "Packages installed"

# ── Back up conflicting paths ────────────────────────────────────────
backup_path() {
  target="$1"
  [ -e "$target" ] || [ -L "$target" ] || return 0

  case "$(readlink -f "$target" 2>/dev/null || true)" in
    "$SCRIPT_DIR/home"|"$SCRIPT_DIR/home"/*) return 0 ;;
  esac

  if [ -d "$target" ] && [ ! -L "$target" ]; then
    foreign=0
    while IFS= read -r f; do
      case "$(readlink -f "$f" 2>/dev/null || true)" in
        "$SCRIPT_DIR/home"/*) ;;
        *) foreign=1 ;;
      esac
    done <<EOF
$(find "$target" ! -type d)
EOF
    [ "$foreign" -eq 1 ] || return 0
  fi

  backup="$target.bak.$(date +%Y%m%d%H%M%S)"
  mv "$target" "$backup"
  info "Backed up $target -> $backup"
}

for target in \
  "$HOME/.zshenv" \
  "$HOME/.Xresources" \
  "$HOME/.tmux.conf" \
  "$HOME/.config/alacritty" \
  "$HOME/.config/bat/config" \
  "$HOME/.config/fontconfig/fonts.conf" \
  "$HOME/.config/git/config" \
  "$HOME/.config/i3/config" \
  "$HOME/.config/i3status" \
  "$HOME/.config/lazygit" \
  "$HOME/.config/rofi" \
  "$HOME/.config/nvim" \
  "$HOME/.config/starship.toml" \
  "$HOME/.tmux/clipboard.conf" \
  "$HOME/.local/share/wallpapers"
do
  backup_path "$target"
done

if [ -e "$SCRIPT_DIR/home/.zshrc" ] || [ -L "$SCRIPT_DIR/home/.zshrc" ]; then
  backup_path "$HOME/.zshrc"
fi

if [ -L "$HOME/.zshrc" ] && [ ! -e "$HOME/.zshrc" ]; then
  rm "$HOME/.zshrc"
  info "Removed dangling ~/.zshrc"
fi

# ── Link dotfiles ────────────────────────────────────────────────────
mkdir -p \
  "$HOME/.config/alacritty" \
  "$HOME/.config/bat" \
  "$HOME/.config/fontconfig" \
  "$HOME/.config/git" \
  "$HOME/.config/i3" \
  "$HOME/.config/i3status" \
  "$HOME/.config/lazygit" \
  "$HOME/.config/rofi" \
  "$HOME/.config/nvim" \
  "$HOME/.config/picom" \
  "$HOME/.tmux" \
  "$HOME/.local/share"

info "Checking for stow conflicts..."
if ! stow_out="$(stow -n --restow --dir "$SCRIPT_DIR" --target "$HOME" home 2>&1)"; then
  err "stow found conflicts. Move or remove the files below, then re-run:"
  printf "%s\n" "$stow_out" >&2
  exit 1
fi

info "Linking dotfiles with stow..."
stow --restow --dir "$SCRIPT_DIR" --target "$HOME" home
ok "Dotfiles linked"

# ── oh-my-zsh and plugins ────────────────────────────────────────────
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  info "Cloning oh-my-zsh..."
  git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
fi

clone_plugin() {
  name="$1"
  url="$2"
  dest="$HOME/.oh-my-zsh/custom/plugins/$name"
  if [ ! -d "$dest" ]; then
    info "Cloning $name..."
    git clone --depth=1 "$url" "$dest"
  fi
}

clone_plugin fzf-tab https://github.com/Aloxaf/fzf-tab.git
clone_plugin zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions.git
clone_plugin zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting.git

# ── tmux plugins ─────────────────────────────────────────────────────
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  info "Cloning tmux plugin manager..."
  git clone --depth=1 https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

if [ -x "$HOME/.tmux/plugins/tpm/bin/install_plugins" ]; then
  info "Installing tmux plugins..."
  if ! "$HOME/.tmux/plugins/tpm/bin/install_plugins" >/dev/null 2>&1; then
    warn "tmux plugin install failed. Run prefix + I inside tmux to retry."
  fi
fi

# ── Neovim plugins ───────────────────────────────────────────────────
if command -v nvim >/dev/null 2>&1; then
  info "Installing Neovim plugins..."
  if ! nvim --headless "+Lazy! sync" +qa >/dev/null 2>&1; then
    warn "Neovim plugin sync failed. Run :Lazy sync inside nvim to retry."
  fi
fi

# ── Checks ───────────────────────────────────────────────────────────
zsh_path="$(command -v zsh || true)"
current_shell="$(getent passwd "$USER_NAME" | cut -d: -f7 || true)"
if [ -n "$zsh_path" ] && [ "$current_shell" != "$zsh_path" ]; then
  warn "Default shell is not zsh. Run: chsh -s $zsh_path"
fi

echo ""
ok "Installation complete."
echo "  exec zsh    # start a zsh login shell"
