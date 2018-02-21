#!/bin/bash

if [[ $DESKTOP == "gnome" ]]  ||  [[ $DESKTOP == "xubuntu" ]]  || \
   [[ $DESKTOP == "cinnamon" ]]  ||  [[ $DESKTOP == "mate" ]]  || \
   [[ $DESKTOP == "kali" ]]  &&  assertConfirmation "Change system settings?" "${autoConfirm:?}"
then
    if [[ $DESKTOP == "gnome" ]]; then
        source "$INSTALL/gnome-settings"
    elif [[ $DESKTOP == "xubuntu" ]]; then
        source "$INSTALL/xubuntu-settings"
    elif [[ $DESKTOP == "cinnamon" ]]; then
        source "$INSTALL/cinnamon-settings"
    elif [[ $DESKTOP == "mate" ]]; then
        source "$INSTALL/mate-settings"
    elif [[ $DESKTOP == "kali" ]]; then
        source "$INSTALL/kali-settings"
    fi
fi
