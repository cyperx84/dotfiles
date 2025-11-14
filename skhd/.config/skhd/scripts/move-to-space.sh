#!/usr/bin/env bash

# Move window to space, creating the space if it doesn't exist
# Usage: move-to-space.sh <space_index>

SPACE_INDEX=$1

if [[ -z "$SPACE_INDEX" ]]; then
    echo "Usage: $0 <space_index>"
    exit 1
fi

# Get total number of spaces
TOTAL_SPACES=$(yabai -m query --spaces | jq 'length')

# Create spaces if needed
while [ "$TOTAL_SPACES" -lt "$SPACE_INDEX" ]; do
    yabai -m space --create
    TOTAL_SPACES=$((TOTAL_SPACES + 1))
done

# Move window to the space, focus the space, and focus the first window (the one we just moved)
yabai -m window --space "$SPACE_INDEX"
yabai -m space --focus "$SPACE_INDEX"
yabai -m window --focus first 2>/dev/null || true
