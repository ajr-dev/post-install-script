#!/bin/bash

# shellcheck disable=SC2034
declare -f assertConfirmation &>/dev/null ||  source "$HOME/.dotfiles/install/declarations.sh"

ver=3.7.4

sudo rm -f /usr/local/bin/python3.7
sudo rm -f /usr/local/bin/pip3.7
sudo rm -f /usr/local/bin/pydoc
sudo rm -rf /usr/local/bin/include/python3.7
sudo rm -f /usr/local/lib/libpython3.7.a
sudo rm -rf /usr/local/lib/python3.7

# update system
sudo apt update && sudo apt upgrade -y

# install build tools and python prerequisites
packages=( 
build-essential checkinstall zlib1g zlib1g-dev openssl libreadline-dev \
    libreadline-gplv2-dev libsqlite3-dev libgdbm-dev libdb5.3-dev libbz2-dev \
    libexpat1-dev liblzma-dev tk-dev libffi-dev libssl-dev libncurses5-dev \
    libncursesw5-dev libc6-dev blt-dev docutils-common libbluetooth-dev \
    libdb-dev libmpdec-dev libxss-dev net-tools python-babel-localedata \
    python3-alabaster python3-babel python3-docutils python3-imagesize \
    python3-jinja2 python3-markupsafe python3-pygments python3-roman \
    python3-sphinx python3-tz sphinx-common tcl-dev tcl8.6-dev time \
    tk8.6-blt2.5 tk8.6-dev x11proto-scrnsaver-dev xvfb python-virtualenv
 )
for app in "${packages[@]}" ; do
    sudo apt-get install -y "$app"
done

# download and extract python
wget https://www.python.org/ftp/python/$ver/Python-$ver.tar.xz
tar xf Python-$ver.tar.xz
rm Python-$ver.tar.xz
cd Python-$ver

# build python, to install locally add --prefix=$HOME/bin/python
./configure --enable-optimizations
# 'make -j <x>' enables parallel execution of <x> make recipes simultaneously
sudo make -j 8
# altinstall does not alter original system python install
sudo make altinstall

# run python3.7.4 when you type python3
sudo update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3.7 1
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 2
# run below and select python3.7.4 from the list
sudo update-alternatives --config python3

# or create a shortcut
sudo ln -s /usr/local/bin/python3.7 /usr/bin/py

apt-get remove --purge python-pip
wget --no-check-certificate https://bootstrap.pypa.io/get-pip.py -O - | python - --user
