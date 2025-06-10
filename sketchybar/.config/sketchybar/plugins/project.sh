#!/bin/bash

# Try to get project name from git repository first
if git rev-parse --is-inside-work-tree &>/dev/null; then
  PROJECT_NAME=$(basename "$(git rev-parse --show-toplevel)" 2>/dev/null)
else
  # Fallback to current directory name
  PROJECT_NAME=$(basename "$PWD")
fi

# Handle empty or root directory
if [ -z "$PROJECT_NAME" ] || [ "$PROJECT_NAME" = "/" ]; then
  PROJECT_NAME="~"
fi

# Limit project name length
if [ ${#PROJECT_NAME} -gt 15 ]; then
  PROJECT_NAME="${PROJECT_NAME:0:12}..."
fi

# Detect project type and set appropriate color
COLOR="0xff80ff00"  # Default blue

# Check for common project files to determine type
if [ -f "package.json" ]; then
  # Node.js project
  COLOR="0xfff9e2af"  # Yellow for Node.js
elif [ -f "requirements.txt" ] || [ -f "pyproject.toml" ]; then
  # Python project
  COLOR="0xff80ff00"  # Green for Python
elif [ -f "Cargo.toml" ]; then
  # Rust project
  COLOR="0xffff6b00"  # Orange for Rust
elif [ -f "go.mod" ]; then
  # Go project
  COLOR="0xff80ff00"  # Blue for Go
else
  # Generic project
  COLOR="0xff80ff00"  # Default blue
fi

sketchybar --set $NAME label="$PROJECT_NAME" \
                    label.color=$COLOR