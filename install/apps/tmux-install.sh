#!/bin/bash

brew install tmux

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
