#!/bin/bash

declare -f assertConfirmation &>/dev/null ||  . "$HOME/.dotfiles/install/declarations.sh"

if [[ $DESKTOP == "gnome" ]]  ||  [[ $DESKTOP == "xubuntu" ]]  || \
   [[ $DESKTOP == "cinnamon" ]]  ||  [[ $DESKTOP == "mate" ]]  || \
   [[ $DESKTOP == "kali" ]]  &&  assertConfirmation "Change system settings?" "${autoConfirm:?}"
then
    if [[ $DESKTOP == "gnome" ]]; then
        . "$INSTALL/settings/gnome.sh"
    elif [[ $DESKTOP == "xubuntu" ]]; then
        . "$INSTALL/settings/xubuntu.sh"
    elif [[ $DESKTOP == "cinnamon" ]]; then
        . "$INSTALL/settings/cinnamon.sh"
    elif [[ $DESKTOP == "mate" ]]; then
        . "$INSTALL/settings/mate.sh"
    elif [[ $DESKTOP == "kali" ]]; then
        . "$INSTALL/settings/kali.sh"
    fi
fi

if sudo -v; then
    packages=( vim-gtk curl cmake xclip keepassx redshift zsh dropbox ppa-purge neovim )
    for app in "${packages[@]}" ; do
        if ! command_exists "$app"; then
            sudo apt-get -y install --install-recommends "$app"
        fi
    done
fi

# https://askubuntu.com/questions/283908/how-can-i-install-and-use-powerline-plugin
if ! font_installed SourceCodePro; then
    . "$INSTALL/settings/source-code-pro-font-install.sh"
fi

# Enable install recommends by default
[ ! -f /etc/apt/apt.conf.d/00recommends.disabled ]  &&  sudo mv /etc/apt/apt.conf.d/00recommends /etc/apt/apt.conf.d/00recommends.disabled
[ ! -f /etc/apt/apt.conf.d/99synaptic.disabled ]  &&  sudo mv /etc/apt/apt.conf.d/99synaptic /etc/apt/apt.conf.d/99synaptic.disabled

# Install for Dropbox to work
sudo apt-get install -y python3-gpg
sudo apt-get install -y python3-gpg
dropbox start -i # Auto install dropbox

# Link the configuration files
[ ! -d ~/.config/nvim/ ]  &&  . "$INSTALL/setup/link.sh"

# TODO: only ask the first time perform once
if ! [ -f ~/.gitconfig ]  &&  assertConfirmation "¿Configure git?" "${autoConfirm:?}"; then
    . "$INSTALL/setup/git.sh"
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"  &&  rm "$HOME/.zshrc"  &&  \
	mv "$HOME/.zshrc.pre-oh-my-zsh" "$HOME/.zshrc"

if assertConfirmation "Import local config?" "${autoConfirm:?}"
then
    [ -f ~/.dotfiles/local.vim ]  &&  cp ~/.dotfiles/local.vim ~/.local.vim
    [ -f ~/.dotfiles/local.zsh ]  &&  cp ~/.dotfiles/local.zsh ~/.local.zsh
    [ -f ~/.dotfiles/local.tmux ]  &&  cp ~/.dotfiles/local.tmux ~/.local.tmux
fi

if ! command_exists tmux  &&  assertConfirmation "Install tmux?"; then
    . "$INSTALL/setup/tmux.sh"
fi

if ! command_exists  nvim  &&  assertConfirmation "Install neovim?" "${autoConfirm:?}"; then
    . "$INSTALL/apps/neovim.sh"
fi

# Setup ZSH
if ! [[ $SHELL =~ .*zsh.* ]]  &&  assertConfirmation "Change default shell to zsh?" "${autoConfirm:?}"
then
    wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
    sh install --keep-zshrc
    if ! command_exists zplug; then
        echo "installing zplug, a plugin manager for zsh - http://zplug.sh"
        [ ! -d ~/.zplug ]  &&  git clone https://github.com/zplug/zplug ~/.zplug
    fi
fi

if [ ! -f /etc/sudoers.bak ]  &&  assertConfirmation "Never ask for passwords?"; then
    . "$INSTALL/settings/no-password-prompt.sh"
fi

# TODO: check if already done
if assertConfirmation "Unattended upgrades?" "${autoConfirm:?}"; then
    . "$INSTALL/settings/unattended-upgrades.sh"
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
