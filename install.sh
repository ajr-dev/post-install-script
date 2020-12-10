#!/bin/bash

DOTFILES=$HOME/.dotfiles
INSTALL_DIR=$HOME/.post-install
INSTALL=$INSTALL_DIR/install

mkdir -p "$HOME/tmp"  &&  cd "$HOME/tmp"

command_exists() {
    command -v "$1" > /dev/null 2>&1
}

assertConfirmation () {
    local promptMsg=$1 #autoConfirm=$2
    if (( autoConfirm )); then
        return
    else
        clear
        read  -n 1 -p "$promptMsg (yes/No) "
        printf '\n' # Output a newline, because none was appended to the user's keypress.
        echo "========================================================================"
        if [[ $REPLY =~ ^([Yy])$ ]]; then # TODO: accept yes besides Y and y
            return
        fi
    fi
    return 1
}

if ! command_exists git; then
    sudo apt-get -y install --install-recomends git
fi

if [ ! -d "$DOTFILES" ]; then
    git clone https://github.com/ajr-dev/dotfiles "$DOTFILES"
    source "$DOTFILES/install.sh"
fi

if [ ! -d "$INSTALL_DIR" ]; then
    git clone https://github.com/ajr-dev/post-install-script "$INSTALL_DIR"
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
