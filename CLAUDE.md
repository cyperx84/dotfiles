---
id: CLAUDE
tags:
  - claude-md
---

# CLAUDE.md

This file provides guidance to Claude Code when working with this macOS dotfiles repository.

## 🚀 Quick Start - Most Used Commands

```bash
# Install all dotfiles
stow */

# Service management (after config changes)
brew services restart yabai && brew services restart sketchybar
sketchybar --reload
tmux source-file ~/.tmux.conf

# Validation & testing
~/bin/validate_sesh.sh                                    # Validate sesh config
~/.config/sketchybar/test_sketchybar.sh                  # Test all plugins
yabai --check-config                                      # Validate yabai config

# Session management (sesh aliases)
sl                                                        # List sessions
sd                                                        # Fuzzy connect
sesh-dashboard                                           # Full dashboard

# Configuration reload
exec zsh                                                  # Reload shell
```

## 📍 Critical File Locations

```
Core Configs:
├── zsh/.zshrc                                           # Shell: aliases, functions, keybinds
├── tmux/.tmux.conf                                      # Multiplexer: Ctrl+A prefix
├── nvim/.config/nvim/lua/keymaps.lua                   # Neovim keybinds
├── yabai/.config/yabai/yabairc                         # Window manager
├── skhd/.config/skhd/skhdrc                            # Hotkey daemon
├── ghostty/.config/ghostty/config                      # Terminal
└── sketchybar/.config/sketchybar/sketchybarrc          # Menu bar

Validation Scripts:
├── ~/bin/validate_sesh.sh
├── ~/.config/sketchybar/test_sketchybar.sh
├── ~/.config/sketchybar/debug_sketchybar.sh
└── ~/.config/sketchybar/plugin_health_monitor.sh
```

## 🎯 User Intent Mapping

| User Query | Action | Reference |
|------------|--------|-----------|
| "Keybinds" / "Shortcuts" | Check keybindings | @docs/KEYBINDS.md, @docs/NEOVIM_KEYBINDS.md |
| "How tools work together" | Check workflows | @docs/WORKFLOW_GUIDES.md |
| "Component details" | Check components | @docs/COMPONENTS.md |
| "Not working" / "Broken" | Troubleshoot | @docs/MAINTENANCE.md |
| "Statusline" / "Context" | Check statusline | @docs/CLAUDE_STATUSLINE.md |
| "Agent development" | Check guidelines | @AGENTS.md |
| "Repository overview" | Check README | @README.md |

## ⚠️ IMPORTANT - Things You MUST NOT Do

1. **DO NOT** modify the following without explicit user request:
   - `zsh/.zshrc` brew() function (SketchyBar integration dependency)
   - Service restart sequences (order matters: yabai → skhd → sketchybar)
   - Stow directory structure (breaking symlinks will break the entire setup)

2. **DO NOT** create new documentation files unless explicitly requested

3. **DO NOT** suggest changes to:
   - Karabiner-Elements vs Kanata setup (user has chosen Karabiner)
   - Tmux prefix (Ctrl+A is intentional, not Ctrl+B)
   - Yabai gap sizes (1px is intentional)

4. **ALWAYS** validate before suggesting changes:
   - Run validation scripts before declaring changes complete
   - Test service restarts after config modifications
   - Verify stow symlinks after structural changes

## 🏗️ Repository Architecture

**Overview:** Comprehensive macOS development environment with 10 integrated components managed via GNU Stow.

### Window Management Stack (Tightly Coupled)
- **Yabai** - BSP tiling window manager (1px gaps, 32px top padding for SketchyBar)
- **SKHD** - Hotkey daemon (unified hotkeys for Yabai + SketchyBar)
- **SketchyBar** - Menu bar replacement (30+ plugins, external bar mode)

### Terminal Environment (3-Layer)
- **Ghostty** - GPU-accelerated terminal with shader support
- **Tmux** - Multiplexer (Ctrl+A prefix, Catppuccin theme, 10+ plugins)
- **Zsh** - Enhanced shell (FZF integration, extensive aliases)

### Development Tools
- **Neovim** - 49 Lua config files (kickstart.nvim based)
- **Starship** - 6 interchangeable prompt themes
- **Sesh** - Session management with enhanced aliases
- **Tmuxinator** - Complex tmux session layouts

### Input Management
- **Karabiner-Elements** - Active (Caps→Ctrl, Right Cmd/Shift→Backspace)
- **Kanata** - Configured but inactive (home row mods available)

## 🛠️ Common Tasks

### Installation & Setup

```bash
# Prerequisites
brew install yabai skhd sketchybar stow starship tmux \
  zsh-fast-syntax-highlighting zsh-autosuggestions fzf fd bat eza zoxide ripgrep \
  nvim git gh yazi sesh jq wget curl

brew install --cask ghostty karabiner-elements font-monaspace font-meslo-lg-nerd-font

# Install all configs
stow */

# Or install specific components
stow zsh tmux nvim ghostty

# Unstow (remove symlinks)
stow -D ghostty
```

### Service Management

```bash
# Start services (first time)
brew services start yabai skhd sketchybar

# Restart after config changes (REQUIRED)
brew services restart yabai
brew services restart sketchybar
```

### Configuration Validation

