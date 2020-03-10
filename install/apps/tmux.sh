#!/bin/bash

TMUX_VERSION=2.9
LIBEVENT=2.1.8
NCURSES=6.1
TMUX_FILE=tmux-$TMUX_VERSION.tar.gz

declare -f assertConfirmation &>/dev/null ||  . "$HOME/.dotfiles/install/declarations.sh"

# Try package manager first
sudo apt-get -y install --install-recommends tmux

if ! command_exists tmux; then
    packages=( automake build-essential pkg-config libevent-dev libncurses5-dev )
    for app in "${packages[@]}" ; do
        ! command_exists "$app"  &&  sudo apt install -y "$app"
    done

    # create our directories
    mkdir -p $HOME/tmp
    cd $HOME/tmp

    ############
    # libevent #
    ############

    FILE=libevent-$LIBEVENT-stable
    wget https://github.com/libevent/libevent/releases/download/release-$LIBEVENT-stable/$FILE.tar.gz
    tar xvzf $FILE.tar.gz
    cd $FILE
    ./configure --prefix=/usr/local
    make
    sudo make install
    cd ..

    ############
    # ncurses  #
    ############
    wget http://ftp.gnu.org/gnu/ncurses/ncurses-$NCURSES.tar.gz
    tar xvzf ncurses-$NCURSES.tar.gz
    cd ncurses-$NCURSES
    ./configure --prefix=/usr/local
    make
    sudo make install
    cd ..

    ############
    # tmux     #
    ############
    wget https://github.com/tmux/tmux/releases/download/$TMUX_VERSION/$TMUX_FILE
    tar xvzf tmux-${TMUX_VERSION}.tar.gz
    cd tmux-${TMUX_VERSION}
    sh autogen.sh
    ./configure && make
    sudo make install
    cd ~

    rm -rf $HOME/tmp
fi

echo "========================================================================"
echo "Tmux installed"
echo "========================================================================"
