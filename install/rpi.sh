#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT="$DIR/.."
source "$ROOT/install/declarations.sh"

sudo apt update


# full-upgrade is equivalent to dist-upgrade
sudo apt full-upgrade
sudp apt dist-upgrade
# NEVER run rpi-update. You don't know what you're getting with rpi-update as it
# can give you an experimental kernel and untested bootcode.

# TODO: update to latest bootloader, get function from /usr/bin/raspi-config

# TODO: To make the console repeat permanent, edit /etc/kbd/config.
# To make the GUI repeat permanent, add the 'xset r rate 150 10' command to /etc/xdg/lxsession/LXDE/autostart.

# Install dependencies
packages=( git build-essential file zsh git sudo ruby curl nvim checkinstall \
           ripgrep `# tool to recursively search current directory with 'rg <pattern>'` \
           libssl-dev npm shellcheck )
for app in "${packages[@]}"; do
  if ! command_exists "$app"; then
    sudo apt install -y "$app"
  fi
done

# Update node.js
sudo npm cache clean -f
sudo npm install -g n
sudo n stable
PATH="$PATH"

# Install NVM
[ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
mkdir -p "$NVM_DIR"
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.35.1/install.sh | bash || return
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

sudo npm install -g diff-so-fancy

# Install FZF
mkdir -p ~/.fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish

# TODO: Install nvim

# TODO: Install tmux

source "$ROOT/install/settings/install_nerd_font.sh"
VERSION=2.1.0

FONT_NAME=SourceCodePro
install_nerd_font "$FONT_NAME" "$VERSION"

FONT_NAME=FiraCode
install_nerd_font "$FONT_NAME" "$VERSION"

FONT_NAME=Hack
install_nerd_font "$FONT_NAME" "$VERSION"
