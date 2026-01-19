#!/bin/bash

# Starship-inspired status line for Claude Code
# Matches the Gruvbox Dark Neon theme from starship.toml

set -o pipefail

# Read JSON input safely
input=$(cat 2>/dev/null) || input="{}"

# Safe JSON extraction with fallbacks
get_json() {
    echo "$input" | jq -r "$1" 2>/dev/null || echo ""
}

# Extract values
cwd=$(get_json '.workspace.current_dir')
context_used=$(get_json '.context_window.used_percentage')

# Fallback for cwd
if [ -z "$cwd" ] || [ "$cwd" = "null" ]; then
    cwd="$PWD"
fi

# Fallback for context - default to 0
if [ -z "$context_used" ] || [ "$context_used" = "null" ]; then
    context_used="0"
fi

# ANSI color codes
GREEN='\033[92m'
ORANGE='\033[38;5;202m'
BRIGHT_GREEN='\033[38;5;46m'
YELLOW='\033[93m'
RED='\033[91m'
RESET='\033[0m'

# OS icon (macOS)
os_icon="󰯈"

# Directory formatting with substitutions
format_directory() {
    local dir="$1"

    # Replace home directory with ~
    dir="${dir/#$HOME/\~}"

    # Apply directory substitutions from starship.toml
    dir="${dir//\/github\//\/ \/}"
    dir="${dir//\/notes\//\/ \/}"
    dir="${dir//\/Documents\//\/󱔗 \/}"
    dir="${dir//\/Downloads\//\/ \/}"
    dir="${dir//\/Music\//\/ \/}"
    dir="${dir//\/Movies\//\/󰷝 \/}"
    dir="${dir//\/Pictures\//\/ \/}"
    dir="${dir//\/Code\//\/ \/}"
    dir="${dir//\/agents\//\/󱙝 \/}"
    dir="${dir//\/dotfiles\//\/󰒔 \/}"
    dir="${dir//\/.config\//\/ \/}"

    echo "$dir"
}

formatted_dir=$(format_directory "$cwd")

# Git branch detection (with performance optimizations)
git_info=""
if [ -n "$cwd" ] && [ -d "$cwd" ]; then
    if git -C "$cwd" rev-parse --git-dir >/dev/null 2>&1; then
        branch=$(git -C "$cwd" -c "gc.auto=0" branch --show-current 2>/dev/null)
        if [ -n "$branch" ]; then
            git_info=" ${BRIGHT_GREEN}󰊢${RESET}"
        fi
    fi
fi

# Context window progress bar
# Convert to integer safely
context_int="${context_used%%.*}"
context_int="${context_int:-0}"

# Ensure it's a valid number
if ! [[ "$context_int" =~ ^[0-9]+$ ]]; then
    context_int=0
fi

# Clamp to 0-100
if [ "$context_int" -gt 100 ]; then
    context_int=100
fi

# Progress bar settings
bar_width=10
filled=$((context_int * bar_width / 100))
empty=$((bar_width - filled))

# Build progress bar
bar=""
for ((i=0; i<filled; i++)); do
    bar="${bar}█"
done
for ((i=0; i<empty; i++)); do
    bar="${bar}░"
done

# Choose color based on usage level
if [ "$context_int" -ge 80 ]; then
    ctx_color="$RED"
elif [ "$context_int" -ge 50 ]; then
    ctx_color="$YELLOW"
else
    ctx_color="$GREEN"
fi

context_info=" ${ctx_color}[${bar}]${RESET} ${context_int}%"

# Build and output status line
printf "%b%s%b %b%s%b%b%b" \
    "$GREEN" "$os_icon" "$RESET" \
    "$ORANGE" "$formatted_dir" "$RESET" \
    "$git_info" "$context_info"
