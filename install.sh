#!/bin/bash

source "$HOME/.dotfiles/install/declarations"
source "$DOTFILES/install/essential"
source "$DOTFILES/install/app-install"
source "$DOTFILES/install/programming-tools"
source "$DOTFILES/install/system-setup"
source "$DOTFILES/install/startup-scripts"

if [ "$(uname)" == "Darwin" ]; then
    source install/brew-setup
    source install/osx-setup
fi

sudo apt-get -y --force-yes autoremove
sudo apt-get -y --force-yes update
sudo apt-get -y --force-yes upgrade

clear
read -n 1 -p "Reboot? (yes/No) "
if [[ $REPLY =~ ^([Yy])$ ]]; then
  sudo reboot
fi
