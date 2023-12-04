# EndeavourOS Setup

## Pre-ramble

**Why not Arch Linux?**
While Arch Linux itself is great, EndeavourOS has good defaults (dracut), you don't have to bother with a terminal install, and automatically sets up NVIDIA cards.

## Installation
- I use Online installation, and KDE Plasma  
- For the Packages screen:
  - I untick **Firewall**, **Firefox**, **Recommended applications** and **EndeavourOS applications**.
  - In *Desktop-Base + Common packages*, i untick:
    - **GPU**: everything (i do not have another GPU)
    - **Network**: `b43-fwcutter`, `broadcom-wl-dkms`, `modemmanager`, `networkmanager-openconnect`, `networkmanager-openvpn`, `usb_modeswitch` and `xl2tpd`.
    - **Filesystem**: `nfs-utils`
    - **Fonts**: everything (I want to choose my own fonts)
    - **Hardware**: `dmraid`
    - **CPU specific microcode**: `intel-ucode`
  - In *KDE-Desktop*:
    - Untick `EndeavourOS settings`, because I want to customize it from scratch.
  - I install Printing support.
- For **Bootloader**, i choose systemd-boot because it's easier to use than GRUB and I don't switch between multiple OS'es.
- For **Partitions**, I choose swap (no hibernate) because swap is useful and ButterFS.

I use x.org.

## After Installation

`setup.sh`