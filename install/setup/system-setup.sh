#!/bin/bash

# shellcheck disable=SC2034
declare -f assertConfirmation &>/dev/null ||  . "$HOME/.dotfiles/install/declarations.sh"

[ -f /etc/apt/apt.conf.d/00recommends ]  &&  sudo mv /etc/apt/apt.conf.d/00recommends /etc/apt/apt.conf.d/00recommends.disabled
[ -f /etc/apt/apt.conf.d/99synaptic ]  &&  sudo mv /etc/apt/apt.conf.d/99synaptic /etc/apt/apt.conf.d/99synaptic.disabled

if sudo -v; then
    packages=( vim-gtk curl cmake xclip keepassx redshift zsh dropbox ppa-purge neovim )
    for app in "${packages[@]}" ; do
        if ! command_exists $app; then
            sudo apt-get -y install --install-recommends "$app"
        fi
    done
fi

[ ! -d ~/.config/nvim/ ]  &&  . "$INSTALL/setup/link-setup.sh"

# TODO: fix check to only perform once
if ! [ -f ~/.gitconfig ]  &&  assertConfirmation "¿Configure git?" "${autoConfirm:?}"; then
    . "$INSTALL/setup/git-setup.sh"
fi

if assertConfirmation "Import local config?" "${autoConfirm:?}"
then
    [ -f ~/.dotfiles/local.vim ]  &&  cp ~/.dotfiles/local.vim ~/.local.vim
    [ -f ~/.dotfiles/local.zsh ]  &&  cp ~/.dotfiles/local.zsh ~/.local.zsh
    [ -f ~/.dotfiles/local.tmux ]  &&  cp ~/.dotfiles/local.tmux ~/.local.tmux
fi

# Install Nix Package Manager
if ! command_exists nix-env  &&  assertConfirmation "¿Install Nix Package Manager?" "${autoConfirm:?}"; then
    curl https://nixos.org/nix/install | sh
    . ~/.nix-profile/etc/profile.d/nix.sh
fi

# Install Snappy Package Manager
if ! command_exists snap  &&  assertConfirmation "¿Install snap Package Manager?" "${autoConfirm:?}"; then
    sudo apt-get install python-tk python-setuptools ipython
    sudo python -m easy_install -U snappy
    python -m snappy.app
fi

if ! command_exists tmux  &&  assertConfirmation "Install tmux?"; then
    . "$INSTALL/apps/tmux-install.sh"
fi

if ! command_exists  nvim  &&  assertConfirmation "Install neovim?" "${autoConfirm:?}"; then
    . "$INSTALL/apps/neovim-install.sh"
fi

if command_exists zsh  &&  ! [[ $SHELL =~ .*zsh.* ]]  && \
    assertConfirmation "Change default shell to zsh?" "${autoConfirm:?}"
then
    echo "Configuring zsh as default shell"
    chsh -s "$(which zsh)"

    if [ ! -d ~/.zplug ]; then
        echo "installing zplug, a plugin manager for zsh - http://zplug.sh"
        git clone https://github.com/zplug/zplug ~/.zplug
    fi
fi

# https://askubuntu.com/questions/283908/how-can-i-install-and-use-powerline-plugin
if ! font_installed SourceCodePro; then
    . "$INSTALL/settings/source-code-pro-font-install.sh"
fi

if [[ $DESKTOP == "gnome" ]]  ||  [[ $DESKTOP == "xubuntu" ]]  || \
   [[ $DESKTOP == "cinnamon" ]]  ||  [[ $DESKTOP == "mate" ]]  || \
   [[ $DESKTOP == "kali" ]]  &&  assertConfirmation "Change system settings?" "${autoConfirm:?}"
then
    if [[ $DESKTOP == "gnome" ]]; then
        . "$INSTALL/settings/gnome-settings.sh"
    elif [[ $DESKTOP == "xubuntu" ]]; then
        . "$INSTALL/settings/xubuntu-settings.sh"
    elif [[ $DESKTOP == "cinnamon" ]]; then
        . "$INSTALL/settings/cinnamon-settings.sh"
    elif [[ $DESKTOP == "mate" ]]; then
        . "$INSTALL/settings/mate-settings.sh"
    elif [[ $DESKTOP == "kali" ]]; then
        . "$INSTALL/settings/kali-settings.sh"
    fi
fi

# TODO: check if already done
if assertConfirmation "Unattended upgrades?" "${autoConfirm:?}"; then
    . "$INSTALL/settings/unattended-upgrades.sh"
fi

if [ ! -f /etc/sudoers.bak ]  &&  assertConfirmation "Never ask for passwords?"; then
    . "$INSTALL/settings/no-password-prompt.sh"
fi

# TODO: Check if all files from Dropbox have already been copied
if [ -d ~/Dropbox ]  &&  assertConfirmation "Copy dropbox files to system?"; then
    . "$INSTALL/setup/dropbox-setup.sh"
fi
