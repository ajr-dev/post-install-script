#!/bin/bash

# shellcheck disable=SC2034
declare -f assertConfirmation &>/dev/null ||  source "$HOME/.dotfiles/install/declarations.sh"

if ! command_exists java; then
    source "$HOME/.dotfiles/install/programming/java-install.sh"
fi

sudo apt-get install -y alien

cd ~/Downloads
sudo alien datamodeler-*.noarch.rpm
sudo unzip ~/Downloads/android-studio*.zip -d /opt
sudo dpkg -i datamodeler_4.1.5.907-2_all.deb
