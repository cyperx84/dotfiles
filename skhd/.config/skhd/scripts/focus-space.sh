#!/usr/bin/env bash
#
# Smart space switching script that handles empty spaces correctly
# Usage: focus-space.sh <space_number>

SPACE=$1

# Switch to the space
yabai -m space --focus "$SPACE" || exit 0

# Only try to focus a window if the space has windows
WIN_COUNT=$(yabai -m query --windows --space 2>/dev/null | jq 'length' 2>/dev/null)

if [ "$WIN_COUNT" -gt 0 ] 2>/dev/null; then
    yabai -m window --focus first 2>/dev/null
fi

exit 0
