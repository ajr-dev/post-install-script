#!/bin/bash

# shellcheck disable=SC2034
declare -f assertConfirmation &>/dev/null ||  source "$HOME/.dotfiles/install/declarations"

if ! command_exists java; then
    source "$HOME/.dotfiles/install/programming/java-install.sh"
fi

if [ "$ARCH" = "64" ]; then
    sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386
fi

sudo unzip ~/Downloads/android-studio*.zip -d /opt
rm -f ~/Downloads/android-studio*.zip
if ! grep -q "android-studio" ~/.${shell_profile}; then
    echo 'export PATH="/opt/android-studio/bin/:$PATH"' >> ~/.${shell_profile}
fi

/opt/android-studio/bin/studio.sh
