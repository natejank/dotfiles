#!/bin/bash
# a script to set up a sway desktop on Debian
# the goal here is to install just enough packages to get a usable machine from a debian netinstall.
# see the other scripts for installing tools and applications

set -euo pipefail
trap 'echo "Error: $? at line $LINENO" >&2' ERR
. ./common.sh

ensure_installed tmux git

# setup sway desktop
ensure_installed_nir sway
ensure_installed sway-backgrounds swaylock swayidle
# utilities required for desktop linux
ensure_installed xdg-desktop-portal-wlr xdg-desktop-portal-gtk polkitd pipewire-audio pulseaudio-utils gnome-keyring geoclue-2-demo network-manager ufw xwayland power-profiles-daemon cups
# fonts
ensure_installed fonts-noto
# screen recording
ensure_installed grimshot wf-recorder 
# utilities required for sway
ensure_installed wlsunset wev mako-notifier fuzzel brightnessctl wl-mirror dex playerctl libnotify-bin wl-clipboard libglib2.0-bin libsecret-tools
# status bar
ensure_installed waybar gir1.2-playerctl-2.0 libappindicator3-1
# settings apps
ensure_installed pavucontrol blueman network-manager-applet
# minimal set of desktop applications
ensure_installed nemo alacritty imv
ensure_installed_nir mpv

# enable the firewall
sudo ufw enable
# configure nemo for sway
gsettings set org.nemo.desktop show-desktop-icons false
gsettings set org.cinnamon.desktop.default-applications.terminal exec alacritty
