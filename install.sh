#!/usr/bin/env bash
set -euo pipefail

# Resolve dotfiles directory
DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# --- mise ---
curl https://mise.run | sh
export PATH="$HOME/.local/bin:$PATH"

# --- symlink configs ---
ln -sf "$DOTFILES/.zshrc" ~/.zshrc
ln -sf "$DOTFILES/.zprofile" ~/.zprofile
ln -sf "$DOTFILES/.zshenv" ~/.zshenv
ln -sf "$DOTFILES/.zsh_aliases" ~/.zsh_aliases
ln -sf "$DOTFILES/.config/mise/config.toml" ~/.config/mise/config.toml
ln -sf "$DOTFILES/.p10k.zsh" ~/.p10k.zsh

sudo chsh -s "$(which zsh)" "$(whoami)"

# --- install tools from config ---
~/.local/bin/mise install
