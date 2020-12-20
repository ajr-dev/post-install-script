#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "$DIR/../declarations.sh"

# TODO: check if already installed
mkdir -p ~/tmp  &&  cd ~/tmp
git clone https://github.com/powerline/fonts
cd fonts || { echo "Fonts directory doesn't exist" ; exit ; }
./install.sh
cd  &&  rm -rf ~/tmp

if ! font_installed Hack
then
  wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
  mkdir -p ~/.fonts/ && mv PowerlineSymbols.otf ~/.fonts/
  fc-cache -vf ~/.fonts
  mkdir -p ~/.config/fontconfig/conf.d/ && mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
fi
