#!/bin/bash
set -e

echo "Setting up development environment..."

# Bootstrap mise
curl https://mise.jdx.dev/install.sh | sh

# Install all tools from .mise.toml
mise install

# Install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

# Install zi (zsh plugin manager)
bash <(curl -sL https://get.zshell.dev)

# Install aicommit (standalone binary)
ARCH=$(uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/')
curl -sL "https://github.com/russmckendrick/aicommit/releases/latest/download/aic-linux-${ARCH}" -o aic
chmod +x aic
sudo mv aic /usr/local/bin/

# Symlink dotfiles to home directory
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
ln -sf "$DOTFILES_DIR/.zshenv" ~/.zshenv
ln -sf "$DOTFILES_DIR/.zprofile" ~/.zprofile
ln -sf "$DOTFILES_DIR/.zshrc" ~/.zshrc
ln -sf "$DOTFILES_DIR/.zsh_aliases" ~/.zsh_aliases
ln -sf "$DOTFILES_DIR/.mise.toml" ~/.mise.toml
ln -sf "$DOTFILES_DIR/.p10k.zsh" ~/.p10k.zsh

echo "Tools installed successfully!"
