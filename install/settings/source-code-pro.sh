#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT="$DIR/../.."
source "$ROOT/install/declarations.sh"

# Install patched nerd font
if have_sudo_access; then
  echo "Installing system wide"
  FONTS_PATH="/usr/share/fonts/.local/share/fonts/"
  sudo mkdir -p "$FONTS_PATH"
  SauceCodePro="https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro"
  sudo curl -L -o "$FONTS_PATH/Sauce Code Pro Nerd Font Regular.ttf" "$SauceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete.ttf"
  sudo curl -L -o "$FONTS_PATH/Sauce Code Pro Nerd Font Bold.ttf" "$SauceCodePro/Bold/complete/Sauce%20Code%20Pro%20Bold%20Nerd%20Font%20Complete.ttf"
  sudo curl -L -o "$FONTS_PATH/Sauce Code Pro Nerd Font Italic.ttf" "$SauceCodePro/Italic/complete/Sauce%20Code%20Pro%20Italic%20Nerd%20Font%20Complete.ttf"
else
  echo "Installing font for local user"
  FONTS_PATH="$HOME/.local/share/fonts/"
  mkdir -p "$FONTS_PATH"
  SauceCodePro="https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro"
  curl -L -o "$FONTS_PATH/Sauce Code Pro Nerd Font Regular.ttf" "$SauceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete.ttf"
  curl -L -o "$FONTS_PATH/Sauce Code Pro Nerd Font Bold.ttf" "$SauceCodePro/Bold/complete/Sauce%20Code%20Pro%20Bold%20Nerd%20Font%20Complete.ttf"
  curl -L -o "$FONTS_PATH/Sauce Code Pro Nerd Font Italic.ttf" "$SauceCodePro/Italic/complete/Sauce%20Code%20Pro%20Italic%20Nerd%20Font%20Complete.ttf"
fi

fc-cache -fv "$FONTS_PATH"  # update the font cache
if fc-list | grep -q "Sauce"; then
   return # Installed scessflly:
fi

SYSTEM_FONTS=/usr/local/share/fonts
HOME_FONTS=~/.local/share/fonts

if have_sudo_access && assertConfirmation "Install system-wide (Yy) or locally (Nn)?"; then
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
