#!/usr/bin/env bash
# Install kanata and run it as a systemd user service (no root daemon).
set -e
source "$(dirname "$0")/lib.sh"

omarchy-pkg-add stow
omarchy-pkg-aur-add kanata-bin

# Let the user read keyboards (input) and create the virtual output device (uinput)
sudo groupadd -f uinput
sudo usermod -aG input,uinput "$USER"
echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' |
  sudo tee /etc/udev/rules.d/99-uinput.rules >/dev/null
echo uinput | sudo tee /etc/modules-load.d/uinput.conf >/dev/null
sudo modprobe uinput
sudo udevadm control --reload-rules
sudo udevadm trigger

stow_package kanata
kanata --cfg "$HOME/.config/kanata/config.kbd" --check

systemctl --user daemon-reload
systemctl --user enable kanata.service kanata-regrab.service

# Home row mods indicator on the bar: the stowed custom module
# ~/.config/omarchy/bar/modules/kanata.qml, fed by kanata's TCP port. Both
# commands are no-ops when it's already there.
omarchy bar put kanata --after omarchy.keyboard-layout
omarchy bar set kanata type qml

echo "Done. Log out and back in (group changes), then kanata starts automatically."
echo "Check with: systemctl --user status kanata"
