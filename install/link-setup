#!/bin/bash

DOTFILES=$HOME/.dotfiles

clear
echo -e "\nCreating symlinks"
linkables=$( find -H "$DOTFILES" -maxdepth 3 -name '*.symlink' )
for file in $linkables ; do
    target=$HOME/.$( basename "$file" '.symlink' )
    [ -f "$target" ]  &&  echo "Removing $target"  &&  rm -f "$target"
    echo "Creating symlink for $file in $target"
    ln -s "$file" "$target"
done

echo -e "\n\ninstalling to ~/.config"
if [ ! -d "$HOME/.config" ]; then
    echo "Creating ~/.config"
    mkdir -p "$HOME/.config"
fi

for config in $DOTFILES/config/*; do
    target=$HOME/.config/$( basename "$config" )
    if [ -f "$target" ]; then
        rm -f "$target"
    elif [ -d "$target" ]; then
        rm -rf "$target"
    fi
    echo "Creating symlink for $config"
    ln -s "$config" "$target"
done

echo -e "\n\nCreating vim symlinks"
echo "=============================="
mkdir -p ~/.vim  ||  echo "El directorio ya existe"
[ -f ~/.vim/vimrc ]  &&  rm -f ~/.vim/vimrc
[ -f ~/.vimrc ]      &&  rm -f ~/.vimrc
ln -s ~/.dotfiles/config/nvim/init.vim ~/.vim/vimrc  ||  echo "Error al crear enlace simbólico para vim"
