#!/bin/bash

source "$HOME/.dotfiles/install/declarations.sh"

# If your system is 64 bit, enable 32 bit architecture (if you haven't already): 
if [ "$ARCH" = "64" ]; then
    sudo dpkg --add-architecture i386 
fi

# Download and add the repository key: 
wget -qO - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -

# Add the repository: 
sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main' 
sudo apt update

sudo apt install -y --install-recommends winehq-stable
