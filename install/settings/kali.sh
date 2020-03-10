#!/bin/bash

# shellcheck disable=SC2034
declare -f assertConfirmation &>/dev/null ||  source "$HOME/.dotfiles/install/declarations.sh"

# Create non root user
adduser user --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
echo "user:admin" | sudo chpasswd
adduser user sudo

# Install tor browser, TODO: this has to be done as a non-root user
sudo apt-get -y install tor
[ -d ~/tmp ]  ||  mkdir ~/tmp
cd ~/tmp
version="6.5.2"
link=https://www.torproject.org/dist/torbrowser/$version/
file=tor-browser-linux$MACHINE_TYPE-$version_en-US
wget $link$file.tar.xz
tar -xzvf $file.tar.xz
mv $file ~

dconf write /org/gnome/desktop/interface/enable-animations false
dconf write /org/gnome/desktop/interface/text-scaling-factor 1.25
dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:swapescape', 'terminate:ctrl_alt_bksp']"
dconf write /org/gnome/shell/overrides/dynamic-workspaces false
dconf write /org/gnome/desktop/session/idle-delay "uint32 0"
dconf write /gnome/desktop/peripherals/mouse/speed 1.0
dconf write /org/gnome/desktop/notifications/show-in-lock-screen false
dconf write /org/gnome/desktop/notifications/show-banners false

#### Terminal
profile="$(dconf dump / |grep /legacy/profiles:/ |sed -r 's/^\[|\]$//g' |head -n1)"
dconf write $profile/audible-bell false
dconf write $profile/use-transparent-background false
if [ -f ~/.local/share/fonts/Hack-Regular.ttf ]; then
  dconf write $profile/use-system-font false
  dconf write $profile/font "'Hack 14'"
fi
# Onedark

# Solarzed
#dconf write $profile/palette "['rgb(7,54,66)', 'rgb(220,50,47)', 'rgb(133,153,0)', \
#        'rgb(181,137,0)', 'rgb(38,139,210)', 'rgb(211,54,130)', 'rgb(42,161,152)', \
#        'rgb(238,232,213)', 'rgb(0,43,54)', 'rgb(203,75,22)', 'rgb(88,110,117)', \
#        'rgb(101,123,131)', 'rgb(131,148,150)', 'rgb(108,113,196)', 'rgb(147,161,161)', 'rgb(253,246,227)']"
dconf write /org/gnome/nm-applet/disable-disconnected-notifications true
dconf write /org/gnome/nm-applet/disable-connected-notifications true

# Make Terminal Shortcut open in FullScreen
sudo cat << EOF > /usr/share/applications/terminal-fullscreen.desktop
[Desktop Entry]
Type=Application
Terminal=false
Name=Gnome Terminal
GenericName=Terminal
Exec=gnome-terminal --window --full-screen
Comment=Opens Gnome-Termnal in Fullscreen
Icon=gnome-terminal
EOF
dconf write /org/gnome/shell/favorite-apps "['terminal-fullscreen.desktop', 'firefox-esr.desktop', \
    'org.gnome.Nautilus.desktop', 'kali-msfconsole.desktop', \
    'kali-armitage.desktop', 'kali-burpsuite.desktop', \
    'kali-beef.desktop', 'kali-faraday.desktop', 'leafpad.desktop', \
    'gnome-tweak-tool.desktop']"

if [ ! -f "$HOME/.config/autostart" ]; then
  [ -d "$HOME/.config/autostart" ]  ||  mkdir -p "$HOME/.config/autostart"
  sudo cat << EOF > /usr/share/applications/gnome-terminal.desktop
  [Desktop Entry]
  Type=Application
  Name=xset
  GenericName=xset
  Exec=key-repeat
  Comment=Change key repeat speed
  X-GNOME-Autostart-Delay=10
EOF
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/binding \
  "'<Primary><Alt>t'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/name \
  "'Terminal'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/command \
  "'gnome-terminal --window --full-screen'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings \
  "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
