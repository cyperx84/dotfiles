#!/usr/bin/env bash

# Sesh preview with keybinds at top
# Shows available keybinds above the regular session preview

echo "  Keybinds: ^a all+dirs | ^t tmux-only | ^x zoxide | ^/ new | ^r detailed | ^s sort | ^k kill"
echo ""

# Call the regular preview script
SESH_DISPLAY_MODE=detailed ~/.tmux/scripts/sesh_preview.sh "$1"
