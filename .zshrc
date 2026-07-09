# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Initialize zi (plugin manager) — must come early
ZI_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zi"
if [[ ! -f "$ZI_HOME/bin/zi.zsh" ]]; then
  git clone https://github.com/z-shell/zi.git "$ZI_HOME/bin"
fi
source "$ZI_HOME/bin/zi.zsh"

# Load plugins with zi
zi ice depth=1
zi light romkatv/powerlevel10k
zi load zsh-users/zsh-autosuggestions
zi load zsh-users/zsh-syntax-highlighting # ensure this zi plugin is last

# Initialize mise (manages bat, eza, zoxide, etc.)
if [[ -f "$HOME/.local/bin/mise" ]]; then
  eval "$($HOME/.local/bin/mise activate zsh)"
fi

# Initialize zoxide
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# Source additional configuration files
[[ -f ~/.zsh_aliases ]] && source ~/.zsh_aliases

# Load p10k configuration (must be absolutely last)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
