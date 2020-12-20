#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT="$DIR/../.."
source "$ROOT/install/declarations.sh"

install_nerd_font() {
  # require font-name and version
  if font_installed "$1"; then
    echo "$1 font already install"
    return
  fi

  tmp_dir=$(mktemp -d)

  wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v$2/$1.zip" -O "$tmp_dir/tmp.zip"

  if have_sudo_access; then
    FONTS_DIR=/usr/local/share/fonts
    sudo mkdir -p "$FONTS_DIR/$1"
    #sudo mv "$tmp_dir"/* "/usr/share/fonts/.local/share/fonts/"
    sudo unzip "$tmp_dir/tmp.zip" -d "$FONTS_DIR/$1"
  else
    FONTS_DIR=~/.local/share/fonts
    mkdir -p "$FONTS_DIR/$1"
    unzip "$tmp_dir/tmp.zip" -d "$FONTS_DIR/$1"
  fi

  rm -rf "$tmp_dir"

  fc-cache -fv "$FONTS_DIR"  # update the font cache
  if fc-list | grep -q "$1"; then
    success "$1 font installed successfully!"
  else
    error "$1 font couldn't be installed"
  fi
}
