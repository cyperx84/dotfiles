#!/usr/bin/env bash

# Test Environment Setup Script
# Creates an isolated workspace for testing code snippets and experiments

set -euo pipefail

echo "🔬 Setting up Claude Code testing environment..."

# Set up test workspace
TEST_DIR="$HOME/Code/test-workspace"

# Create test directory if it doesn't exist
if [[ ! -d "$TEST_DIR" ]]; then
    echo "📁 Creating test workspace directory: $TEST_DIR"
    mkdir -p "$TEST_DIR"
fi

cd "$TEST_DIR"

# Check if we're already in a tmux session
if [[ -n "${TMUX:-}" ]]; then
    echo "📍 Already in tmux session, setting up test environment..."

    # Create main testing window
    tmux new-window -n "Test" -c "$TEST_DIR"
    tmux send-keys -t "Test" "echo '🧪 Claude Code Testing Environment'" C-m
    tmux send-keys -t "Test" "echo '📝 Create test files and experiment here'" C-m
    tmux send-keys -t "Test" "echo ''" C-m
    tmux send-keys -t "Test" "ls -la" C-m

    # Split for scratch pad
    tmux split-window -v -c "$TEST_DIR"
    tmux send-keys "echo '📋 Scratch Pad - Quick Notes'" C-m
    tmux send-keys "echo '💡 Use this pane for temporary commands and notes'" C-m

    # Create editor window
    tmux new-window -n "Editor" -c "$TEST_DIR"
    tmux send-keys -t "Editor" "nvim ." C-m

    # Create monitoring window
    tmux new-window -n "Monitor" -c "$TEST_DIR"
    tmux send-keys -t "Monitor" "echo '📊 Test Monitor'" C-m
    tmux send-keys -t "Monitor" "echo '👁️  Watch for file changes, run tests, check outputs'" C-m

    # Split for git status
    tmux split-window -h -c "$TEST_DIR"
    tmux send-keys "git status 2>/dev/null || echo 'Not a git repository - run git init if needed'" C-m

    # Select the main test window
    tmux select-window -t "Test"

else
    echo "💡 Not in tmux session. Use sesh connect to start this session properly."
fi

echo "✅ Test environment ready at $TEST_DIR"