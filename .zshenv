# mise initialization (needs to run early for PATH)
eval "$($HOME/.local/bin/mise activate zsh)"

# zoxide initialization (affects PATH)
eval "$(zoxide init zsh)"

# Export any environment variables
export EDITOR=vim
export LANG=en_US.UTF-8
