#!/bin/bash

# Script for installing tmux on systems where you don't have root access.
# tmux will be installed in $HOME/local/bin.
# It's assumed that wget and a C/C++ compiler are installed.

TMUX_VERSION=2.6
TMUX_FILE=tmux-$TMUX_VERSION.tar.gz

sudo apt-get -y autoremove tmux
sudo apt-get install -y exuberant-ctags cmake libevent-dev libncurses5-dev

[ ! -d ~/tmp ]  &&  mkdir ~/tmp
cd ~/tmp
wget https://github.com/tmux/tmux/releases/download/$TMUX_VERSION/$TMUX_FILE
tar -xzvf $TMUX_FILE
cd tmux-$TMUX_VERSION
./configure    ||  { echo "Error executing ./config" ; exit ; }
make           ||  { echo "Error executing make" ; exit ; }
sudo make install
rm -rf ~/tmp

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
echo "========================================================================"
