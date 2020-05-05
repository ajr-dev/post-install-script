#!/bin/sh

declare -f assertConfirmation &>/dev/null ||  source "$HOME/.dotfiles/install/declarations.sh"

SYSTEM_FONTS=/usr/local/share/fonts
HOME_FONTS=~/.local/share/fonts

if assertConfirmation "Install system-wide (Yy) or locally (Nn)?"; then
  echo "installing source-code-pro to $SYSTEM_FONTS"
  sudo mkdir -p "$SYSTEM_FONTS/adobe-fonts/source-code-pro"

  (sudo git clone --branch release --depth 1 'https://github.com/adobe-fonts/source-code-pro.git' \
    "$SYSTEM_FONTS/adobe-fonts/source-code-pro" && \
    fc-cache -f -v "$SYSTEM_FONTS/adobe-fonts/source-code-pro")  # update the font cache
else
  echo "installing source-code-pro to $HOME_FONTS"
  mkdir -p "$HOME_FONTS/adobe-fonts/source-code-pro"

  (git clone --branch release --depth 1 'https://github.com/adobe-fonts/source-code-pro.git' \
    "$HOME_FONTS/adobe-fonts/source-code-pro" && \
    fc-cache -f -v "$HOME_FONTS/adobe-fonts/source-code-pro")  # update the font cache
fi
# TODO: install Source Code Pro from Nerd Fonts instead
