#!/bin/bash

DOTFILES=$HOME/.dotfiles

echo -e "\\nCreating symlinks"
echo "=============================="
linkables=$( find -H "$DOTFILES" -maxdepth 3 -name '*.symlink' )
for file in $linkables ; do
    target=$HOME/.$( basename "$file" '.symlink' )
    [ -f "$target" ]  &&  echo "Moving $target to $target.bck"  &&  mv "$target" "$target.bck"
    echo "Creating symlink for $file in $target"
    ln -s "$file" "$target"
done

echo -e "\\n\\ninstalling to ~/.config"
echo "=============================="
if [ ! -d "$HOME/.config" ]; then
    echo "Creating ~/.config"
    mkdir -p "$HOME/.config"
fi

config_files=$( find "$DOTFILES/config" -maxdepth 1 2>/dev/null )
for config in $config_files; do
    target="$HOME/.config/$( basename "$config" )"
    if [ -f "$target" ]; then
        rm -f "$target"
    elif [ -d "$target" ]; then
        rm -rf "$target"
    fi
    echo "Creating symlink for $config"
    ln -s "$config" "$target"
done

echo -e "\\n\\nCreating vim symlinks"
echo "=============================="
VIMFILES=( "$HOME/.vim:$DOTFILES/config/nvim"
        "$HOME/.vimrc:$DOTFILES/config/nvim/init.vim" )

for file in "${VIMFILES[@]}"; do
    KEY=${file%%:*}
    VALUE=${file#*:}
    if [ -e "${KEY}" ]; then
        echo "${KEY} already exists... skipping."
    else
        echo "Creating symlink for $KEY"
        ln -s "${VALUE}" "${KEY}"
    fi
done
