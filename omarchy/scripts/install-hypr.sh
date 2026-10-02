#!/usr/bin/env bash
# Hyprland deltas over stock Omarchy: bindings.lua (home-row workspaces,
# Ctrl+Shift+hjkl focus, Ctrl+Space dictation) and looknfeel.lua (rounding, dim).
set -e
source "$(dirname "$0")/lib.sh"

omarchy-pkg-add stow

stow_package hypr

# Hyprland reloads on file changes, so it may have caught the moment between
# moving Omarchy's copy aside and linking ours. Reload once everything is in place.
hyprctl reload >/dev/null
