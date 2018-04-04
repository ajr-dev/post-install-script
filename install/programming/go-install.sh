#!/bin/bash

# shellcheck disable=SC2034
declare -f assertConfirmation &>/dev/null ||  source "$HOME/.dotfiles/install/declarations"

goVersion="1.10"

if [ -d "$HOME/.go" ] || [ -d "$HOME/go" ] || [ -d "$HOME/code/go" ]; then
    echo "The 'go' directory already exists. Exiting."
    exit 1
fi

if [ "$ARCH" = "32" ]; then localArch="386"; else localArch="amd64"; fi
[[ $OS == *"linux"* ]]  &&  localOS="linux"
DFILE="go$goVersion.$localOS-$localArch.tar.gz"
goURL="https://dl.google.com/go/$DFILE"

if [ ! -d /usr/local/go ]; then
    wget "$goURL" -O /tmp/go.tar.gz  ||  \
        { echo "Couldn't download go" ; exit ; }
    sudo tar -C /usr/local/ -zxvf /tmp/go.tar.gz
    rm -f /tmp/go.tar.gz
fi

if [ -f /etc/profile ]  &&  ! grep -q "/usr/local/go" /etc/profile; then
    echo 'export PATH=$PATH:/usr/local/go/bin' | sudo tee -a /etc/profile
fi
if ! grep -q "/usr/local/go" ~/.${shell_profile}; then
    mkdir -p ~/code/go
    {
        echo '# GoLang'
        echo 'export GOROOT=/usr/local/go'
        echo 'export PATH=$PATH:$GOROOT/bin'
        echo 'export GOPATH=$HOME/code/go'
        echo 'export PATH=$PATH:$GOPATH/bin'
    } >> ~/.${shell_profile}
fi
