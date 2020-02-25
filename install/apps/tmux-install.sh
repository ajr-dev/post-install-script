#!/bin/bash

TMUX_VERSION=2.9
LIBEVENT=2.1.8
NCURSES=6.1
TMUX_FILE=tmux-$TMUX_VERSION.tar.gz

# shellcheck disable=SC2034
declare -f assertConfirmation &>/dev/null ||  source "$HOME/.dotfiles/install/declarations.sh"

#brew install tmux

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

# Italics
cd ~/.dotfiles/tmux  ||  { echo "$HOME/.dotfiles/tmux doesn't exist" ; exit ; }
tic xterm-256color-italic.terminfo

mkdir -p ~/.tmux/resurrect
[ -f ~/.dotfiles/tmux/resurrect/last ]  &&  ln -s ~/.dotfiles/tmux/resurrect/last ~/.tmux/resurrect/
if [[ ! -d ~/.tmux/plugins/tpm ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "========================================================================"
echo "Tmux installed"
echo "You still have to install the plugins with <Prefix>I"
echo "========================================================================"
