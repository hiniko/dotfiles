#!/bin/bash

# Setup Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Setup OMZ
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Tools
brew install \
  zsh \
  bash \
  fzf \
  nvim \
  direnv \
  tree \
  go \
  npm \
  alfred \
  iterm2 \
  1password \

echo "Download a patched font"
open "https://www.nerdfonts.com/font-downloads"
echo "Don't forget to install and change iterm!"

echo
echo

echo "Now some system settings to handle..."
echo "==> Mac Settings"
echo "===> Keyboard"
echo "====> * Disable mission control shortcuts"
echo "====> * Disable Spotlight shortcuts"
echo "===> Dock"
echo "====> * Hide dock by default"

echo
echo

echo  "Setup Github"
