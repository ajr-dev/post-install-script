#!/bin/bash

# shellcheck disable=SC2034
declare -f assertConfirmation &>/dev/null ||  source "$HOME/.dotfiles/install/declarations.sh"

if sudo -v; then
    packages=( vim-gtk curl cmake xclip keepassx zsh )
    for app in "${packages[@]}" ; do
        if ! command_exists $app; then
            sudo apt-get -y install "$app"
        fi
    done
fi

if [[ ! -d ~/.config/nvim/ ]]; then
    source "$INSTALL/link-setup.sh"
fi

# TODO: fix check to only perform once
if ! [ -f ~/.gitconfig ]  &&  assertConfirmation "¿Configure git?" "${autoConfirm:?}"; then
    source "$INSTALL/git-setup.sh"
fi

if assertConfirmation "Import local config?" "${autoConfirm:?}"
then
    [ -f ~/.dotfiles/local.vim ]  &&  cp ~/.dotfiles/local.vim ~/.local.vim
    [ -f ~/.dotfiles/local.zsh ]  &&  cp ~/.dotfiles/local.zsh ~/.local.zsh
    [ -f ~/.dotfiles/local.tmux ]  &&  cp ~/.dotfiles/local.tmux ~/.local.tmux
fi

if ! command_exists tmux  ||  [[ "$(tmux -V)" != *"2.6"* ]]  &&  assertConfirmation "Install tmux?"; then
    source "$DOTFILES/install/tmux-install.sh"
fi

if ! command_exists  nvim  &&  assertConfirmation "Install neovim?" "${autoConfirm:?}"; then
    source "$INSTALL/apps/neovim-install.sh"
fi

if command_exists zsh  &&  ! [[ $SHELL =~ .*zsh.* ]]  && \
    assertConfirmation "Change default shell to zsh?" "${autoConfirm:?}"
then
    echo "Configuring zsh as default shell"
    chsh -s "$(which zsh)"

    if ! command_exists zplug; then
        echo "installing zplug, a plugin manager for zsh - http://zplug.sh"
        git clone https://github.com/zplug/zplug ~/.zplug
    fi
fi

# https://askubuntu.com/questions/283908/how-can-i-install-and-use-powerline-plugin
if ! font_installed SourceCodePro; then
    source "$INSTALL/settings/source-code-pro-font-install.sh"
fi

if [[ $DESKTOP == "gnome" ]]  ||  [[ $DESKTOP == "xubuntu" ]]  || \
   [[ $DESKTOP == "cinnamon" ]]  ||  [[ $DESKTOP == "mate" ]]  || \
   [[ $DESKTOP == "kali" ]]  &&  assertConfirmation "Change system settings?" "${autoConfirm:?}"
then
    if [[ $DESKTOP == "gnome" ]]; then
        source "$INSTALL/settings/gnome-settings.sh"
    elif [[ $DESKTOP == "xubuntu" ]]; then
        source "$INSTALL/settings/xubuntu-settings.sh"
    elif [[ $DESKTOP == "cinnamon" ]]; then
        source "$INSTALL/settings/cinnamon-settings.sh"
    elif [[ $DESKTOP == "mate" ]]; then
        source "$INSTALL/settings/mate-settings.sh"
    elif [[ $DESKTOP == "kali" ]]; then
        source "$INSTALL/settings/kali-settings.sh"
    fi
fi

# TODO: check if already done
if assertConfirmation "Unattended upgrades?" "${autoConfirm:?}"; then
    source "$INSTALL/settings/unattended-upgrades.sh"
fi

# TODO: this isn't working. Fix if already done
if assertConfirmation "Never ask for passwords?"; then
    source "$INSTALL/settings/no-password-prompt.sh"
fi

# Check if all files from Dropbox have already been copied
if [ -d ~/Dropbox ]  &&  assertConfirmation "Copy dropbox files to system?"; then
    source "$INSTALL/setup/dropbox-setup.sh"
fi
