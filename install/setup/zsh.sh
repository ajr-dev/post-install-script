#!/bin/bash

declare -f assertConfirmation &>/dev/null ||  . "$HOME/.dotfiles/install/declarations.sh"

if ! command_exists zsh; then
  echo "zsh not found. Please install and then re-run installation scripts"
  exit 1
fi

# Change the default shell to zsh
zsh_path="$( command -v zsh )"
if ! grep "$zsh_path" /etc/shells; then
  echo "adding $zsh_path to /etc/shells"
  echo "$zsh_path" | sudo tee -a /etc/shells
fi

if [[ "$SHELL" != "$zsh_path" ]]; then
  chsh -s "$zsh_path"
  echo "default shell changed to $zsh_path"
fi

# Install OhMyZsh
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh install.sh --keep-zshrc

#sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"  &&  rm "$HOME/.zshrc"  &&  \
#mv "$HOME/.zshrc.pre-oh-my-zsh" "$HOME/.zshrc"

if ! command_exists zplug; then
  echo "installing zplug, a plugin manager for zsh - http://zplug.sh"
  [ ! -d ~/.zplug ]  &&  git clone https://github.com/zplug/zplug ~/.zplug
fi

echo "Done. Reload your terminal."
