#!/bin/bash

# shellcheck disable=SC2034
declare -f assertConfirmation &>/dev/null ||  source "$HOME/.dotfiles/install/declarations.sh"

install_xflux() {
    mkdir -p ~/.bin  &&  cd ~/.bin
    if [ ! -f ~/.bin/xflux ]; then
        if [ "${MACHINE_TYPE}" == 64 ]; then file=xflux64.tgz; else file=xflux-pre.tgz; fi
        wget https://justgetflux.com/linux/$file
        tar zxvf $file
        rm $file
        mv xflux ~/.bin
    fi
}

if (( autoConfirm )); then
    install_xflux
else
    clear
    read  -n 1 -p "Install xflux? (yes/No) "
    printf '\n========================================================================'
    if [[ $REPLY =~ ^([Yy])$ ]]; then
        clear
        read -n 1 -p "Install with Graphic Interface? (yes/No) "
        printf '\n========================================================================'
        if [[ $REPLY =~ ^([Yy])$ ]]; then
            cd /tmp
            git clone "https://github.com/xflux-gui/xflux-gui.git"
            cd xflux-gui
            python download-xflux.py
            clear
            read -n 1 -p "Global install? (yes/No) "
            printf '\n========================================================================'
            if [[ $REPLY =~ ^([Yy])$ ]]; then
                sudo python setup.py install
            else # install in ~/.local/bin folder
                if [[ ":$PATH:" == *":$HOME/.local/bin:"* ]]; then
                    python setup.py install --user
                else
                    cat << EOF
                    echo "PATH=\"$HOME/.local/bin:$PATH\"" >> $HOME/.profile
EOF
                    python setup.py install --user
                fi
            fi
        else
            install_xflux
        fi
    fi
fi
