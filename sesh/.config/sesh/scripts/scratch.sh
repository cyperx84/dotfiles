#!/usr/bin/env bash

# Scratch Workspace Setup Script
# Creates a temporary workspace for experiments and quick tasks

set -euo pipefail

echo "📝 Setting up Claude Scratch workspace..."

# Set up scratch workspace
SCRATCH_DIR="/tmp/claude-scratch"

# Create scratch directory if it doesn't exist
if [[ ! -d "$SCRATCH_DIR" ]]; then
    echo "📁 Creating scratch workspace directory: $SCRATCH_DIR"
    mkdir -p "$SCRATCH_DIR"
fi

cd "$SCRATCH_DIR"

# Create some useful files if they don't exist
if [[ ! -f "README.md" ]]; then
    cat > README.md << 'EOF'
# Claude Scratch Workspace

This is a temporary workspace for experiments and quick tasks.

## Quick Commands
- `nvim notes.md` - Open notes file
- `python scratch.py` - Run Python experiments
- `node scratch.js` - Run JavaScript experiments
- `echo "test" > output.txt` - Save output

## Files are temporary
This directory is in /tmp and may be cleared on system restart.
EOF
fi

# Check if we're already in a tmux session
if [[ -n "${TMUX:-}" ]]; then
    echo "📍 Already in tmux session, setting up scratch environment..."

    # Create main scratch window
    tmux new-window -n "Scratch" -c "$SCRATCH_DIR"
    tmux send-keys -t "Scratch" "echo '📄 Claude Scratch Workspace'" C-m
    tmux send-keys -t "Scratch" "echo '⚡ Quick experiments and temporary files'" C-m
    tmux send-keys -t "Scratch" "echo '📍 Location: $SCRATCH_DIR'" C-m
    tmux send-keys -t "Scratch" "echo ''" C-m
    tmux send-keys -t "Scratch" "ls -la" C-m

    # Split for quick editor
    tmux split-window -h -c "$SCRATCH_DIR"
    tmux send-keys "nvim notes.md" C-m

    # Create language-specific windows
    tmux new-window -n "Python" -c "$SCRATCH_DIR"
    tmux send-keys -t "Python" "echo '🐍 Python Scratch Space'" C-m
    tmux send-keys -t "Python" "echo 'python3 -c \"print(\\\"Hello from Python!\\\")\"'" C-m

    tmux new-window -n "Shell" -c "$SCRATCH_DIR"
    tmux send-keys -t "Shell" "echo '🐚 Shell Commands and Scripts'" C-m
    tmux send-keys -t "Shell" "echo '💡 Use this space for shell experiments'" C-m

    # Select the main scratch window
    tmux select-window -t "Scratch"

else
    echo "💡 Not in tmux session. Use sesh connect to start this session properly."
fi

echo "✅ Scratch workspace ready at $SCRATCH_DIR"