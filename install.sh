#!/bin/bash

DOTFILES=$HOME/.dotfiles
INSTALL=$DOTFILES/install

mkdir -p "$HOME/tmp"  &&  cd "$HOME/tmp"

command_exists() {
    command -v "$1" > /dev/null 2>&1
}

if [ ! -d "$DOTFILES" ]; then
    if ! command_exists git; then
        sudo apt-get -y install --install-recomends git
    fi
    git clone https://github.com/ajr-dev/post-install-script "$DOTFILES"
fi
source "$INSTALL/declarations.sh"

source "$INSTALL/system-setup.sh"
if  ! (( ${quick:?} ));  then
    source "$INSTALL/essential.sh"
    source "$INSTALL/apps/app-install.sh"
    if  assertConfirmation "Install programming tools?"; then
        source "$INSTALL/programming/programming-tools.sh"
    fi
    source "$INSTALL/setup/startup-scripts.sh"
    if  assertConfirmation "Final updates?";  then
        sudo apt-get autoclean
        sudo apt-get clean
        sudo apt-get -y --force-yes autoremove
        sudo apt-get -y --force-yes update
        sudo apt-get -y --force-yes upgrade
    fi
fi

rm -rf "$HOME/tmp"

clear
if  assertConfirmation "Reboot?";  then
    sudo reboot
fi
