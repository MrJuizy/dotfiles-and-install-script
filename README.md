# Personal Dotfiles and Install Script

This repository contains a small Arch Linux setup script for installing HyDE and then adding the extra tools and fixes I use.

## What it does
- installs HyDE first
- removes the default `code` package
- installs the needed packages
- enables required services
- sets up extra repo-based hardware fixes

## How to install
```bash
sudo pacman -S --needed --noconfirm git base-devel
git clone https://github.com/MrJuizy/dotfiles-and-install-script
cd dotfiles-and-install-script/
chmod+x install.sh
./install.sh
```

## Notes
- The install flow is: HyDE first, then additional packages and setup.
- Repo-based installs are handled after the main install step.
