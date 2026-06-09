# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Initialize zi (plugin manager) — must come early
if [[ ! -f $HOME/.zi/bin/zi.zsh ]]; then
  print -P "%F{33}▓▒░ %F{220}Installing %F{33}zi%F{220}...%f"
  command mkdir -p "$HOME/.zi" && command chmod go-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch main https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zi/bin/zi.zsh"

# Load plugins with zi
zi load zsh-users/zsh-syntax-highlighting
zi load zsh-users/zsh-autosuggestions

# Load Powerlevel10k theme
zi light romkatv/powerlevel10k

# Source additional configuration files
[[ -f ~/.zsh_aliases ]] && source ~/.zsh_aliases


# ==============================================================================
# --- CRITICAL SYSTEM PATH RECOVERY & TOOL INITIALIZATION ---
# ==============================================================================

# 1. Force rebuild a completely fresh, functional system path array
path=(
  /home/codespace/.local/bin
  /usr/local/bin
  /usr/bin
  /bin
  /usr/local/sbin
  /usr/sbin
  /sbin
  /home/codespace/.zi/polaris/bin
  $path
)
export PATH

# 2. Initialize mise (manages bat, eza, zoxide, etc.)
if [[ -f "$HOME/.local/bin/mise" ]]; then
  eval "$($HOME/.local/bin/mise activate zsh)"
fi

# 3. Initialize zoxide
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# Load p10k configuration (must be absolutely last)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
