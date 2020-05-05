#!/bin/bash

# May not work for Linux Mint 18.3
# https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
curl -sL install-node.now.sh/lts | sudo bash
#sudo apt-get install -y nodejs
sudo npm install npm@latest -g
sudo npm install -g typescript
