#!/bin/bash

# shellcheck disable=SC2034
declare -f assertConfirmation &>/dev/null ||  source "$HOME/.dotfiles/install/declarations.sh"

packages=( git automake make gcc fpc libsdl2-image-dev libavformat-dev libswscale-dev
           libsqlite3-dev libfreetype6-dev portaudio19-dev libportmidi-dev liblua5.3-dev libopencv-videoio-dev )
for app in "${packages[@]}" ; do
    ! command_exists "$app"  &&  sudo apt install -y "$app"
done

mkdir -p ~/tmp
git clone https://github.com/UltraStar-Deluxe/USDX
cd USDX
./autogen.sh
./configure
make
sudo make install
cd  &&  rm -rf ~/tmp
