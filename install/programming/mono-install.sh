#!/bin/bash

# Install mono http://www.mono-project.com/docs/getting-started/install/linux/
# http://stackoverflow.com/questions/4749330/how-to-test-if-string-exists-in-file-with-bash-shell

# shellcheck disable=SC2034
declare -f assertConfirmation &>/dev/null ||  source "$HOME/.dotfiles/install/declarations"

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb http://download.mono-project.com/repo/ubuntu stable-xenial main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
sudo apt-get update
sudo apt-get -y install mono-complete
