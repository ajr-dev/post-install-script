#!/bin/bash

source "$HOME/.dotfiles/install/declarations"

if [ "$(uname)" == "Linux" ]; then
  if (( ${quick:?} )); then
    source "$INSTALL/system-setup"
  else
    source "$INSTALL/essential"
    source "$INSTALL/app-install"
    source "$INSTALL/programming-tools"
    source "$INSTALL/system-setup"
    source "$INSTALL/startup-scripts"
  fi
  sudo apt-get -y --force-yes autoremove
  sudo apt-get -y --force-yes update
  sudo apt-get -y --force-yes upgrade
elif [ "$(uname)" == "Darwin" ]; then
    source "$INSTALL/brew-setup"
    source "$INSTALL/osx-setup"
fi

[ -d ~/tmp ]  &&  rm -rf ~/tmp

clear
read -n 1 -p "Reboot? (yes/No) "
if [[ $REPLY =~ ^([Yy])$ ]]; then
  sudo reboot
fi
