#!/usr/bin/env bash

# Claude Development Environment Setup Script
# Creates a multi-pane development environment for Claude Code plugin development

set -euo pipefail

echo "🚀 Setting up Claude Code development environment..."

# Set the working directory
CLAUDE_DEV_DIR="$HOME/.local/share/nvim/lazy/claudecode.nvim"

if [[ ! -d "$CLAUDE_DEV_DIR" ]]; then
    echo "❌ Claude Code plugin directory not found: $CLAUDE_DEV_DIR"
    echo "💡 Make sure you have the Claude Code nvim plugin installed"
    exit 1
fi

cd "$CLAUDE_DEV_DIR"

# Check if we're already in a tmux session
if [[ -n "${TMUX:-}" ]]; then
    echo "📍 Already in tmux session, creating windows..."

    # Create editor window
    tmux new-window -n "Editor" -c "$CLAUDE_DEV_DIR"
    tmux send-keys -t "Editor" "nvim ." C-m

    # Create testing window with split panes
    tmux new-window -n "Testing" -c "$CLAUDE_DEV_DIR"
    tmux send-keys -t "Testing" "echo '🧪 Testing Environment for Claude Code Plugin'" C-m
    tmux send-keys -t "Testing" "echo '💡 Run plugin tests and experiments here'" C-m

    # Split for file watcher
    tmux split-window -v -c "$CLAUDE_DEV_DIR"
    tmux send-keys "echo '👁️  File watcher - monitor changes'" C-m
    tmux send-keys "echo 'Use: tail -f logs/* or similar commands'" C-m

    # Create documentation window
    tmux new-window -n "Docs" -c "$CLAUDE_DEV_DIR"
    tmux send-keys -t "Docs" "echo '📚 Claude Code Documentation'" C-m
    tmux send-keys -t "Docs" "echo '📖 README, examples, and API docs'" C-m

    # Select the editor window
    tmux select-window -t "Editor"

else
    echo "💡 Not in tmux session. Use sesh connect to start this session properly."
fi

echo "✅ Claude Code development environment ready!"