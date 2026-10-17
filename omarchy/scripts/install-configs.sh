#!/usr/bin/env bash
# Config-only packages: bash, ghostty (as the default terminal) and starship.
set -e
source "$(dirname "$0")/lib.sh"

omarchy-pkg-add stow starship

[[ $(omarchy default terminal) == ghostty ]] || omarchy install terminal ghostty

stow_package bash
stow_package ghostty
stow_package starship
