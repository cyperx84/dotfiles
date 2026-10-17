#!/usr/bin/env bash
# Stow ~/.ssh/config. Host blocks live in ~/.ssh/config.local, which is NOT tracked
# (this repo is public), so create an empty one with the right mode if it's missing.
set -e
source "$(dirname "$0")/lib.sh"

omarchy-pkg-add stow openssh

mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

stow_package ssh

touch "$HOME/.ssh/config.local"
chmod 600 "$HOME/.ssh/config.local"
echo "Add Host blocks to ~/.ssh/config.local"
