#!/bin/bash

source "$HOME/.dotfiles/install/declarations"

# http://askubuntu.com/questions/814/how-to-run-scripts-on-start-up
# http://askubuntu.com/questions/228304/how-do-i-run-a-script-at-start-up
# http://superuser.com/questions/685471/how-can-i-run-a-command-after-boot
if [ ! -f $HOME.config/autostart/xflux.desktop ]  &&  \
  assertConfirmation "Execute xflux at startup?" "${autoConfirm:?}"; then
    [ -d "$HOME/.config/autostart" ]  ||  mkdir -p "$HOME/.config/autostart"
    if [[ ! -f $HOME/.config/autostart/xflux.desktop ]]; then
      cat << EOF > $HOME/.config/autostart/xflux.desktop
      [Desktop Entry]
      Name=xflux
      Exec=$DOTFILES/bin/night
      Type=Application
      X-GNOME-Autostart-Delay=30
EOF
    fi
    echo "========================================================================"
    echo "Created xflux startup application"
    echo "========================================================================"
fi


if assertConfirmation "Configure workspaces?" "${autoConfirm:?}"; then
    echo "Configure workspaces to be created at startup"
    echo "========================================================================"
    sudo apt-get install -y wmctrl
    [ -f "$DOTFILES/bin/workspaces" ]  &&  workspaces
        if [[ ! -f $HOME/.config/autostart/workspaces.desktop ]]; then
            cat << EOF > $HOME/.config/autostart/workspaces.desktop
            [Desktop Entry]
            Name=workspaces
            Exec=$DOTFILES/bin/workspaces
            Type=Application
            X-GNOME-Autostart-Delay=60
EOF
    fi
    echo "========================================================================"
    echo "Created workspaces startup application"
    echo "========================================================================"
fi

