#!/bin/bash

declare -f assertConfirmation &>/dev/null ||  . "$HOME/.dotfiles/install/declarations.sh"

echo "Installing dotfiles."

source "$INSTALL/setup/link.sh"
source "$INSTALL/setup/git.sh"
source "$INSTALL/setup/zsh.sh"

tic -x "$INSTALL/setup/xterm-256color-italic.terminfo"
tic -x "$INSTALL/setup/tmux.terminfo"
