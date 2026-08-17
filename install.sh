#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPOS_DIR="$HOME/Repos"

if ! command -v pacman >/dev/null 2>&1; then
    echo "This script is intended for Arch Linux." >&2
    exit 1
fi

# Required base tooling before anything else.
sudo pacman -S --needed --noconfirm git base-devel

# Shared repo workspace used by all setup steps.
mkdir -p "$REPOS_DIR"

# HyDE must be installed first, before any other setup.
if [ ! -d "$HOME/HyDE" ]; then
    git clone --depth 1 https://github.com/HyDE-Project/HyDE "$HOME/HyDE"
fi
(
    cd "$HOME/HyDE/Scripts"
    ./install.sh
)

# Copy the user preferences into Hyprland's config directory.
cp "$SCRIPT_DIR/dotfiles/userprefs.conf" "$HOME/.config/Hypr/"

# Install packages and enable the requested services.
"${SCRIPT_DIR}/install-packages.sh"

# Install repo-based add-ons and finish the hardware-specific setup.
REPOS_DIR="$REPOS_DIR" "${SCRIPT_DIR}/repo-setup.sh"

exit 0
