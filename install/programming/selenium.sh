#!/bin/bash

GECKO_VERSION=0.24.0
CHROME_VERSION=75.0.3770.8

# shellcheck disable=SC2034
declare -f assertConfirmation &>/dev/null ||  source "$HOME/.dotfiles/install/declarations.sh"

sudo pip install python-pip
sudo pip install selenium

wget "https://github.com/mozilla/geckodriver/releases/download/v$GECKO_VERSION/geckodriver-v$GECKO_VERSION-linux$ARCH.tar.gz"
sudo sh -c "tar -x geckodriver -zf geckodriver-v$GECKO_VERSION-linux$ARCH.tar.gz -O > /usr/local/bin/geckodriver"
sudo chmod +x /usr/local/bin/geckodriver
# export PATH=$PATH:/path-to-extracted-file/.

rm geckodriver-v$GECKO_VERSION-linux$ARCH.tar.gz

wget "https://chromedriver.storage.googleapis.com/$CHROME_VERSION/chromedriver_linux64.zip"
sudo unzip chromedriver_linux64.zip -d /usr/bin/
sudo chmod +x /usr/bin/chromedriver
rm chromedriver_linux64.zip
