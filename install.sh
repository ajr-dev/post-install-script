#!/bin/bash

source "$HOME/.dotfiles/install/declarations"
source "$INSTALL/essential"
source "$INSTALL/app-install"
source "$INSTALL/programming-tools"
source "$INSTALL/system-setup"
source "$INSTALL/startup-scripts"

if [ "$(uname)" == "Darwin" ]; then
    source "$INSTALL/brew-setup"
    source "$INSTALL/osx-setup"
fi

sudo apt-get -y --force-yes autoremove
sudo apt-get -y --force-yes update
sudo apt-get -y --force-yes upgrade
[ -d ~/tmp ]  &&  rm -rf ~/tmp

clear
read -n 1 -p "Reboot? (yes/No) "
if [[ $REPLY =~ ^([Yy])$ ]]; then
  sudo reboot
fi
