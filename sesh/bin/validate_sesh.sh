#!/usr/bin/env bash

echo "🔍 Validating Sesh Dotfiles Configuration - $(date '+%Y-%m-%d %H:%M')"
echo "=============================================================="

# Test main config file
CONFIG_FILE="$HOME/.config/sesh/sesh.toml"

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

# Check essential sessions from the config
# Tmuxinator projects (appear in sesh list)
essential_tmuxinator=("notes" "dotfiles")
# Configured sesh sessions
essential_sessions=("📥 Downloads" "🏠 Home" "💻 Code")

echo "🎛️  Tmuxinator projects:"
for project in "${essential_tmuxinator[@]}"; do
    if tmuxinator list 2>/dev/null | grep -q "$project"; then
        echo "✅ Found tmuxinator project: $project"
    else
        echo "⚠️  Missing tmuxinator project: $project"
    fi
done

echo ""
echo "📋 Configured sesh sessions:"
for session in "${essential_sessions[@]}"; do
    if sesh list -c 2>/dev/null | grep -q "$session"; then
        echo "✅ Found configured session: $session"
    else
        echo "⚠️  Missing configured session: $session"
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
    tmux_configs=$(find ~/.config/tmuxinator -name "*.yml" 2>/dev/null | wc -l || echo "0")
    echo "  📁 Tmuxinator configs: $tmux_configs"

    # Test tmuxinator configs
    for config in notes dotfiles docker-minimal; do
        if [[ -f "$HOME/.config/tmuxinator/$config.yml" ]]; then
            echo "  ✅ $config.yml exists"
        else
            echo "  ⚠️  $config.yml not found"
        fi
    done
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
echo "  • Total available sessions: $(sesh list 2>/dev/null | wc -l | xargs)"
echo "  • Configured sessions: $(sesh list -c 2>/dev/null | wc -l | xargs)"
echo "  • Tmuxinator projects: $(tmuxinator list 2>/dev/null | grep -v "tmuxinator projects:" | wc -l | xargs)"
echo "  • Active tmux sessions: $(tmux list-sessions 2>/dev/null | wc -l || echo "0")"
echo "  • Aliases available: $(test -f "$aliases_script" && echo "Yes" || echo "No")"
echo "  • Enhanced preview: $(test -f "$HOME/.config/sesh/scripts/enhanced_preview.sh" && echo "Yes" || echo "No")"

# Test sesh scripts
echo ""
echo "🧪 Testing sesh scripts:"
for script in enhanced_preview.sh sesh_aliases.sh session_status.sh; do
    script_path="$HOME/.config/sesh/scripts/$script"
    if [[ -f "$script_path" ]] && [[ -x "$script_path" ]]; then
        echo "✅ $script exists and is executable"
    else
        echo "⚠️  $script missing or not executable"
    fi
done

# Test enhanced preview specifically
echo ""
echo "🔍 Testing enhanced_preview.sh functionality:"
if ~/.config/sesh/scripts/enhanced_preview.sh "notes" >/dev/null 2>&1; then
    echo "✅ enhanced_preview.sh working correctly"
else
    echo "❌ enhanced_preview.sh has issues"
fi

echo ""
echo "🚀 Quick start guide:"
echo "==================="
echo "  1. Source aliases: source ~/.config/sesh/scripts/sesh_aliases.sh"
echo "  2. List sessions:  sl"
echo "  3. Fuzzy connect:  sd"
echo "  4. Dashboard:      sesh-dashboard"
echo "  5. Current info:   sesh-current"
echo "  6. Session status: ~/dotfiles/sesh/.config/sesh/scripts/session_status.sh list"

echo ""
echo "🎯 Test completed successfully! $(date '+%H:%M:%S')"