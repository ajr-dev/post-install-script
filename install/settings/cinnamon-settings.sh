#!/bin/bash

dconf write /org/gnome/nm-applet/disable-disconnected-notifications true
dconf write /org/gnome/nm-applet/disable-connected-notifications true
#dconf write /org/gnome/desktop/interface/document-font-name "'Noto Sans 14'"
#dconf write /org/gnome/desktop/interface/monospace-font-name "'Monospace 14'"
dconf write /org/gnome/libgnomekbd/keyboard/options "['caps\tcaps:swapescape']"
#dconf write /org/nemo/desktop/font "'Ubuntu 14'"
#dconf write /org/cinnamon/desktop/interface/font-name "'Ubuntu 14'"
#dconf write /org/gnome/desktop/interface/document-font-name "'Ubuntu 14'"
#dconf write /org/cinnamon/desktop/wm/preferences/titlebar-font "'Ubuntu Medium 11'"
dconf write /org/cinnamon/desktop/interface/text-scaling-factor 1.5

################################################################################
#### Update Manager
################################################################################
dconf write /com/linuxmint/updates/hide-window-after-update true
dconf write /com/linuxmint/updates/hide-systray true
dconf write /com/linuxmint/updates/default-repo-is-ok true
dconf write /com/linuxmint/updates/level1-is-visible true
dconf write /com/linuxmint/updates/level2-is-visible true
dconf write /com/linuxmint/updates/level3-is-visible true
dconf write /com/linuxmint/updates/level4-is-visible true
dconf write /com/linuxmint/updates/level5-is-visible true
dconf write /com/linuxmint/updates/level1-is-safe true
dconf write /com/linuxmint/updates/level2-is-safe true
dconf write /com/linuxmint/updates/level3-is-safe true
dconf write /com/linuxmint/updates/level4-is-safe true
dconf write /com/linuxmint/updates/level5-is-safe true
dconf write /com/linuxmint/updates/security-updates-are-visible true
dconf write /com/linuxmint/updates/security-updates-are-safe true
dconf write /com/linuxmint/updates/kernel-updates-are-visible true
dconf write /com/linuxmint/updates/kernel-updates-are-safe true
dconf write /com/linuxmint/updates/refresh-days 7
dconf write /com/linuxmint/updates/refresh-hours 0
dconf write /com/linuxmint/updates/refresh-minutes 10
dconf write /com/linuxmint/updates/autorefresh-days 7
dconf write /com/linuxmint/updates/autorefresh-hours 2
dconf write /com/linuxmint/updates/autorefresh-minutes 0
dconf write /com/linuxmint/updates/dist-upgrade true

################################################################################
#### Nemo File Manager
################################################################################
dconf write /org/nemo/desktop/font "'Noto Sans 14'"
dconf write /org/nemo/icon-view/default-zoom-level "'large'"
dconf write /org/nemo/list-view/default-visible-columns "['name', 'size', 'type', 'date_modified', 'owner', 'permissions']"
dconf write /org/nemo/preferences/click-policy "'single'"
dconf write /org/nemo/preferences/executable-text-activation "'display'"
dconf write /org/nemo/preferences/enable-delete true
dconf write /org/nemo/preferences/swap-trash-delete true
dconf write /org/nemo/preferences/close-device-view-on-device-eject true
dconf write /org/nemo/preferences/show-full-path-titles true
dconf write /org/nemo/preferences/show-advanced-permissions true
dconf write /org/nemo/preferences/show-image-thumbnails "'never'"
dconf write /org/nemo/preferences/show-new-folder-icon-toolbar true # small icon next to the search icon
dconf write /org/nemo/preferences/show-search-icon-toolbar true
dconf write /org/nemo/preferences/show-icon-view-icon-toolbar false
dconf write /org/nemo/preferences/show-list-view-icon-toolbar false
dconf write /org/nemo/preferences/show-compact-view-icon-toolbar false
dconf write /org/nemo/window-state/start-with-sidebar false
dconf write /org/nemo/window-state/sidebar-width 200
dconf write /org/nemo/window-state/maximized true

################################################################################
#### Multimedia Player
################################################################################
dconf write /org/x/player/remember-position true
dconf write /org/x/player/autoload-subtitles true

