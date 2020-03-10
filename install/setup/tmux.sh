#!/bin/bash

declare -f assertConfirmation &>/dev/null ||  . "$HOME/.dotfiles/install/declarations.sh"

if ! command_exists tmux; then
    ". $INSTALL/apps/tmux.sh"
fi

# Italics
cd ~/.dotfiles/tmux  ||  { echo "$HOME/.dotfiles/tmux doesn't exist" ; exit ; }
if [ -f xterm-256color-italic.terminfo ]; then
    tic xterm-256color-italic.terminfo
else
    read -p "xterm-256color-italic.terminfo doesn't exist" ;
    clear
fi

mkdir -p ~/.tmux/resurrect
[ -f ~/.dotfiles/tmux/resurrect/last ]  &&  ln -s ~/.dotfiles/tmux/resurrect/last ~/.tmux/resurrect/
if [[ ! -d ~/.tmux/plugins/tpm ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
read -p "You still have to install the plugins with <Prefix>I"
clear
