#!/usr/bin/bash

# Bluetooth is disabled for some reason
sudo systemctl enable --now bluetooth.service

# Refresh package repositories
sudo pacman -Syu
sudo pacman -S --needed discover plasma-wayland-session qt5-imageformats kimageformats5 kde-inotify-survey kdegraphics-thumbnailers kio-admin kio-gdrive kdenetwork-filesharing xdg-desktop-portal-gtk xdg-desktop-portal-kde libheif kdesdk-thumbnailers filelight krita kolourpaint paru flatpak libreoffice-fresh gimp discord papirus-icon-theme nano-syntax-highlighting ttf-jetbrains-mono yt-dlp git p7zip libappindicator-gtk3 qt5-wayland qt5-tools inter-font kdeplasma-addons jre17-openjdk jre8-openjdk rsync rclone kompare krename partitionmanager sweeper btop kinfocenter ksystemlog rust calibre bitwarden

paru -S ttf-google-fonts-git visual-studio-code-bin jetbrains-toolbox brave-bin vmware-workstation strawberry-qt5 jdownloader2 qbittorrent-qt5


flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.microsoft.Edge md.obsidian.Obsidian com.valvesoftware.Steam org.DolphinEmu.dolphin-emu

# reboot system
sudo systemctl reboot
