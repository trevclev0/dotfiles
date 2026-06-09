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

# Load p10k configuration (must be last)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
