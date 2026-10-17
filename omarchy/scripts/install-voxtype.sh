#!/usr/bin/env bash
# Voxtype dictation, set up the way omarchy-voxtype-install does it but with the
# stowed config (parakeet engine, hotkey off: Ctrl+Space in hypr/bindings.lua
# drives it).
set -e
source "$(dirname "$0")/lib.sh"

omarchy-pkg-add stow wtype voxtype-bin

# --no-folding: voxtype writes into ~/.config/voxtype, which must not be this repo
stow_package voxtype --no-folding

# Download the parakeet model named in the stowed config, if it's missing. A bare
# --download would fetch the whisper model instead, which this config doesn't use.
model=$(sed -n '/^\[parakeet\]/,/^\[/s/^model = "\(.*\)"/\1/p' "$OMARCHY_DIR/voxtype/.config/voxtype/config.toml")
voxtype setup --download --model "$model" --no-post-install
systemctl --user is-enabled --quiet voxtype.service || voxtype setup systemd

# Stop Omarchy's post-update hook from inviting us to install it again
omarchy-done mark voxtype-install-invitation
