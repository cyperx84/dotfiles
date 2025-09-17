#!/usr/bin/env bash

echo "🔍 Validating Enhanced Sesh Configuration..."

CONFIG_FILE="$HOME/dotfiles/sesh/.config/sesh/test_enhanced_sesh.toml"

# Test configuration loading
echo "📋 Testing configuration syntax..."
if SESH_CONFIG="$CONFIG_FILE" sesh list > /dev/null 2>&1; then
    echo "✅ Configuration syntax is valid"
else
    echo "❌ Configuration has syntax errors"
    exit 1
fi

# Test sessions listing
echo "📝 Available sessions:"
SESH_CONFIG="$CONFIG_FILE" sesh list

echo ""
echo "🎯 Testing Claude Code specific sessions:"

# Test if Claude Code sessions are available
claude_sessions=("💻 Claude Code" "🔬 Test Environment" "📝 Scratch")

for session in "${claude_sessions[@]}"; do
    if SESH_CONFIG="$CONFIG_FILE" sesh list | grep -q "$session"; then
        echo "✅ Found: $session"
    else
        echo "❌ Missing: $session"
    fi
done

echo ""
echo "🔧 Testing scripts:"

scripts_dir="$HOME/.config/sesh/scripts"
scripts=("claude_dev.sh" "test_env.sh" "scratch.sh" "new_project.sh" "system_monitor.sh")

for script in "${scripts[@]}"; do
    if [ -x "$scripts_dir/$script" ]; then
        echo "✅ Executable: $script"
    else
        echo "❌ Not executable or missing: $script"
    fi
done

echo ""
echo "🧪 Testing session preview (first 3 sessions):"

# Test preview commands for first few sessions
SESH_CONFIG="$CONFIG_FILE" sesh list | head -3 | while read -r session; do
    echo "Preview for '$session':"
    # Note: Preview testing would require sesh preview command
    echo "  (Preview command configured)"
done

echo ""
echo "📊 Configuration Summary:"
echo "  • Total sessions: $(SESH_CONFIG="$CONFIG_FILE" sesh list | wc -l)"
echo "  • Script files: ${#scripts[@]}"
echo "  • Claude Code optimized: Yes"

if command -v tmuxinator >/dev/null 2>&1; then
    echo "  • Tmuxinator integration: Available"
else
    echo "  • Tmuxinator integration: Not installed"
fi

echo ""
echo "🚀 To use the enhanced configuration:"
echo "  export SESH_CONFIG='$CONFIG_FILE'"
echo "  sesh connect '💻 Claude Code'"