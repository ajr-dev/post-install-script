#!/bin/bash

# shellcheck disable=SC2034
declare -f assertConfirmation &>/dev/null ||  source "$HOME/.dotfiles/install/declarations"

sudo apt-get install build-essential cmake # install development tools and CMake
sudo apt-get install -y software-properties-common
sudo apt-get install -y python-software-properties
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update -y
sudo apt-get install -y neovim
# Make sure you have Python headers installed
sudo apt-get install -y python-dev python-pip python3-dev python3-pip
sudo apt-get install -y python3-setuptools
sudo easy_install3 pip
sudo pip install --upgrade pip
sudo pip3 install --upgrade neovim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --config editor

[ ! command_exists  mono ]  &&  source "$INSTALL/programming/mono-install.sh"
[ ! command_exists  go ]  &&  source "$INSTALL/programming/go-install.sh"
[ ! command_exists  npm ]  &&  source "$INSTALL/programming/npm-install.sh"
[ ! command_exists  rust ]  &&  source "$INSTALL/programming/rust-install.sh"
[ ! command_exists  java ]  &&  source "$INSTALL/programming/java-install.sh"

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim +PlugInstall