```bash
# Yabai
yabai --check-config
tail -f /usr/local/var/log/skhd/skhd.out.log

# SketchyBar
~/.config/sketchybar/test_sketchybar.sh              # Test all
~/.config/sketchybar/test_sketchybar.sh github      # Test specific

# Debug tools
~/.config/sketchybar/debug_sketchybar.sh             # Full debug
~/.config/sketchybar/plugin_health_monitor.sh test  # Health check

# Sesh
~/bin/validate_sesh.sh
```

### Theme Switching

```bash
# Edit ~/.zshrc and change STARSHIP_CONFIG line to one of:
export STARSHIP_CONFIG=~/.config/starship/starship-gruvbox-dark-neon.toml
export STARSHIP_CONFIG=~/.config/starship/starship-gruvbox-rainbow.toml
export STARSHIP_CONFIG=~/.config/starship/starship-jetpack.toml

# Apply
exec zsh
```

### Session Management (Sesh)

```bash
# Quick commands (aliases in ~/.zshrc)
sl                      # List sessions
sd                      # Fuzzy connect
sc <name>              # Connect to specific session
sesh-dashboard         # Comprehensive dashboard
sesh-kill <name>       # Kill session
sesh-kill-all          # Kill all sessions

# Tmuxinator integration
sesh-tmux              # List layouts
sesh-start <layout>    # Start layout

# Validation
~/bin/validate_sesh.sh
```

## 🔗 Key Integration Points

### SketchyBar-Brew Integration
**CRITICAL:** `.zshrc` contains custom `brew()` function that triggers SketchyBar updates. DO NOT modify without understanding dependencies.

### FZF Shell Functions
Custom navigation functions in `.zshrc`:
- `fcd` - Fuzzy directory navigation
- `fv` - Fuzzy file open with editor
- `f` - General fuzzy file operations

### Custom Aliases
Extensive alias system (50+ git aliases, Docker/K8s workflows, navigation shortcuts).
See complete list: `alias | grep` or check `.zshrc` lines 100-300.

### Session Management Triple-System
Three concurrent session management systems:
1. **Tmux resurrect/continuum** - Session persistence
2. **Sesh** - Project-based templates with FZF integration
3. **Tmuxinator** - Complex multi-window layouts

When modifying session configs, consider interactions between all three.

## 🐛 Troubleshooting Quick Reference

### SketchyBar Issues

```bash
# GitHub plugin not working
gh auth status
GITHUB_DEBUG=1 ~/.config/sketchybar/debug_sketchybar.sh github

# Helper binary issues
cd ~/.config/sketchybar/helper && make clean && make

# Plugin not updating
~/.config/sketchybar/plugin_health_monitor.sh test <plugin_name>
sketchybar --trigger <plugin_name>.update
```

### Service Issues

```bash
# Services won't start
brew services list                                   # Check status
tail -f /usr/local/var/log/yabai/yabai.out.log      # Yabai logs
tail -f /usr/local/var/log/skhd/skhd.out.log        # SKHD logs

# Config syntax errors
yabai --check-config
```

### Stow Issues

```bash
# Conflicts during stow
stow -D <component>  # Unstow first
stow <component>     # Re-stow

# Check current symlinks
ls -la ~/.<config_file>
```

## 📚 Documentation Reference

This repository has comprehensive documentation for detailed information:

| Document | Purpose |
|----------|---------|
| @README.md | Repository overview and quick start |
| @docs/COMPONENTS.md | Detailed component documentation |
| @docs/KEYBINDS.md | Complete keybindings reference |
| @docs/NEOVIM_KEYBINDS.md | Neovim-specific mappings |
| @docs/WORKFLOW_GUIDES.md | Cross-tool integration workflows |
| @docs/CLAUDE_STATUSLINE.md | Statusline interpretation guide |
| @docs/MAINTENANCE.md | Validation and troubleshooting |
| @AGENTS.md | Agent development guidelines |

## 🔧 Development Considerations

### Service Dependencies
- Yabai/SKHD config changes → `brew services restart`
- SketchyBar config changes → `sketchybar --reload`
- Plugin changes → Test individual plugin before full reload

### Configuration Validation Workflow
1. Make changes to config files
2. Run validation script (`yabai --check-config`, `~/bin/validate_sesh.sh`, etc.)
3. Restart affected service
4. Verify functionality
5. Check logs if issues occur

### Plugin Development (SketchyBar)
- Follow event-driven pattern (see existing plugins in `sketchybar/.config/sketchybar/plugins/`)
- Integrate with event system in main sketchybarrc
- Test with `~/.config/sketchybar/test_sketchybar.sh`

### Input Management Switch (Karabiner ↔ Kanata)
Currently using Karabiner-Elements. To switch to Kanata:
1. Stop Karabiner service
2. `sudo kanata --cfg ~/.config/kanata/kanata.kbd`
3. Configure launch daemon for auto-start

**Kanata features:** Home row mods (a/s/d/f/j/k/l/; as modifiers), 150ms tap/200ms hold, layer-based mapping.

## 📋 Code Style & Conventions

- **Bash scripts:** Use `#!/usr/bin/env bash`, include error handling
- **Lua configs:** Follow kickstart.nvim patterns, modular plugin structure
- **Stow structure:** Keep directory structure matching target locations
- **Comments:** Inline for complex logic, header blocks for files

## 🏷️ Recent Updates

- Added Kanata keyboard remapper as alternative to Karabiner-Elements
- Added Tmuxinator for complex session layouts
- Enhanced Sesh workflow with FZF integration and validation tools
- Expanded SketchyBar to 30+ plugins with comprehensive testing framework
