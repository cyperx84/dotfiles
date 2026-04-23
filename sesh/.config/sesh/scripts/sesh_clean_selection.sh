#!/usr/bin/env bash

# Clean fzf selection output for sesh
# Removes ANSI codes and icon prefixes, but preserves emoji in session names

# Read from stdin
selection=$(cat)

# Strip ANSI escape codes (both formats)
selection=$(echo "$selection" | sed 's/\x1b\[[0-9;]*m//g' | sed 's/\[[0-9;]*m//g')

# Remove the leading status icons (◆, ●, ○, ◉, 📁, ▣)
# These are added by sesh_list scripts and can have various amounts of whitespace after them
# We remove the icon but leave any emoji that follows
for icon in '◆' '●' '○' '◉' '📁' '▣'; do
    if [[ "$selection" == "$icon"* ]]; then
        # Remove the icon by taking substring starting after it
        selection="${selection#$icon}"
        break
    fi
done

# Remove any garbage bytes and leading whitespace between icon and session name
# This handles special UTF-8 sequences that may be in the sesh output
selection=$(echo "$selection" | sed 's/^[[:space:][:cntrl:]]*//;s/^[^🤖💻📝⚙️🐙🧪[:alnum:]]*//' | sed 's/^[[:space:]]*//g')

# Remove metadata suffixes (patterns at the end we don't want)
# Remove window/pane counts: (1w 2p)
selection=$(echo "$selection" | sed -E 's/[[:space:]]*\([0-9]+w[[:space:]]+[0-9]+p\).*//')

# Remove activity/resource indicators: emoji like 🔥 ✓ ⏰ etc with trailing content
selection=$(echo "$selection" | sed -E 's/[[:space:]]+(🔥|✓|⏰|💤|📦).*//')

# Final cleanup: trim whitespace from both ends
selection=$(echo "$selection" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

# IMPORTANT: Do NOT remove emoji here - they are part of the actual session name!
# Sessions like "🤖 claude-config" need to be passed to sesh with the emoji

# Remove metadata suffix - everything after parentheses with window/pane counts
# This matches patterns like "(1w 2p)" or activity icons
selection=$(echo "$selection" | sed -E 's/[[:space:]]*\([0-9]+w[[:space:]]+[0-9]+p\).*//')

# Remove activity/resource metadata (emoji at word boundaries followed by text)
# Matches: 🔥 (hot), ✓ (recent), ⏰ (idle), 💤 (sleeping), 📦 (archived)
selection=$(echo "$selection" | sed -E 's/[[:space:]]+(🔥|✓|⏰|💤|📦).*//')

# Trim any remaining trailing whitespace
selection=$(echo "$selection" | sed 's/[[:space:]]*$//')

echo "$selection"
