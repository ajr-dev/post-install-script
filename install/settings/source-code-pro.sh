#!/bin/bash

CURRENT_DIR=$(dirname "$0")
declare -f assertConfirmation &>/dev/null ||  source "$CURRENT_DIR/../declarations.sh"

SYSTEM_FONTS=/usr/local/share/fonts
HOME_FONTS=~/.local/share/fonts

if assertConfirmation "Install system-wide (Yy) or locally (Nn)?"; then
  echo "installing source-code-pro to $SYSTEM_FONTS"
  sudo mkdir -p "$SYSTEM_FONTS/adobe-fonts/source-code-pro"

  (sudo git clone --branch release --depth 1 'https://github.com/adobe-fonts/source-code-pro.git' \
    "$SYSTEM_FONTS/adobe-fonts/source-code-pro" && \
    fc-cache -fv "$SYSTEM_FONTS/adobe-fonts/source-code-pro")  # update the font cache
else
  echo "installing source-code-pro to $HOME_FONTS"
  mkdir -p "$HOME_FONTS/adobe-fonts/source-code-pro"

  (git clone --branch release --depth 1 'https://github.com/adobe-fonts/source-code-pro.git' \
    "$HOME_FONTS/adobe-fonts/source-code-pro" && \
    fc-cache -fv "$HOME_FONTS/adobe-fonts/source-code-pro")  # update the font cache
fi
# TODO: install Source Code Pro from Nerd Fonts instead
if have_sudo_access; then
  FONTS_PATH="/usr/share/fonts/.local/share/fonts/"
  sudo mkdir -p "$FONTS_PATH"
  SauceCodePro="https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro"
  sudo curl -L -o "$FONTS_PATH/Sauce Code Pro Nerd Font Regular.ttf" "$SauceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete.ttf"
  sudo curl -L -o "$FONTS_PATH/Sauce Code Pro Nerd Font Bold.ttf" "$SauceCodePro/Bold/complete/Sauce%20Code%20Pro%20Bold%20Nerd%20Font%20Complete.ttf"
  sudo curl -L -o "$FONTS_PATH/Sauce Code Pro Nerd Font Italic.ttf" "$SauceCodePro/Italic/complete/Sauce%20Code%20Pro%20Italic%20Nerd%20Font%20Complete.ttf"
else
  FONTS_PATH="$HOME/.local/share/fonts/"
  mkdir -p "$FONTS_PATH"
  SauceCodePro="https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro"
  curl -L -o "$FONTS_PATH/Sauce Code Pro Nerd Font Regular.ttf" "$SauceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete.ttf"
  curl -L -o "$FONTS_PATH/Sauce Code Pro Nerd Font Bold.ttf" "$SauceCodePro/Bold/complete/Sauce%20Code%20Pro%20Bold%20Nerd%20Font%20Complete.ttf"
  curl -L -o "$FONTS_PATH/Sauce Code Pro Nerd Font Italic.ttf" "$SauceCodePro/Italic/complete/Sauce%20Code%20Pro%20Italic%20Nerd%20Font%20Complete.ttf"
fi
