#!/usr/bin/env bash
# Layer these dotfiles onto a fresh Omarchy install. Every step is idempotent,
# so this is also how to re-apply everything after a change.
set -e

cd "$(dirname "$0")/scripts"

./install-git.sh
./install-ssh.sh
./install-mise.sh
./install-configs.sh
./install-hypr.sh
./install-look.sh
./install-herdr.sh
./install-nvim.sh
./install-yazi.sh
./install-voxtype.sh
./install-apps.sh
./install-t2-mac.sh
./install-kanata.sh # last: needs a re-login for its input/uinput groups
