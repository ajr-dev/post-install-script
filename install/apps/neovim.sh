#!/bin/bash

declare -f assertConfirmation &>/dev/null ||  . "$HOME/.dotfiles/install/declarations.sh"

if ! command_exists nvim; then
  # Build from source
  #sudo apt-get -y install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip
  #make CMAKE_BUILD_TYPE=Release
  #sudo make install
  #pip install neovim  &&  pip3 install neovim
  #pip install neovim --upgrade  &&  pip3 install neovim --upgrade

  # Install from PPA
  sudo apt install -y software-properties-common
  sudo add-apt-repository ppa:neovim-ppa/stable
  sudo apt update -y
  sudo apt install -y neovim
  sudo apt install -y python-dev python-pip python3-dev python3-pip
  sudo apt autoremove -y
fi

# Set neovim as the default editor
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --config editor

# Install Vim-Plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim +PlugInstall
