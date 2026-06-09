# Environment variables
export EDITOR="vim"
export LANG="en_US.UTF-8"

# mise initialization — only if it exists
if [[ -f "$HOME/.local/bin/mise" ]]; then
  eval "$($HOME/.local/bin/mise activate zsh)"
else
  # Fallback: add common tool paths just in case
  export PATH="$HOME/.local/bin:$PATH"
fi

# zoxide initialization — only if it exists
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi
