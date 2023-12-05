#!/usr/bin/env bash

# This script assumes you already have a user account, and have installed sudo, systemdboot and a kernel.

. /etc/os-release
pmconf="/etc/pacman.conf"

if [[ "$USER" = 0 ]]; then
    echo "This script should not be run as root!"
    exit 1
fi

if command -v doas &> /dev/null; then
    echo "Found opendoas, switching sudo to doas."
    sudo='doas'
fi

# Configure pacman
sudo cp $pmconf /etc/pacman.conf.bak
sudo sed -i 's/^#ParallelDownloads/ParallelDownloads/' $pmconf  # Enable parallel downloading
sudo sed -i 's/^#VerbosePkgLists/VerbosePkgLists/' $pmconf
sudo sed -i 's/^#Color/Color/' $pmconf
sudo sed -i 's/^#ILoveCandy/ILoveCandy/' $pmconf
sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' $pmconf  # Enable multilib repo


# Install core packages
# This is not minimal lol but who cares
sudo pacman -Syu
sudo pacman -S --needed --noconfirm \
ark audiocd-kio baloo-widgets base-devel bash-completion bluedevil bluez bluez-utils breeze breeze-gtk btop calibre cups discord discover dolphin dolphin-plugins \
ffmpegthumbs filelight flatpak flatpak-kcm gimp git gwenview haruna hunspell hunspell-en_au \
kate kcalc kde-gtk-config kde-inotify-survey kdegraphics-thumbnailers kdenetwork-filesharing kdeplasma-addons kdesdk-thumbnailers kget kimageformats5 kio-admin kio-extras kio-fuse kio-gdrive kolourpaint kompare konsole krename krita krunner5 ksystemlog libappindicator-gtk3 libheif libreoffice-fresh \
nano nano-syntax-highlighting neofetch networkmanager okular openssh pacman-contrib partitionmanager phonon-qt5-vlc plasma-browser-integration pipewire plasma-desktop plasma-nm plasma-pa plasma-wayland-session powerdevil print-manager \
qt5-imageformats sddm sddm-kcm sonnet5 spectacle sweeper system-config-printer taglib \
vulkan vulkan-utils wayland wget xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-kde xdg-user-dirs xorg-server xorg-xwayland xsettingsd yakuake

sudo systemctl enable --now bluetooth.service
sudo modprobe btusb
sudo systemctl enable --now NetworkManager.service
sudo systemctl enable --now cups.service
sudo systemctl enable sddm.service

# Potential package conflicts for KDE
sudo pacman -Rs --no-confirm xdg-desktop-portal-gnome qt5ct

# NVIDIA
if lspci | grep -i 'vga.* nvidia'; then
    sudo pacman -S --needed --no-confirm nvidia-dkms nvidia-utils nvidia-settings lib32-nvidia-utils
    sudo systemctl enable nvidia-suspend.service
    sudo systemctl enable nvidia-hibernate.service
    if pacman -Q | grep 'gdm'; then
        sudo systemctl enable nvidia-resume.service
    fi
fi

# Enable access to the AUR using paru
if $ID = 'endeavouros'; then
    sudo pacman -S --needed --no-confirm paru
else
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si
fi

paru -S ttf-google-fonts-git visual-studio-code-bin jetbrains-toolbox brave-bin vmware-workstation strawberry-qt5 jdownloader2 qbittorrent-qt5

# Setup VMWare Workstation
sudo systemctl start vmware-networks-configuration.service
sudo systemctl enable --now vmware-networks.service
sudo systemctl enable --now vmware-usbarbitrator.service
sudo modprobe -a vmw_vmci vmmon

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.microsoft.Edge md.obsidian.Obsidian com.valvesoftware.Steam org.DolphinEmu.dolphin-emu org.libretro.RetroArch org.yuzu_emu.yuzu org.ryujinx.Ryujinx net.citra_emu.citra info.cemu.Cemu net.pcsx2.PCSX2 net.rpcs3.RPCS3 org.duckstation.DuckStation

# reboot system
echo -e 'Rebooting system in 5 seconds.'
sleep 5
sudo systemctl reboot
