#!/usr/bin/env bash
set -euo pipefail

REPOS_DIR="${REPOS_DIR:-$HOME/Repos}"

# Add the uhid module so the controller driver loads correctly.
sudo sh -c 'echo "uhid" >> /etc/modules-load.d/uhid.conf'

mkdir -p "$REPOS_DIR"
cd "$REPOS_DIR"

# xpadneo
if [ ! -d xpadneo ]; then
    git clone https://github.com/atar-axis/xpadneo.git
fi
(
    cd "$REPOS_DIR/xpadneo"
    sudo ./install.sh
)
cd "$REPOS_DIR"

# nct6687d
if [ ! -d nct6687d ]; then
    git clone https://github.com/Fred78290/nct6687d
fi
(
    cd "$REPOS_DIR/nct6687d"
    make dkms/install
)
cd "$REPOS_DIR"

sudo sh -c 'echo "nct6687" >> /etc/modules-load.d/nct6687.conf'
