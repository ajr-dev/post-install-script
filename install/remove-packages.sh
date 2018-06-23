#!/bin/bash

# shellcheck disable=SC2034
declare -f assertConfirmation &>/dev/null ||  source "$HOME/.dotfiles/install/declarations.sh"

clear
read -n 1 -p "Remove all preinstalled packages? (yes/No) "
printf '\n========================================================================'
if [[ $REPLY =~ ^([Yy]|[Ss])$ ]]; then
    if [[ "$OS" == "elementaryOS" ]]; then
        echo "Removing unwanted packages from elementary OS"
        sudo apt-get autoremove -y empathy totem noise scratch-text-editor geary midori-granite
    elif [[ "$OS" == "LinuxMint" ]]; then
        echo "Removing unwanted packages from Linux Mint"
        sudo apt-get -y autoremove pidgin hexchat thunderbird banshee brasero simple-scan\
            tomboy transmission-gtk gnome-orca virtualbox-guest*
    elif [[ "$OS" == "Arch Linux" ]]; then
        echo "No unwanted packages on Arch Linux"
    else
        echo "Removing unwanted packages from Ubuntu"
        sudo apt-get -y autoremove rhythmbox empathy totem transmission-gtk
    fi
    echo "========================================================================"
    echo "Packages removed"
    echo "========================================================================"
else
    clear
    read -n 1 -p "Remove packages one by one? (yes/No) "
    printf '\n========================================================================'
    if [[ $REPLY =~ ^([Yy]|[Ss])$ ]]; then
        if [[ "$OS" == "elementaryOS" ]]; then
            packages=( empathy totem noise scratch-text-editor geary midori-granite )
        elif [[ "$OS" == "LinuxMint" ]]; then
            packages=( pidgin hexchat thunderbird banshee brasero simple-scan\
                xed tomboy transmission-gtk rhythmbox gnome-orca virtualbox-guest* )
        elif [[ "$OS" == "Arch Linux" ]]; then
            echo "No unwanted packages on Arch Linux"
        else
            echo "Removing unwanted packages from Ubuntu"
            packages=( rhythmbox empathy totem transmission-gtk)
        fi
        for app in "${packages[@]}" ; do
            clear
            read -n 1 -p "Uninstall $app? (Yes/no) "
            if [[ ! $REPLY =~ ^([Nn])$ ]]; then
                printf '\n========================================================================'
                sudo apt-get -y autoremove "$app"
            fi
        done
        echo "========================================================================"
        echo "Packages removed"
        echo "========================================================================"
    fi
fi
