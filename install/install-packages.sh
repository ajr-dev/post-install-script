#!/bin/bash

# shellcheck disable=SC2034
declare -f assertConfirmation &>/dev/null ||  source "$HOME/.dotfiles/install/declarations.sh"

if assertConfirmation "Install all extra packages?"; then
    packages=( audacity kazam geany thunderbird vlc virtualbox filezilla deluge \
            wine zenity redshift )
    if [[ "$OS" == "ArchLinux" ]]; then
        echo "Installing extra packages to Arch Linux"
        for app in "${packages[@]}" ; do
            ! command_exists "$app"  &&  sudo pacman -S --noconfirm "$app"
            ! command_exists "$app"  &&  yaourt -Sa --noconfirm "$app"
        done
    else
        for app in "${packages[@]}" ; do
            ! command_exists "$app"  &&  sudo apt-get install -y "$app"
        done
    fi
else
    clear
    read -n 1 -p "Install packages one by one? (yes/No) "
    printf '\n========================================================================'
    if [[ $REPLY =~ ^([Yy])$ ]]; then
        packages=( audacity evince kazam geany thunderbird vlc conky virtualbox filezilla \
            easytag dropbox youtube-dl git-gui steam keepassx calibre gimp audacious clementine \
            rhythmbox banshee libreoffice wine deluge )
        for app in "${packages[@]}" ; do
            if ! command_exists "$app"; then
                clear
                read -n 1 -p "Install $app? (yes/No) "
                printf '\n========================================================================'
                if [[ $REPLY =~ ^([Yy])$ ]]; then
                    sudo apt-get -y install "$app"
                    echo "========================================================================"
                fi
            fi
        done
    fi
fi
