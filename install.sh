#!/bin/bash

source "$HOME/.dotfiles/install/declarations.sh"

source "$INSTALL/setup/system-setup.sh"
if  ! (( ${quick:?} ));  then
    source "$INSTALL/essential.sh"
    source "$INSTALL/apps/app-install.sh"
    source "$INSTALL/programming/programming-tools.sh"
    source "$INSTALL/startup-scripts.sh"
    if  assertConfirmation "Final updates?";  then
        sudo apt-get -y --force-yes autoremove
        sudo apt-get -y --force-yes update
        sudo apt-get -y --force-yes upgrade
    fi
fi

clear
if  assertConfirmation "Reboot?";  then
    sudo reboot
fi
