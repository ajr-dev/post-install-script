#!/bin/bash

VERSION=3.1b
LIBEVENT=2.1.11
NCURSES_VERSION=6.2
TMUX_FILE=tmux-$VERSION.tar.gz

declare -f assertConfirmation &>/dev/null ||  . "$HOME/.dotfiles/install/declarations.sh"

# Try package manager first
# sudo apt-get -y install --install-recommends tmux
CURRENT=$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9])?).*/\1/p")

if [ ! command_exists tmux] || (( CURRENT_VERSION < VERSION )); then
    sudo apt-get remove -y tmux

    packages=( wget tar automake build-essential bison pkg-config libevent-dev libncurses5-dev )
    for app in "${packages[@]}" ; do
        ! command_exists "$app"  &&  sudo apt install -y "$app"
    done

    mkdir -p $HOME/tmp
    cd $HOME/tmp

    wget https://github.com/tmux/tmux/releases/download/$VERSION/$TMUX_FILE
    tar xvzf tmux-${VERSION}.tar.gz
    sudo rm -rf /usr/local/src/tmux-*
    sudo mv tmux-${VERSION} /usr/local/src
    cd /usr/local/src/tmux-${VERSION}
    ./configure && make
    sudo make install
    sudo apt-get autoremove -y

    cd $HOME
    rm -rf $HOME/tmp
fi

echo "========================================================================"
echo "Tmux installed"
echo "========================================================================"
