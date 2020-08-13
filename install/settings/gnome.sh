#!/bin/bash

dconf write /org/gnome/nm-applet/disable-disconnected-notifications true
dconf write /org/gnome/nm-applet/disable-connected-notifications true
#dconf write /org/gnome/libgnomekbd/keyboard/options "['caps\tcaps:swapescape']"
dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:swapescape']"
dconf write /org/gnome/desktop/notifications/show-in-lock-screen false
dconf write /org/gnome/desktop/screensaver/ubuntu-lock-on-suspend true

################################################################################
#### File Manager
################################################################################
dconf write /org/gnome/nautilus/preferences/always-use-location-entry true
dconf write /org/gnome/nautilus/list-view/default-visible-columns "['name', \
  'size', 'type', 'date_modified', 'owner', 'permissions']"
dconf write /org/gnome/nautilus/icon-view/default-zoom-level "'large'"
dconf write /org/gnome/nautilus/preferences/click-policy "'single'"
dconf write /org/gnome/nautilus/preferences/enable-delete true
dconf write /org/gnome/nautilus/preferences/confirm-trash false
dconf write /org/gnome/nautilus/preferences/show-image-thumbnails "'local-only'"
dconf write /org/gnome/nautilus/window-state/maximized true
dconf write /org/gnome/nautilus/window-state/start-with-sidebar false

################################################################################
#### Multimedia Player
################################################################################

################################################################################
#### Desktop
################################################################################
dconf write /org/gnome/desktop/lockdown/disable-lock-screen false
dconf write /org/gnome/desktop/lockdown/disable-user-switching true
dconf write /org/gnome/desktop/peripherals/keyboard/repeat true
dconf write /org/gnome/desktop/peripherals/keyboard/delay "uint32 200"
dconf write /org/gnome/desktop/peripherals/keyboard/repeat-interval "uint32 20"
dconf write /org/gnome/desktop/peripherals/mouse/natural-scroll false
dconf write /org/gnome/desktop/peripherals/touchpad/tap-to-click true
dconf write /org/gnome/desktop/peripherals/touchpad/edge-scrolling-enabled true
dconf write /org/gnome/desktop/peripherals/touchpad/two-finger-scrolling-enabled true
dconf write /org/gnome/desktop/peripherals/touchpad/click-method "'fingers'"
dconf write /org/gnome/desktop/peripherals/touchpad/speed 0.6

dconf write /org/gnome/desktop/interface/gtk-theme "'Adwaita-dark'"
dconf write /org/gnome/desktop/interface/cursor-theme "'Adwaita'"
dconf write /org/gnome/desktop/interface/enable-animations false
dconf write /org/gnome/desktop/interface/can-change-accels false
dconf write /org/gnome/desktop/interface/cursor-blink true
dconf write /org/gnome/desktop/interface/cursor-blink-time 1200
dconf write /org/gnome/desktop/interface/cursor-size 24
dconf write /org/gnome/desktop/interface/toolbar-style "'icons'"
dconf write /org/gnome/desktop/interface/show-battery-percentage true

#dconf write /org/gnome/desktop/peripherals/mouse/motion-threshold 2.0
#dconf write /org/gnome/desktop/peripherals/mouse/motion-acceleration 5.5
dconf write /org/gnome/settings-daemon/plugins/power/idle-dim false
dconf write /org/gnome/desktop/session/idle-delay "uint32 0"
dconf write /org/gnome/settings-daemon/plugins/power/lid-close-battery-action "'blank'"
dconf write /org/gnome/settings-daemon/plugins/power/lid-close-ac-action "'blank'"
dconf write /org/gnome/settings-daemon/plugins/color/night-light-enabled true
dconf write /org/gnome/settings-daemon/plugins/color/night-light-schedule-automatic true
dconf write /org/gnome/settings-daemon/plugins/media-keys/terminal "''"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings \
  "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/name "'Terminal Fullscreen'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/command "'gnome-terminal --window --full-screen'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/binding "'<Primary><Alt>t'"
dconf write /org/gnome/desktop/wm/preferences/button-layout "'appmenu:minimize,maximize,close'"

dconf write /org/gnome/desktop/wm/preferences/action-middle-click-titlebar "'lower'"
dconf write /org/gnome/desktop/wm/preferences/audible-bell false
dconf write /org/gnome/desktop/wm/preferences/num-workspaces 8

read -rp "Create a new profile for the terminal or the following commands will give errors.
After this scripts ends you the have to select that profile as the default."
profile="$(dconf dump / | grep /legacy/profiles:/ | sed -r 's/^\[|\]$//g' | head -n1)"
dconf write "/$profile/audible-bell" false
dconf write "/$profile/scrollbar-policy" "'never'"
dconf write "/$profile/scroll-on-output" false
dconf write "/$profile/scroll-on-keystroke" true
dconf write "/$profile/scrollback-unlimited" true
dconf write "/$profile/scrollback-lines" 10000
dconf write "/$profile/use-theme-colors" false
dconf write "/$profile/foreground-color" "'rgb(171,178,191)'"
dconf write "/$profile/background-color" "'rgb(40, 44, 52)'"
dconf write "/$profile/palette" "['rgb(40,44,52)', 'rgb(224,108,117)', \
  'rgb(152,195,121)', 'rgb(229,192,123)', 'rgb(97,175,239)', 'rgb(198,120,221)', \
  'rgb(86,182,194)', 'rgb(75,82,99)', 'rgb(40,44,52)', 'rgb(190,80,70)', \
  'rgb(152,195,121)', 'rgb(209,154,102)', 'rgb(97,175,239)', 'rgb(198,120,221)', \
  'rgb(86,182,194)', 'rgb(92,99,112)']"

dconf write /org/gnome/terminal/legacy/default-show-menubar false
# TODO: fix this
#dconf write /org/mate/terminal/global/profile-list "['defaul', 'profile0']"
#dconf write /org/gnome/terminal/legacy/profiles:/list "['b1dcc9dd-5262-4d8d-a863-c897e6d979b9', 'f0a8696e-5d7d-4300-b432-6ea0060c1fd6']"

################################################################################
#### Fonts
################################################################################
dconf write /org/gnome/desktop/interface/text-scaling-factor 1.25
#dconf write /org/gnome/desktop/interface/document-font-name "'Noto Sans 14'"
#dconf write /org/gnome/desktop/interface/monospace-font-name "'Monospace 14'"
#dconf write /org/gnome/desktop/interface/font-name "'Noto Sans 14'"
#dconf write /org/gnome/desktop/interface/document-font-name "'Noto Sans 14'"
#dconf write /org/gnome/desktop/interface/monospace-font-name "'Monospace 14'"
if [ -f ~/.local/share/fonts/Hack-Regular.ttf ]; then
  dconf write /$profile/use-system-font false
  dconf write /$profile/font "'Hack 12'"
  #dconf write /$profile/font "'Hack 14'"
fi
