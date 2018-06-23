#!/bin/bash

# shellcheck disable=SC2034
declare -f assertConfirmation &>/dev/null ||  source "$HOME/.dotfiles/install/declarations.sh"

#sudo apt-get -y remove openjdk-8*
packages=( build-essential gcc g++ gdb make nodejs npm git dconf-cli \
    unattended-upgrades unzip shellcheck xdotool ruby python3 hddtemp \
    lm-sensors curl ubuntu-restricted-extras lftp zsh \
    whois net-tools openjdk-8-jdk openjdk-8-jre fpc-3.0.2 \
    python python-setuptools python-pip python-dev python-mysqldb )
for app in "${packages[@]}" ; do
    if ! command_exists "$app"  &&  \
        assertConfirmation "Install $app?"
    then
    sudo apt-get install -y "$app"
    fi
done
echo "========================================================================"

if ! command_exists pfc  &&  [ -d ~/Dropbox/install/pasfc ]; then
    sudo cp -r ~/Dropbox/install/pasfc /usr/local/lib
    sudo ln -s /usr/local/lib/pasfc/bin/* /usr/local/bin
fi

#if ! command_exists junit; then
    #mkdir -p ~/tmp
    #cd ~/tmp
    # TODO: This download has to be done manually
    #wget "https://sourceforge.net/projects/junit/files/latest/download?source=files"
    #JUNIT_HOME=/usr/share/java
    # unzip junit.zip
    # mv junit* junit
    # mv junit /usr/share/java
    #export CLASSPATH=$CLASSPATH:$JUNIT_HOME/junit:.
#fi

if ! command_exists clang  &&  assertConfirmation "Install clang?"; then

    source "$INSTALL/clang-install"
    echo "========================================================================"
fi

if ! command_exists mono  &&  assertConfirmation "Install mono?"; then

    source "$INSTALL/mono-install"
fi

#if [ ! -d /usr/local/go ]  &&  assertConfirmation "Install go?"; then
#    source "$INSTALL/go-install"
#fi

if ! command_exists tsc  &&  assertConfirmation "Install TypeScript standalone server?"; then
    sudo npm install -g typescript
fi

if ! command_exists rustc  &&  assertConfirmation "Install rustc?"; then
    curl https://sh.rustup.rs -sSf | sh
    source "$HOME/.cargo/env"
fi

if ! command_exists php  &&  assertConfirmation "Install apache2, php7, mysql-server?"; then
    if ! service apache2 restart && ! service mysql restart; then
        source "$INSTALL/lamp-install"
    fi
fi

if ! command_exists hashcat  &&  assertConfirmation "Install kali linux tools?"; then
    source "$INSTALL/katoolin"
fi

if ! (( ${autoConfirm:?} )); then
    clear
    read -n 1 -p "Install cs50 functions? (yes/No) "
    printf '\n========================================================================'
    if [[ $REPLY =~ ^([Yy]|[Ss])$ ]]; then
        source "$INSTALL/cs50"
    fi
fi
