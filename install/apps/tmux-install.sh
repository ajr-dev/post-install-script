#!/bin/bash

# shellcheck disable=SC2034
declare -f assertConfirmation &>/dev/null ||  source "$HOME/.dotfiles/install/declarations.sh"

brew install tmux

if ! command_exists tmux; then
    packages=( automake build-essential pkg-config libevent-dev libncurses5-dev )
    for app in "${packages[@]}" ; do
        ! command_exists "$app"  &&  sudo apt install -y "$app"
    done

    rm -rf ~/tmp/tmux
    git clone https://github.com/tmux/tmux.git ~/tmp/tmux
    cd ~/tmp/tmux
    sh autogen.sh
    ./configure && make
    sudo make install
    cd -
    rm -rf ~/tmp
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
