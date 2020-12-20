#!/bin/bash

source "$DOTFILES/install/declarations.sh"

if [ "$OS" = "LinuxMint" ]  &&  assertConfirmation "Essential actions for Linux Mint?"; then
    # Consider recommended packages as dependencies to install them automatically as Ubuntu does
    [ ! -f /etc/apt/apt.conf.d/00recommends.bak ]  &&  sudo mv /etc/apt/apt.conf.d/00recommends /etc/apt/apt.conf.d/00recommends.bak
    [ ! -f /etc/apt/apt.conf.d/99synaptic.bak ]    &&  sudo mv /etc/apt/apt.conf.d/99synaptic   /etc/apt/apt.conf.d/99synaptic.bak

    sudo apt-get install -y mint-meta-codecs # Install proprietary software

    # Change swap usage
    if [ ! -f /etc/sysctl.conf.bak ]; then
        sudo cp /etc/sysctl.conf /etc/sysctl.conf.bak
        if [ "$DISK" = "SSD" ]; then
            sudo tee -a /proc/sys/vm/swappiness << EOF
# Decrease swap usage to a more reasonable level
vm.swappiness=1
#
EOF
        elif (( $(echo "$RAM < 4" | bc -l) )); then
            sudo tee -a /proc/sys/vm/swappiness << EOF
# Decrease swap usage to a more reasonable level
vm.swappiness=10
#
EOF
        fi
    fi
    sudo ufw enable # enable firewall

    # Install Microsoft fonts
    sudo apt-get instal -y ttf-mscorefonts-installer

    # Disable hibernation
    [ ! -f /etc/polkit-1/localauthority/50-local.d/com.ubuntu.enable-hibernate.pkl.bak ] \
        &&  sudo mv -v /etc/polkit-1/localauthority/50-local.d/com.ubuntu.enable-hibernate.pkla \
        /etc/polkit-1/localauthority/50-local.d/com.ubuntu.enable-hibernate.pkla.bak

    # Prevent other users from accessing the files in your account
    find ~ -type d -exec chmod 700 {} \;
fi
