#!/bing/bash

# Install Wine
# TODO: modify for each OS according to https://wiki.winehq.org/Ubuntu
sudo dpkg --add-architecture i386
wget -nc https://dl.winehq.org/wine-builds/Release.key
sudo apt-key add Release.key
#sudo apt-add-repository https://dl.winehq.org/wine-builds/ubuntu/
sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ xenial main' # for Linux Mint 18.x
sudo apt-get update
sudo apt-get install --install-recommends -y winehq-stable
WINEPREFIX="$HOME/.wine-mtgo" WINEARCH=win32 wine wineboot

# Install winetricks
wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
chmod +x winetricks
sudo mv winetricks /usr/local/bin
WINEPREFIX="$HOME/.wine-mtgo" winetricks corefonts dotnet461 ddr=gdi win7
#Select the Default WinePrefix -> Install DLL or Windows Component -> dotnet4.6.1
#It will prompt and install a lot, in the end it should correctly install net 4.6.1

# Install MTGO
wget http://mtgoclientdepot.onlinegaming.wizards.com/setup.exe
WINEPREFIX="$HOME/.wine32" wine setup.exe

# Run MTGO (you can also run with WINEPREFIX="$HOME/.wine32" winefile)
WINEPREFIX="$HOME/.wine32" wine start Magic\ The\ Gathering\ Online\ .appref-ms
