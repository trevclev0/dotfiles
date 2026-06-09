#!/bin/bash
set -e

echo "Setting up development environment..."

# Symlink dotfiles to home directory FIRST
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
echo "Symlinking dotfiles from $DOTFILES_DIR..."
ln -sf "$DOTFILES_DIR/.zshenv" ~/.zshenv
ln -sf "$DOTFILES_DIR/.zprofile" ~/.zprofile
ln -sf "$DOTFILES_DIR/.zshrc" ~/.zshrc
ln -sf "$DOTFILES_DIR/.zsh_aliases" ~/.zsh_aliases
ln -sf "$DOTFILES_DIR/.mise.toml" ~/.mise.toml
ln -sf "$DOTFILES_DIR/.p10k.zsh" ~/.p10k.zsh

# Bootstrap mise
echo "Installing mise..."
curl https://mise.jdx.dev/install.sh | sh
export PATH="$HOME/.local/bin:$PATH"

# Install all tools from .mise.toml
echo "Installing tools via mise..."
mise install

# Verify tools are installed
echo "Verifying installations..."
which bat || echo "WARNING: bat not found"
which eza || echo "WARNING: eza not found"
which zoxide || echo "WARNING: zoxide not found"

# Install powerlevel10k
echo "Installing powerlevel10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

# Install zi
echo "Installing zi..."
bash <(curl -sL https://get.zshell.dev)

# Install aicommit (standalone binary)
echo "Installing aicommit..."
ARCH=$(uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/')
curl -sL "https://github.com/russmckendrick/aicommit/releases/latest/download/aic-linux-${ARCH}" -o /tmp/aic
chmod +x /tmp/aic
sudo mv /tmp/aic /usr/local/bin/aic

echo "✅ Setup complete!"
