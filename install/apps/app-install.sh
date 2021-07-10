#!/bin/bash

# shellcheck disable=SC2034
declare -f assertConfirmation &>/dev/null ||  source "$HOME/.dotfiles/install/declarations.sh"

sudo apt-get -y update

# TODO: check if not installed already
if grep -q "^flags.*\ hypervisor\ " /proc/cpuinfo  &&  assertConfirmation "Install Virtual Machine extras?"; then
    source "$INSTALL/virtual-machine.sh"
fi

if ! (( ${autoConfirm:?} )); then
    source "$INSTALL/remove-packages.sh"
fi

source "$INSTALL/install-packages.sh"

# TODO: fix jDownloader installation
#if [ ! -d ~/Downloads/jd2 ]  &&  assertConfirmation "Install jDownloader?"; then
#    source "$DOTFILES/install/jdownloader-install.sh" # TODO: Downloads may not exist.
#fi

if [ "${MACHINE_TYPE}" == 64 ]  &&  assertConfirmation "Install Google Chrome?"; then
    source "$INSTALL/apps/chrome-install.sh"
fi

if ! command_exists dropbox  &&  assertConfirmation "Install Dropbox?"; then
    sudo apt-get -y install python-gpgme dropbox

    packages=( python-gpgme python-gpg dropbox )
    for app in "${packages[@]}" ; do
        ! command_exists "$app"  &&  sudo apt install -y "$app"
    done
    dropbox start -i&
fi
