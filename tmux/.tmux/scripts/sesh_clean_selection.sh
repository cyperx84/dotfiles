#!/usr/bin/env bash

# Clean fzf selection output for sesh
# Removes ANSI codes and icon prefixes

# Read from stdin
selection=$(cat)

# Strip ANSI codes
selection=$(echo "$selection" | sed 's/\x1b\[[0-9;]*m//g' | sed 's/\[[0-9;]*m//g')

# Remove leading/trailing whitespace
selection=$(echo "$selection" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

# Remove status icon prefixes (◆, ●, ◉, 📁, ▣)
selection=$(echo "$selection" | sed -e 's/^◆[[:space:]]*//' -e 's/^●[[:space:]]*//' -e 's/^◉[[:space:]]*//' -e 's/^📁[[:space:]]*//' -e 's/^▣[[:space:]]*//')

# Remove ANY leading emoji characters (multi-byte UTF-8) followed by optional space
selection=$(echo "$selection" | sed -E 's/^[^[:alnum:]~\/\._-]+[[:space:]]*//')

# Extract first word (session name) - everything before metadata
selection=$(echo "$selection" | awk '{print $1}')

echo "$selection"
