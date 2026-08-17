#!/usr/bin/env bash
set -euo pipefail

if ! command -v pacman >/dev/null 2>&1; then
    echo "This script is intended for Arch Linux." >&2
    exit 1
fi

# Required runtime and kernel packages.
sudo pacman -S --needed --noconfirm \
    dkms \
    linux-headers \
    bluez \
    bluez-utils

# Remove the conflicting upstream VS Code package if it is present.
sudo pacman -Rns --noconfirm code 2>/dev/null || true

# Install the non-AUR packages immediately after the code removal.
sudo pacman -S --needed --noconfirm \
    mullvad-vpn \
    steam \
    discord \
    isoimagewriter \
    partitionmanager \
    librewolf \
    keepassxc

# Install an AUR helper if one is not already present.
AUR_HELPER=""
if command -v yay >/dev/null 2>&1; then
    AUR_HELPER="yay"
elif command -v paru >/dev/null 2>&1; then
    AUR_HELPER="paru"
else
    echo "Installing yay as the default AUR helper..."
    git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
    (
        cd /tmp/yay-bin
        makepkg -si --noconfirm
    )
    AUR_HELPER="yay"
fi

# Install the remaining AUR packages.
"$AUR_HELPER" -S --needed --noconfirm \
    visual-studio-code-bin \
    coolercontrol \
    faugus-launcher

# Enable the requested services.
sudo systemctl enable --now mullvad-daemon.service
sudo systemctl enable --now coolercontrold.service
