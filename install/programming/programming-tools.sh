#!/bin/bash

# shellcheck disable=SC2034
declare -f assertConfirmation &>/dev/null ||  . "$HOME/.dotfiles/install/declarations.sh"

#sudo apt-get -y remove openjdk-8*
packages=( build-essential gcc g++ gdb make nodejs npm git dconf-cli \
    unattended-upgrades unzip shellcheck xdotool ruby python3 hddtemp \
    lm-sensors curl ubuntu-restricted-extras lftp zsh whois net-tools \
    openjdk-8-jdk openjdk-8-jre fpc-3.0.2 python python-setuptools \
    python-pip python3-pip python-dev python-mysqldb )
for app in "${packages[@]}" ; do
    if ! command_exists "$app"  &&  \
        assertConfirmation "Install $app?"
    then
        sudo apt-get install -y "$app"
    fi
done
sudo pip install selenium
pip3 install --upgrade setuptools 

echo "========================================================================"

if ! command_exists clang  &&  assertConfirmation "Install clang?"; then
    . "$INSTALL/programming/clang.sh"
    echo "========================================================================"
fi

if ! command_exists mono  &&  assertConfirmation "Install mono?"; then
    . "$INSTALL/programming/mono.sh"
fi

#if [ ! -d /usr/local/go ]  &&  assertConfirmation "Install go?"; then
#    . "$INSTALL/go.sh"
#fi

if ! command_exists tsc  &&  assertConfirmation "Install TypeScript standalone server?"; then
    sudo npm install -g typescript
fi

if ! command_exists rustc  &&  assertConfirmation "Install rustc?"; then
    curl https://sh.rustup.rs -sSf | sh
    . "$HOME/.cargo/env"
fi

if ! command_exists php  &&  assertConfirmation "Install apache2, php7, mysql-server?"; then
    if ! service apache2 restart && ! service mysql restart; then
        . "$INSTALL/programming/lamp.sh"
    fi
fi

#if ! command_exists hashcat  &&  assertConfirmation "Install kali linux tools?"; then
    #. "$INSTALL/programming/katoolin.py"
#fi

if ! (( ${autoConfirm:?} )); then
    clear
    read -n 1 -p "Install cs50 functions? (yes/No) "
    printf '\n========================================================================'
    if [[ $REPLY =~ ^([Yy]|[Ss])$ ]]; then
        . "$INSTALL/programming/cs50.sh"
    fi
fi
