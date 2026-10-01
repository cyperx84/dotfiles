#!/usr/bin/env bash
# Install yazi and stow its keymap (the `y` cd-on-exit wrapper is in bash/.config/bash/personal.sh).
set -e

OMARCHY_DIR="$(cd "$(dirname "$0")/.." && pwd)"

omarchy-pkg-add stow yazi

cd "$OMARCHY_DIR"
stow yazi
