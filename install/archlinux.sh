#!/usr/bin/env bash

# Keyboard mappings (keymaps) for virtual console
loadkeys es.map
setfont ter-132n

# Copy the list of mirrors closest to your country
# that have been updated in the last 6 hours
reflector -c Spain -a 6 --sort rate --save /etc/pacman.d/mirrorlist

# Resincronize the servers
pacman -Syu

pacstrap /mnt base linux linux-firmware vim intel-ucode

exit
umount -a
reboot

pacman -Syu

packages=(
    sudo
    grub  # multi-boot loader
    efibootmgr  # EFI boot manager
    networkmanager network-manager-applet
    dialog
    dhcpcd
    netctl
    wpa_supplicant
    mtools dosfstool  # working with fat filesystems
    base-devl linux-headers  # development
    bluez bluez-utils  # bluetooth protocol
    cups  # for printing
    xdg-utils xdg-user-dirs
    alsa-utils pulseaudio pulseaudio_bluetooth  # audio
    git
    reflector
    bash-completion
    xorg  # visual
    i3  # window manager
    dmenu  # app launcher
    lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings  # brightness
    ttf-dejavu ttf-liberation noto-fonts terminus-font
    firefox
    picom  # compositor for the X Window System
    nnn  # file manager
    alacritty  # terminal
    nextcloud-client-cloudproviders  # cloud storage
)

for app in "${packages[@]}" ; do
    ! command_exists "$app"  &&  sudo pacman -S --noconfirm "$app"
    ! command_exists "$app"  &&  yaourt -Sa --noconfirm "$app"
done

# Update mirror list regularly
sudo systemctl enable --now reflector.timer

# Enable fstrim timer to check SSD
sudo systemctl enable --now fstrim.timer
