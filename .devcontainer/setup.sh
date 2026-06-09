#!/bin/bash
set -e

echo "🚀 Starting environment setup..."

# Handle Dotfiles
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE}" )/.." && pwd )"
echo "Symlinking dotfiles from $DOTFILES_DIR..."

rm -f ~/.zshenv ~/.zprofile ~/.zshrc ~/.zsh_aliases ~/.mise.toml ~/.p10k.zsh
ln -sf "$DOTFILES_DIR/.zshenv" ~/.zshenv
ln -sf "$DOTFILES_DIR/.zprofile" ~/.zprofile
ln -sf "$DOTFILES_DIR/.zshrc" ~/.zshrc
ln -sf "$DOTFILES_DIR/.zsh_aliases" ~/.zsh_aliases
ln -sf "$DOTFILES_DIR/.mise.toml" ~/.mise.toml
ln -sf "$DOTFILES_DIR/.p10k.zsh" ~/.p10k.zsh

# Determine System Architecture First
ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]; then
    MISE_ARCH="x64"
    AIC_ARCH="amd64"
elif [ "$ARCH" = "aarch64" ]; then
    MISE_ARCH="arm64"
    AIC_ARCH="arm64"
else
    MISE_ARCH="x64"
    AIC_ARCH="amd64"
fi

# Secure Mise Download via Official Web Gateway
echo "Installing mise..."
mkdir -p ~/.local/bin
curl -sSL "https://mise.run" | sh
export PATH="$HOME/.local/bin:$PATH"

# Tool Deployments via local binary
echo "Installing tools via mise..."
~/.local/bin/mise install --yes

# Powerlevel10k Theme Checkout
echo "Installing powerlevel10k..."
rm -rf ~/powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

# Native Zi Plugin Installation
echo "Installing zi..."
rm -rf ~/.zi
mkdir -p ~/.zi
git clone -q --depth=1 --branch main https://github.com/z-shell/zi ~/.zi/bin

# Standalone Aicommit Fetch
echo "Installing aicommit..."
curl -sL "https://github.com/russmckendrick/aicommit/releases/latest/download/aic-linux-${AIC_ARCH}" -o /tmp/aic
chmod +x /tmp/aic
sudo mv /tmp/aic /usr/local/bin/aic

echo "✅ Setup complete! Reload your environment."
