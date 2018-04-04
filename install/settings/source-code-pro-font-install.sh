#!/bin/sh
SYSTEM_FONT=/usr/local/share/fonts
FONT_HOME=~/.local/share/fonts

echo "installing source-code-pro at to $SYSTEM_FONT"
sudo mkdir -p "$SYSTEM_FONT/adobe-fonts/source-code-pro"

(sudo git clone --branch release --depth 1 'https://github.com/adobe-fonts/source-code-pro.git' \
  "$SYSTEM_FONT/adobe-fonts/source-code-pro" && \
  fc-cache -f -v "$SYSTEM_FONT/adobe-fonts/source-code-pro")