################################################################################
#### Desktop
################################################################################
dconf write /org/cinnamon/desktop/media-handling/automount true
dconf write /org/cinnamon/desktop/media-handling/automount-open true
dconf write /org/cinnamon/desktop/media-handling/autorun-never true
dconf write /org/cinnamon/desktop/lockdown/disable-user-switching true
dconf write /org/cinnamon/desktop/background/slideshow/slideshow-enabled false
dconf write /org/cinnamon/desktop/interface/font-name "'Noto Sans 14'"
dconf write /org/cinnamon/desktop/wm/preferences/titlebar-font "'Noto Sans Bold 11'"
dconf write /org/cinnamon/desktop-effects false
dconf write /org/cinnamon/desktop-effects-on-dialogs false
dconf write /org/cinnamon/desktop-effects-on-menus false
dconf write /org/cinnamon/enable-vfade false
dconf write /org/cinnamon/startup-animation false
dconf write /org/cinnamon/desktop/interface/gtk-overlay-scrollbars true
dconf write /org/cinnamon/desktop/interface/clock-use-24h true
dconf write /org/cinnamon/desktop/interface/clock-show-date true
dconf write /org/cinnamon/desktop/interface/clock-show-seconds false
dconf write /org/cinnamon/desktop/interface/first-day-of-week 1
dconf write /org/cinnamon/enabled-desklets "['clock@cinnamon.org:0:150:0']"
dconf write /org/cinnamon/desklet-decorations 0
dconf write /org/cinnamon/panels-autohide "['1:intel']"
dconf write /org/cinnamon/panels-resizable "['1:true']" # This must be true for the following height to take effect.
dconf write /org/cinnamon/panels-scale-text-icons "['1:true']"
dconf write /org/cinnamon/panels-height "['1:35']"
dconf write /org/cinnamon/desktop/media-handling/autorun-never false
dconf write /org/cinnamon/desktop/privacy/remember-recent-files false
dconf write /org/cinnamon/desktop/privacy/recent-files-max-age -1
dconf write /org/cinnamon/desktop/privacy/recent-files-max-age 30
dconf write /org/cinnamon/settings-daemon/plugins/power/lock-on-suspend false
dconf write /org/cinnamon/settings-daemon/plugins/xsettings/antialiasing "'slight'"
dconf write /org/cinnamon/desktop/screensaver/lock-enabled false
dconf write /org/cinnamon/desktop/session/idle-delay "uint32 0"
dconf write /org/cinnamon/desktop/screensaver/ask-for-away-message false
dconf write /org/cinnamon/desktop/wm/preferences/focus-mode "'click'"
dconf write /org/cinnamon/desktop/wm/preferences/auto-raise true
dconf write /org/cinnamon/bring-windows-to-current-workspace false
dconf write /org/cinnamon/prevent-focus-stealing false
dconf write /org/cinnamon/settings-daemon/peripherals/keyboard/repeat true
dconf write /org/cinnamon/settings-daemon/peripherals/keyboard/delay "uint32 150"
dconf write /org/cinnamon/settings-daemon/peripherals/keyboard/repeat-interval "uint32 10"
dconf write /org/cinnamon/desktop/keybindings/custom-list "['custom0', 'custom1', 'custom2']"
dconf write /org/cinnamon/desktop/keybindings/custom-keybindings/custom0/name "'Task Manager'"
dconf write /org/cinnamon/desktop/keybindings/custom-keybindings/custom0/command "'gnome-system-monitor'"
dconf write /org/cinnamon/desktop/keybindings/custom-keybindings/custom0/binding "['<Primary><Alt>KP_Delete']"
dconf write /org/cinnamon/desktop/keybindings/custom-keybindings/custom1/name "'Kill Window'"
dconf write /org/cinnamon/desktop/keybindings/custom-keybindings/custom1/command "'xkill'"
dconf write /org/cinnamon/desktop/keybindings/custom-keybindings/custom1/binding "['<Primary>KP_Delete']"
dconf write /org/cinnamon/settings-daemon/peripherals/mouse/motion-acceleration 4.0
dconf write /org/cinnamon/settings-daemon/peripherals/mouse/motion-threshold 2.0
dconf write /org/cinnamon/settings-daemon/peripherals/touchpad/touchpad-enabled true
dconf write /org/cinnamon/settings-daemon/peripherals/touchpad/tap-to-click true
dconf write /org/cinnamon/settings-daemon/peripherals/touchpad/disable-while-typing true
dconf write /org/cinnamon/settings-daemon/peripherals/touchpad/two-finger-click 3
dconf write /org/cinnamon/settings-daemon/peripherals/touchpad/three-finger-click 2
dconf write /org/cinnamon/settings-daemon/peripherals/touchpad/natural-scroll false
dconf write /org/cinnamon/settings-daemon/peripherals/touchpad/vertical-edge-scrolling true
dconf write /org/cinnamon/settings-daemon/peripherals/touchpad/horizontal-edge-scrolling true
dconf write /org/cinnamon/settings-daemon/peripherals/touchpad/vertical-two-finger-scrolling true
dconf write /org/cinnamon/settings-daemon/peripherals/touchpad/horizontal-two-finger-scrolling true
dconf write /org/cinnamon/settings-daemon/peripherals/touchpad/motion-acceleration 5.0
dconf write /org/cinnamon/settings-daemon/peripherals/touchpad/motion-threshold 2
dconf write /org/cinnamon/settings-daemon/plugins/power/sleep-display-ac 0 # never
dconf write /org/cinnamon/settings-daemon/plugins/power/sleep-display-battery 0
dconf write /org/cinnamon/settings-daemon/plugins/power/sleep-inactive-ac-timeout 0
dconf write /org/cinnamon/settings-daemon/plugins/power/sleep-inactive-battery-timeout 0
dconf write /org/cinnamon/settings-daemon/plugins/power/lid-close-ac-action "'nothing'"
dconf write /org/cinnamon/settings-daemon/plugins/power/lid-close-battery-action "'nothing'"
dconf write /org/cinnamon/settings-daemon/plugins/power/button-power "'suspend'"
dconf write /org/cinnamon/settings-daemon/plugins/power/critical-battery-action "'hibernate'"
dconf write /org/cinnamon/settings-daemon/plugins/power/lid-close-suspend-with-external-monitor false
dconf write /org/cinnamon/settings-daemon/plugins/power/idle-dim-battery false
dconf write /org/cinnamon/sounds/login-enabled false
dconf write /org/cinnamon/sounds/logout-enabled false
dconf write /org/cinnamon/sounds/switch-enabled false
dconf write /org/cinnamon/sounds/map-enabled false
dconf write /org/cinnamon/sounds/close-enabled false
dconf write /org/cinnamon/sounds/minimize-enabled false
dconf write /org/cinnamon/sounds/maximize-enabled false
dconf write /org/cinnamon/sounds/unmaximize-enabled false
dconf write /org/cinnamon/sounds/tile-enabled false
dconf write /org/cinnamon/sounds/plug-enabled false
dconf write /org/cinnamon/sounds/unplug-enabled false
dconf write /org/cinnamon/desktop/sound/volume-sound-enabled false
dconf write /org/cinnamon/settings-daemon/plugins/xsettings/menus-have-icons true
dconf write /org/cinnamon/settings-daemon/plugins/xsettings/buttons-have-icons false

