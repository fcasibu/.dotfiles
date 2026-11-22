# ── oh-my-zsh ────────────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git gh fzf fzf-tab zsh-autosuggestions)
source "$ZSH/oh-my-zsh.sh"

# ── History ──────────────────────────────────────────────────────────
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.zsh_history"
setopt HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE SHARE_HISTORY

# ── Completion ───────────────────────────────────────────────────────
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# ── Aliases ──────────────────────────────────────────────────────────
alias a='ls -A'
alias l='ls -lahF'
alias ll='ls -lhF'
alias la='ls -lAhF'
alias ls='eza --icons'
alias tree='eza --tree --icons'
alias nv='nvim'
alias v='nvim'
alias vim='nvim'
alias grep='grep --color=auto'
alias cat='bat'
alias g='git'
alias gst='git status'
alias gp='git push'
alias gl='git pull'
alias gc='git commit'
alias gca='git commit --amend'
alias gco='git checkout'
alias gb='git branch'
alias gd='git diff'
alias grb='git rebase'

# ── Local overrides ──────────────────────────────────────────────────
[ -f "$HOME/.secrets" ] && source "$HOME/.secrets"

# ── Prompt and directory jumping ─────────────────────────────────────
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# ── Syntax highlighting (must load last) ─────────────────────────────
zsh_highlight="$ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
[ -f "$zsh_highlight" ] && source "$zsh_highlight"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)
