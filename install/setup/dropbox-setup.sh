#!/bin/bash

# shellcheck disable=SC2034
declare -f assertConfirmation &>/dev/null ||  source "$HOME/.dotfiles/install/declarations.sh"

# If Firefox configuration is in Dropbox copy it to your home directory
if [ -d ~/Dropbox/mozilla ]; then
  rm -rf ~/.mozilla
  ln -s ~/Dropbox/mozilla ~/.mozilla
# Create the mozilla configuration in dropbox
elif [ -d ~/Dropbox ]  &&  [ -d ~/.mozilla ]; then
    mv ~/.mozilla ~/Dropbox/mozilla
    ln -s ~/Dropbox/mozilla ~/.mozilla
fi

# Copy john configuration
ln -s ~/Dropbox/passwd ~/.john

# Copy music
if [[ "$LANG" == "en_US.UTF-8"  ||  "$LANG" == "en_UK.UTF-8" ]]; then
  music="$/Music"
elif [ "$LANG" == "es_ES.UTF-8" ]; then
  music="$/Música"
fi
if [ -z ${music+x} ]  &&  [ -d ~/Dropbox/Music ]  &&  [ -d $music ]; then
  rmdir $music # Remove only if empty
  [ ! -d $music ]  &&  ln -s ~/Dropbox/Music $music
fi
