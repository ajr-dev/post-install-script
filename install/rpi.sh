#!/bin/bash

sudo apt update

# Install dependencies
packages=( git build-essential file zsh git sudo ruby curl nvim checkinstall \
           libssl-dev npm )
for app in "${packages[@]}"; do
  if ! command_exists "$app"; then
    sudo apt install -y "$app"
  fi
done

# Update node.js
sudo npm cache clean -f
sudo npm install -g n
sudo n stable
PATH="$PATH"

# Install NVM
[ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
mkdir -p "$NVM_DIR"
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.35.1/install.sh | bash || return
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

sudo npm install -g diff-so-fancy
