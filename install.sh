#!/bin/sh
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

info() { printf "\033[34m[INFO]\033[0m  %s\n" "$1"; }
ok()   { printf "\033[32m[OK]\033[0m    %s\n" "$1"; }
err()  { printf "\033[31m[ERROR]\033[0m %s\n" "$1"; }

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
else
  SUDO="sudo"
fi

# ── Packages ─────────────────────────────────────────────────────────
info "Installing packages from packages/arch.txt..."
grep -vE '^[[:space:]]*(#|$)' packages/arch.txt \
  | xargs -r $SUDO pacman -S --needed --noconfirm
ok "Packages installed"

# ── Back up conflicting paths ────────────────────────────────────────
backup_path() {
  path="$1"
  [ -e "$path" ] || [ -L "$path" ] || return 0

  resolved="$(readlink -f "$path" 2>/dev/null || true)"
  case "$resolved" in
    "$SCRIPT_DIR/home"|"$SCRIPT_DIR/home"/*) return 0 ;;
  esac

  backup="$path.bak.$(date +%Y%m%d%H%M%S)"
  mv "$path" "$backup"
  info "Backed up $path -> $backup"
}

for path in \
  "$HOME/.zshenv" \
  "$HOME/.Xresources" \
  "$HOME/.tmux.conf" \
  "$HOME/.config/alacritty" \
  "$HOME/.config/bat/config" \
  "$HOME/.config/fontconfig/fonts.conf" \
  "$HOME/.config/git/config" \
  "$HOME/.config/i3/config" \
  "$HOME/.config/lazygit" \
  "$HOME/.config/rofi" \
  "$HOME/.config/nvim" \
  "$HOME/.config/starship.toml" \
  "$HOME/.tmux/clipboard.conf" \
  "$HOME/.local/share/wallpapers"
do
  backup_path "$path"
done

if [ -L "$HOME/.zshrc" ] && [ ! -e "$HOME/.zshrc" ]; then
  rm "$HOME/.zshrc"
  info "Removed dangling ~/.zshrc"
fi

# ── Link dotfiles ────────────────────────────────────────────────────
# Create the managed directories first so stow descends into them instead of
# replacing them with a single symlink. This keeps files such as zsh history,
# git ignore rules outside the repo.
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
  "$HOME/.tmux" \
  "$HOME/.local/share"

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
  "$HOME/.tmux/plugins/tpm/bin/install_plugins" >/dev/null 2>&1 || true
fi

# ── Neovim plugins ───────────────────────────────────────────────────
if command -v nvim >/dev/null 2>&1; then
  info "Installing Neovim plugins..."
  nvim --headless "+Lazy! sync" +qa >/dev/null 2>&1 || true
fi

# ── Checks ───────────────────────────────────────────────────────────
zsh_path="$(command -v zsh || true)"
current_shell="$(getent passwd "$USER" | cut -d: -f7)"
if [ -n "$zsh_path" ] && [ "$current_shell" != "$zsh_path" ]; then
  err "Default shell is not zsh. Run: chsh -s $zsh_path"
fi

echo ""
ok "Installation complete."
echo "  exec zsh    # start a zsh login shell"
