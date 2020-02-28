#!/bin/bash

# shellcheck disable=SC2034
declare -f assertConfirmation &>/dev/null ||  source "$HOME/.dotfiles/install/declarations.sh"

pip install --user --upgrade pip
packages=( libgirepository1.0-dev gcc libcairo2-dev pkg-config python3-dev gir1.2-gtk-3.0 \
pip3 install pycairo PyGObject psutil )
for app in "${packages[@]}" ; do
    if ! command_exists "$app"; then
        sudo apt-get install -y "$app"
    fi
done
pip3 install --user dbus-python
sudo add-apt-repository ppa:atareao/atareao
sudo apt update
sudo apt install cpu-g
