#!/bin/bash

declare -f assertConfirmation &>/dev/null ||  . "$HOME/.dotfiles/install/declarations.sh"

if [[ $DESKTOP == "gnome" ]]  ||  [[ $DESKTOP == "xubuntu" ]]  || \
   [[ $DESKTOP == "cinnamon" ]]  ||  [[ $DESKTOP == "mate" ]]  || \
   [[ $DESKTOP == "kali" ]]  &&  assertConfirmation "Change system settings?" "${autoConfirm:?}"
then
    if [[ $DESKTOP == "gnome" ]]; then
        source "$INSTALL/settings/gnome.sh"
    elif [[ $DESKTOP == "xubuntu" ]]; then
        source "$INSTALL/settings/xubuntu.sh"
    elif [[ $DESKTOP == "cinnamon" ]]; then
        source "$INSTALL/settings/cinnamon.sh"
    elif [[ $DESKTOP == "mate" ]]; then
        source "$INSTALL/settings/mate.sh"
    elif [[ $DESKTOP == "kali" ]]; then
        source "$INSTALL/settings/kali.sh"
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

if ! font_installed SourceCodePro  &&  assertConfirmation "Install SourceCodePro?" "${autoConfirm:?}"; then
    source "$INSTALL/settings/source-code-pro.sh"
fi

# Enable install recommends by default
[ ! -f /etc/apt/apt.conf.d/00recommends.disabled ]  &&  sudo mv /etc/apt/apt.conf.d/00recommends /etc/apt/apt.conf.d/00recommends.disabled
[ ! -f /etc/apt/apt.conf.d/99synaptic.disabled ]  &&  sudo mv /etc/apt/apt.conf.d/99synaptic /etc/apt/apt.conf.d/99synaptic.disabled

# Install for Dropbox to work
sudo apt-get install -y python3-gpg
sudo apt-get install -y python3-gpg
dropbox start -i # Auto install dropbox

# Link the configuration files
[ ! -d ~/.config/nvim/ ]  &&  source "$INSTALL/setup/link.sh"

# TODO: check if already done
if ! [ -f ~/.gitconfig ]  &&  assertConfirmation "Configure git?" "${autoConfirm:?}"; then
    source "$INSTALL/setup/git.sh"
fi

# Setup ZSH
source "$INSTALL/setup/zsh.sh"

if assertConfirmation "Import local config?" "${autoConfirm:?}"
then
    [ -f ~/.dotfiles/local.vim ]  &&  cp ~/.dotfiles/local.vim ~/.local.vim
    [ -f ~/.dotfiles/local.zsh ]  &&  cp ~/.dotfiles/local.zsh ~/.local.zsh
    [ -f ~/.dotfiles/local.tmux ]  &&  cp ~/.dotfiles/local.tmux ~/.local.tmux
fi

if ! command_exists tmux  &&  assertConfirmation "Install tmux?"; then
    source "$INSTALL/setup/tmux.sh"
fi

if ! command_exists  nvim  &&  assertConfirmation "Install neovim?" "${autoConfirm:?}"; then
    source "$INSTALL/apps/neovim.sh"
fi

if [ ! -f /etc/sudoers.bak ]  &&  assertConfirmation "Never ask for passwords?"; then
    source "$INSTALL/settings/no-password-prompt.sh"
fi

# TODO: check if already done
if assertConfirmation "Unattended upgrades?" "${autoConfirm:?}"; then
    source "$INSTALL/settings/unattended-upgrades.sh"
fi

# Install Homebrew
if ! command_exists brew  &&  assertConfirmation "Install Homebrew?" "${autoConfirm:?}"; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> /home/user/.zprofile
fi

# Install Nix Package Manager
if ! command_exists nix-env  &&  assertConfirmation "Install Nix Package Manager?" "${autoConfirm:?}"; then
    curl https://nixos.org/nix/install | sh
    source ~/.nix-profile/etc/profile.d/nix.sh
fi

# Install Snappy Package Manager
if ! command_exists snap  &&  assertConfirmation "Install snap Package Manager?" "${autoConfirm:?}"; then
    sudo apt-get install python-tk python-setuptools ipython
    sudo python -m easy_install -U snappy
    python -m snappy.app
fi