profile="$(dconf dump / |grep /legacy/profiles:/ |sed -r 's/^\[|\]$//g' |head -n1)"
dconf write /$profile/use-transparent-background false
if fc-list | grep -i "source-code-pro"; then
  dconf write /$profile/use-system-font false
  dconf write /$profile/font "'Source Code Pro 11'"
fi
dconf write /$profile/scrollbar-policy "'never'"
dconf write /$profile/scroll-on-output false
dconf write /$profile/scroll-on-keystroke true
dconf write /$profile/scrollback-unlimited true
dconf write /$profile/scrollback-lines 10000
dconf write /org/gnome/terminal/legacy/default-show-menubar false

# Onedark colorscheme
dconf write /$profile/palette
  ['rgb(30,33,39)', 'rgb(190,80,70)', 'rgb(152,195,121)', 'rgb(209,154,102)', 'rgb(97,175,239)', 'rgb(198,120,221)', 'rgb(86,182,194)', 'rgb(171,178,191)', 'rgb(92,99,112)', 'rgb(224,108,117)', 'rgb(152,195,121)', 'rgb(229,192,123)', 'rgb(97,175,239)', 'rgb(198,120,221)', 'rgb(86,182,194)', 'rgb(255,255,255)']
dconf write /$profile/foreground-color "'rgb(92,99,112)'"
dconf write /$profile/bold-color-same-as-fg true
