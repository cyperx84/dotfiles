---
id: CLAUDE
tags: []
---

# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a comprehensive macOS development environment dotfiles repository featuring a highly integrated window management and terminal-centric workflow. The setup centers around 10 main configuration components that work together to create a tiling window manager environment with advanced terminal productivity tools. All configurations are managed using GNU Stow for automated symlink creation.

## Architecture & Component Integration

### Window Management Stack
The core of this setup is a three-part window management system:
- **Yabai** (`yabai/.config/yabai/yabairc`) - BSP tiling window manager with 1px gaps
- **SKHD** (`skhd/.config/skhd/skhdrc`) - Hotkey daemon for window control
- **SketchyBar** (`sketchybar/.config/sketchybar/sketchybarrc`) - Menu bar replacement with 30+ plugins

These components are tightly integrated: Yabai reserves 32px for SketchyBar's external bar, and SKHD provides unified hotkeys for both window management and SketchyBar interactions.

### Terminal Environment
Three-layer terminal setup optimized for development:
- **Ghostty** (`ghostty/.config/ghostty/config`) - GPU-accelerated terminal with shader support
- **Tmux** (`tmux/.tmux.conf`) - Multiplexer with Ctrl+A prefix and Catppuccin theme
- **Zsh** (`zsh/.zshrc`) - Enhanced shell with FZF integration and extensive aliases

Key integration: Ghostty optimized for Tmux with specific font ligature and GPU settings.

### Development Tools
- **Neovim** (`nvim/.config/nvim/`) - 49 Lua configuration files based on kickstart.nvim
- **Starship** (`starship/.config/starship/`) - 6 interchangeable prompt themes
- **Sesh** (`sesh/.config/sesh/sesh.toml`) - Session management
- **Tmuxinator** (`tmuxinator/.config/tmuxinator/`) - Complex tmux session layouts

### Input Management
- **Karabiner-Elements** - Currently active keyboard remapping (simple mappings)
- **Kanata** (`kanata/.config/kanata/kanata.kbd`) - Advanced keyboard remapper with home row mods (configured but inactive)

## Prerequisites & Dependencies

### Essential Homebrew Packages
The dotfiles setup requires specific Homebrew packages to function properly:

```bash
# Core applications (casks)
brew install --cask ghostty karabiner-elements font-monaspace font-meslo-lg-nerd-font

# System & window management
brew install yabai skhd sketchybar stow

# Shell & terminal enhancement  
brew install starship tmux zsh-fast-syntax-highlighting zsh-autosuggestions fzf fd bat eza zoxide ripgrep

# Development tools
brew install nvim git gh yazi sesh jq wget curl

# Optional advanced tools
brew install kanata tmuxinator
```

## Common Development Commands

### Service Management
```bash
# Start/stop core services
brew services start yabai
brew services start skhd
brew services start sketchybar

# Restart services after config changes
brew services restart yabai
brew services restart sketchybar
```

### Installation Workflow
The repository uses GNU Stow for automated symlink management:
```bash
# Install all configurations
stow */

# Install specific components
stow ghostty
stow nvim
stow tmux
stow zsh

# Remove/unstow configurations
stow -D ghostty
```

### Theme Switching
```bash
# Starship prompt themes (modify in ~/.zshrc)
export STARSHIP_CONFIG=~/.config/starship/starship-gruvbox-dark-neon.toml
export STARSHIP_CONFIG=~/.config/starship/starship-gruvbox-rainbow.toml
export STARSHIP_CONFIG=~/.config/starship/starship-jetpack.toml

# Apply changes
exec zsh
```

### Configuration Reloading
```bash
# Reload configurations without restarting
sketchybar --reload
yabai --restart-service
tmux source-file ~/.tmux.conf
```

### SketchyBar Development Tools & Testing

The SketchyBar setup includes comprehensive testing and monitoring tools for development components:

#### Testing Framework
```bash
# Test all development plugins
~/.config/sketchybar/test_sketchybar.sh

# Test specific components
~/.config/sketchybar/test_sketchybar.sh github
```

#### Debug Tools
```bash
# Full debugging session
~/.config/sketchybar/debug_sketchybar.sh

# Debug specific plugin
~/.config/sketchybar/debug_sketchybar.sh plugin git

# Monitor plugins in real-time
~/.config/sketchybar/debug_sketchybar.sh monitor

# Debug GitHub-specific issues
~/.config/sketchybar/debug_sketchybar.sh github
```

