#!/usr/bin/env bash

# Sesh preview with keybinds at top
# Shows available keybinds above the regular session preview
# Display mode is determined by ~/.sesh_display_mode file (read by preview script)

# Display keybinds and current mode
CURRENT_MODE="$(cat ~/.sesh_display_mode 2>/dev/null || echo 'compact')"
MODE_LABEL=$([ "$CURRENT_MODE" = "detailed" ] && echo "📂 detailed" || echo "📋 compact")

echo "  Keybinds: ⌥n new | ⌥k kill | ^b all | ^t tmux-only | ^/ zoxide | ^r $MODE_LABEL | ^s sort | ^d/u preview"
echo ""

# Call the regular preview script
# Preview script reads ~/.sesh_display_mode file to determine what to show
~/.tmux/scripts/sesh_preview.sh "$1"
