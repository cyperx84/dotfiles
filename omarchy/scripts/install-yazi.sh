#!/usr/bin/env bash
# Install yazi and stow its keymap (the `y` cd-on-exit wrapper is in bash/.config/bash/personal.sh).
set -e
source "$(dirname "$0")/lib.sh"

omarchy-pkg-add stow yazi

stow_package yazi