#### Health Monitoring
```bash
# Test all development plugins
~/.config/sketchybar/plugin_health_monitor.sh test

# Continuous monitoring
~/.config/sketchybar/plugin_health_monitor.sh monitor

# Health report
~/.config/sketchybar/plugin_health_monitor.sh report

# Check dependencies
~/.config/sketchybar/plugin_health_monitor.sh deps
```

#### Troubleshooting Common Issues

**GitHub Plugin Not Working:**
```bash
# Check authentication
gh auth status

# Enable debug logging
GITHUB_DEBUG=1 ~/.config/sketchybar/debug_sketchybar.sh github

# Test notifications API
gh api notifications
```

**Helper Binary Issues:**
```bash
# Recompile helper binary
cd ~/.config/sketchybar/helper && make clean && make

# Check compilation dependencies
~/.config/sketchybar/debug_sketchybar.sh helper
```

**Plugin Not Updating:**
```bash
# Check plugin execution
~/.config/sketchybar/plugin_health_monitor.sh test <plugin_name>

# Force update
sketchybar --trigger <plugin_name>.update
```

## Key Integration Points

### SketchyBar-Brew Integration
The `.zshrc` contains a custom `brew()` function that triggers SketchyBar updates after package operations. When modifying brew-related functionality, ensure this integration remains intact.

### FZF Shell Functions
Three custom navigation functions in `.zshrc`:
- `fcd` - Fuzzy directory navigation
- `fv` - Fuzzy file opening with editor
- `f` - General fuzzy file operations

### Custom Aliases System
Extensive alias system covering:
- Git operations (50+ aliases)
- Docker and Kubernetes workflows
- Directory navigation shortcuts
- Development tool shortcuts

## Important File Locations

### Core Configuration Files
- `ghostty/.config/ghostty/config` - Terminal appearance and GPU settings
- `yabai/.config/yabai/yabairc` - Window manager rules and behavior
- `skhd/.config/skhd/skhdrc` - All hotkey definitions
- `tmux/.tmux.conf` - Terminal multiplexer with 10+ plugins
- `zsh/.zshrc` - Shell configuration with custom functions

### Plugin Ecosystems
- `sketchybar/.config/sketchybar/plugins/` - 30+ system monitoring and integration plugins
- `nvim/.config/nvim/lua/custom/plugins/` - Neovim plugin configurations
- `ghostty/.config/ghostty/shaders/` - GLSL visual effect shaders

### Theme Configurations
- `starship/.config/starship/` - 6 different prompt theme files
- Naming pattern: `starship-{theme-name}.toml`

## Development Considerations

### Service Dependencies
Changes to yabai or skhd configurations require service restarts. SketchyBar plugins may need individual reloading via `sketchybar --reload`.

### Configuration Validation
When modifying configurations:
- Yabai: Check syntax with `yabai --check-config`
- SKHD: Monitor logs with `tail -f /usr/local/var/log/skhd/skhd.out.log`
- SketchyBar: Test individual plugins before full reload

### Plugin Development
SketchyBar plugins follow a standard pattern with event-driven updates. New plugins should integrate with the existing event system defined in the main sketchybarrc file.

### Session Management
The setup uses multiple session management approaches:
- Tmux with resurrect/continuum for session persistence
- Sesh for project-based session templates
- Tmuxinator for complex session layouts

When working with session-related configurations, consider the interaction between these three systems.

### Input Management Systems
Two keyboard remapping solutions are available:

**Karabiner-Elements (Active):**
- Simple key remappings: Caps Lock → Control, Right Cmd/Shift → Backspace
- Function key pass-through
- Device-specific configurations
- Recommended for most users

**Kanata (Configured but Inactive):**
- Advanced home row modifiers (a/s/d/f/j/k/l/; become modifiers on hold)
- Layer-based key mapping system
- 150ms tap time, 200ms hold time
- More complex but powerful - requires manual activation if desired

To switch from Karabiner-Elements to Kanata:
1. Stop Karabiner-Elements service
2. Start kanata service: `sudo kanata --cfg ~/.config/kanata/kanata.kbd`
3. Configure kanata as a launch daemon for automatic startup

## Recent Updates
- Added kanata keyboard remapper as alternative to Karabiner-Elements
- Added tmuxinator for complex session layouts  
- Updated component count from 9 to 10 main components
- Added input management system documentation
