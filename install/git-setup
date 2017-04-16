#!/bin/bash

clear
printf "Configuring git...\n\n"

defaultName=$( git config --global user.name )
defaultEmail=$( git config --global user.email )
defaultGithub=$( git config --global github.user )

read -p "Name [$defaultName] " name
read -p "Email [$defaultEmail] " email
read -p "Github username [$defaultGithub] " github

git config --global user.name "${name:-$defaultName}"
git config --global user.email "${email:-$defaultEmail}"
git config --global github.user "${github:-$defaultGithub}"

if [ "$(uname)" == "Darwin" ]; then
    git config --global credential.helper 'osxkeychain'
else
    read -n 1 -p "Save user and password to an unencrypted file to avoid writing? (yes/No) "
    if [[ $REPLY =~ ^([Yy])$ ]]; then
        git config --global credential.helper 'store'
    else
        git config --global credential.helper 'cache --timeout=3600'
    fi
fi
