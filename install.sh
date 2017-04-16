#!/bin/bash

source install/declarations
source install/essential            "${autoConfirm:?}"
source install/app-install          "${autoConfirm:?}"
source install/programming-tools    "${autoConfirm:?}"
source install/system-setup         "${autoConfirm:?}"
source install/startup-scripts      "${autoConfirm:?}"

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
