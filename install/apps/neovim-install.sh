#!/bin/bash

# shellcheck disable=SC2034
declare -f assertConfirmation &>/dev/null ||  source "$HOME/.dotfiles/install/declarations.sh"

# Ubuntu install
# Required packages
packages=( build-essential cmake ppa-purge software-properties-common python-software-properties )
for app in "${packages[@]}" ; do
    if ! command_exists $app; then
        sudo apt-get -y install --install-recommends "$app"
    fi
done

# Install from repository
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update -y
sudo apt-get install -y neovim
sudo ppa-purge ppa:neovim-ppa/stable

# Install from latest release
# TODO: fix this
#version="$(curl https://github.com/neovim/neovim/releases/latest -s | grep '"tag_name":' | cut -d'v' -f2 | cut -d'"' -f1)"
version=v0.4.3
wget "https://github.com/neovim/neovim/releases/download/$version/nvim-linux64.tar.gz"

# Make sure you have Python headers installed
#sudo apt-get install -y python-dev python-pip x-env -iA nixpkgs.neovimpython3-dev x-env -iA nixpkgs.neovimpython3-pip

# If you're using an older version Ubuntu you must use:
#sudo apt-get install -y python-dev python-pip x-env -iA nixpkgs.neovimpython3-dev
#sudo apt-get install python3-setuptools
#sudo easy_install3 pip

# Upgrade
#sudo -H pip install --upgrade pip
#sudo -H pip3 install --upgrade neovim

sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --config editor

[ ! command_exists  mono ]  &&  source "$INSTALL/programming/mono-install.sh"
[ ! command_exists  go ]  &&  source "$INSTALL/programming/go-install.sh"
[ ! command_exists  npm ]  &&  source "$INSTALL/programming/npm-install.sh"
[ ! command_exists  rust ]  &&  source "$INSTALL/programming/rust-install.sh"
[ ! command_exists  java ]  &&  source "$INSTALL/programming/java-install.sh"

# Neovim can be installed with Nix
#nix-env -iA nixpkgs.neovim
# To install the Python modules:
#if command -v python3 &>/dev/null; then
#  nix-env -iA nixpkgs.python3Packages.pynvim
#elif command -v python2 &>/dev/null; then
#  nix-env -iA nixpkgs.python2Packages.pynvim
#fi

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim +PlugInstall
