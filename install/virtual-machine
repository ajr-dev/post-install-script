#!/bin/bash

# virtual machine https://unix.stackexchange.com/a/32605/96101
sudo apt-get -y install dkms "linux-headers-$(uname -r)"
command_exists zenity  ||  sudo apt-get -y install zenity
zenity --info --text "Insert Guest Additions CD Image"
# TODO: allow user to insert cd path
cdPath=/media/cdrom0
if [ ! -d $cdPath ]; then
echo "No CD found"
exit
fi
# TODO: allow user to insert executable path
additions=VBoxLinuxAdditions
cp $cdPath/$additions.run ~ || { echo "No executable"; exit; }
~/$additions.run
rm ~/$additions.run
