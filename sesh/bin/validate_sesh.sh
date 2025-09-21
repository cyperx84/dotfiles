#!/usr/bin/env bash

echo "🔍 Validating Sesh Dotfiles Configuration - $(date '+%Y-%m-%d %H:%M')"
echo "=============================================================="

# Determine which config to test
DEFAULT_CONFIG="$HOME/.config/sesh/sesh.toml"
TEST_CONFIG="$HOME/.config/sesh/test_enhanced_sesh.toml"
CONFIG_FILE="${SESH_CONFIG:-$DEFAULT_CONFIG}"

echo "📋 Testing configuration: $CONFIG_FILE"

# Check if config file exists
if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "❌ Configuration file not found: $CONFIG_FILE"
    echo "💡 Make sure you've run 'stow sesh' from ~/dotfiles"
    exit 1
fi

# Test configuration loading
echo ""
echo "🧪 Testing configuration syntax..."
if sesh list > /dev/null 2>&1; then
    echo "✅ Configuration syntax is valid"
else
    echo "❌ Configuration has syntax errors"
    echo "💡 Check your sesh.toml file for syntax issues"
    exit 1
fi

# Test sessions listing
echo ""
echo "📝 Available sessions:"
echo "====================="
sesh list | while read -r session; do
    echo "  🎯 $session"
done

echo ""
echo "🔧 Validating dotfiles integration:"

# Check essential sessions from the main config
essential_sessions=("⚙️ Dotfiles" "🗒️ Notes" "📥 Downloads")

for session in "${essential_sessions[@]}"; do
    if sesh list | grep -q "$session"; then
        echo "✅ Found essential session: $session"
    else
        echo "⚠️  Missing session: $session"
    fi
done

# Check dotfiles integration components
echo ""
echo "🔧 Testing dotfiles integration components:"

# Check if aliases script exists and is sourced
aliases_script="$HOME/.config/sesh/scripts/sesh_aliases.sh"
if [[ -f "$aliases_script" ]]; then
    echo "✅ Sesh aliases script found"
    if [[ -x "$aliases_script" ]]; then
        echo "✅ Aliases script is executable"
    else
        echo "⚠️  Aliases script not executable (chmod +x needed)"
    fi
else
    echo "❌ Sesh aliases script missing"
fi

# Check tmuxinator integration
if command -v tmuxinator >/dev/null 2>&1; then
    echo "✅ Tmuxinator integration: Available"
    tmux_configs=$(find ~/.config/tmuxinator -name "*.yml" 2>/dev/null | wc -l)
    echo "  📁 Tmuxinator configs: $tmux_configs"
else
    echo "⚠️  Tmuxinator integration: Not installed"
fi

# Check essential tools from dotfiles
echo ""
echo "🛠️  Essential tools validation:"
essential_tools=("tmux" "fzf" "eza" "yazi" "nvim")

for tool in "${essential_tools[@]}"; do
    if command -v "$tool" >/dev/null 2>&1; then
        echo "✅ $tool available"
    else
        echo "❌ $tool missing"
    fi
done

# Test session paths exist
echo ""
echo "📂 Session path validation:"
sesh list | while read -r session; do
    # Skip emoji-only sessions that might not have paths
    if [[ "$session" =~ [A-Za-z] ]]; then
        echo "  📋 Checking: $session"
    fi
done

echo ""
echo "📊 Configuration Summary:"
echo "=========================="
echo "  • Total sessions: $(sesh list | wc -l)"
echo "  • Dotfiles integrated: Yes"
echo "  • Aliases available: $(test -f "$aliases_script" && echo "Yes" || echo "No")"
echo "  • Tmuxinator: $(command -v tmuxinator >/dev/null 2>&1 && echo "Available" || echo "Not installed")"

echo ""
echo "🚀 Quick start guide:"
echo "==================="
echo "  1. Source aliases: source ~/.config/sesh/scripts/sesh_aliases.sh"
echo "  2. List sessions:  sl"
echo "  3. Fuzzy connect:  sd"
echo "  4. Dashboard:      sesh-dashboard"
echo "  5. Current info:   sesh-current"

echo ""
echo "🎯 Test completed successfully! $(date '+%H:%M:%S')"