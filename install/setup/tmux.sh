#!/bin/bash

declare -f assertConfirmation &>/dev/null ||  . "$HOME/.dotfiles/install/declarations.sh"

if ! command_exists tmux; then
    source "$INSTALL/apps/tmux.sh"
fi

mkdir -p ~/.tmux/resurrect
[ -f ~/Dropbox/.tmux-resurrect/last ]  &&  ln -s ~/Dropbox/.tmux-resurrect/last ~/.tmux/resurrect/
if [[ ! -d ~/.tmux/plugins/tpm ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
tic -x "$INSTALL/setup/xterm-256color-italic.terminfo"
tic -x "$INSTALL/setup/tmux.terminfo"
read -p "You still have to install the plugins with <Prefix>I"
