---
id: AGENTS
tags:
  - agents
  - development
  - guidelines
---

# Agent Development Guidelines

> **📋 Purpose**: This document provides guidelines and procedures for AI agents working with the cyperx dotfiles repository. It ensures consistent, safe, and effective modifications to the system.

## 🚨 Critical Do Not Modify List

**⚠️ NEVER modify without explicit user request**:

1. **Zsh brew() function** (`zsh/.zshrc:45-53`)
   - SketchyBar's brew plugin depends on this function
   - Breaking this breaks real-time package update notifications
   - DO NOT: delete, rename, or modify trigger logic

2. **Service restart sequences** (order matters)
   - Always restart: yabai → skhd → sketchybar
   - Don't change service management procedures without testing

3. **Stow directory structure**
   - Breaking symlinks breaks the entire setup
   - Always test with `stow -nv <component>` before applying

4. **Key system preferences**
   - Tmux prefix (Ctrl+A is intentional, not Ctrl+B)
   - Yabai gap sizes (1px is intentional)
   - Karabiner vs Kanata setup (user has chosen Karabiner)

## 📂 Repository Structure

### Core Configuration Directories

```
dotfiles/
├── zsh/                    # Shell: .zshrc, aliases, functions
├── tmux/                   # Multiplexer: .tmux.conf + scripts/
├── nvim/                   # Editor: 68 plugins (git subtree)
├── yabai/                  # Window manager: yabairc
├── skhd/                   # Hotkeys: skhdrc
├── sketchybar/             # Menu bar: sketchybarrc + 69 plugins
├── ghostty/                # Terminal: config
├── starship/               # Prompt: 6 theme variants
├── karabiner/              # Keyboard: karabiner.json
├── kanata/                 # Keyboard alt: kanata.kbd (inactive)
├── sesh/                   # Session manager: sesh.toml
├── tmuxinator/             # Complex layouts: YAML configs
└── mcp/ + mcphub/          # Model Context Protocol
```

### Documentation Files

| File | Purpose |
|------|---------|
| `README.md` | Repository overview and quick start |
| `CLAUDE.md` | Claude Code specific guidance |
| `AGENTS.md` | This file - agent guidelines |
| `docs/COMPONENTS.md` | Detailed component documentation |
| `docs/KEYBINDS.md` | Complete keybindings reference |
| `docs/NEOVIM_KEYBINDS.md` | Neovim-specific mappings |
| `docs/WORKFLOW_GUIDES.md` | Cross-tool integration workflows |
| `docs/MAINTENANCE.md` | Validation and troubleshooting |
| `docs/CLAUDE_STATUSLINE.md` | Statusline interpretation |
| `nvim/README.md` | Neovim configuration guide (26KB) |

## 🔧 Common Tasks & Procedures

### Installation & Setup

```bash
# Prerequisites
brew install yabai skhd sketchybar stow starship tmux

# Install all configs
stow */

# Start services
brew services start yabai skhd sketchybar
```

### Service Management

**Start**:
```bash
brew services start yabai
brew services start skhd
brew services start sketchybar
```

**Restart** (after config changes):
```bash
brew services restart yabai
brew services restart skhd
brew services restart sketchybar
```

**Reload** (without restart):
```bash
sketchybar --reload
tmux source-file ~/.tmux.conf
exec zsh
```

### Validation & Testing

**Components WITH automated validation**:
```bash
yabai --check-config              # Validate yabai config
~/.config/sketchybar/test_sketchybar.sh   # Test SketchyBar plugins
nvim --cmd "checkhealth"         # Neovim health check
```

**Components WITHOUT automated validation**:
```bash
# Manual checks required:
sesh list                         # Check sesh (no script available)
tail -f /usr/local/var/log/skhd/skhd.out.log  # SKHD errors
tmux source-file ~/.tmux.conf     # Tmux syntax check
```

**⚠️ Important**: `~/bin/validate_sesh.sh` was **REMOVED** in Oct 2025.
Validation is now manual: `sesh list`

### Configuration Customization

**Starship Themes**:
Edit `~/.zshrc`, change STARSHIP_CONFIG line to one of:
- `~/.config/starship/starship-gruvbox-dark-neon.toml`
- `~/.config/starship/starship-gruvbox-rainbow.toml`
- `~/.config/starship/starship-jetpack.toml`
- `~/.config/starship/starship-tokyo-night.toml`

**Tmux Customization**:
```bash
# Float window settings in .tmux.conf
set -g @floax-width '80%'
set -g @floax-height '80%'
```

**Keyboard Remapping**:
Currently using **Karabiner-Elements** (not Kanata).
Config: `karabiner/karabiner.json`

## 🐛 Troubleshooting Procedures

### SketchyBar Issues

```bash
# Test all plugins
~/.config/sketchybar/test_sketchybar.sh

# Debug specific plugin
~/.config/sketchybar/debug_sketchybar.sh github

# Health check
~/.config/sketchybar/plugin_health_monitor.sh test

# Rebuild helper binary
cd ~/.config/sketchybar/helper && make clean && make

# Check logs
log stream --predicate 'process == "sketchybar"'
```

### Window Management Issues

```bash
# Check service status
brew services list | grep -E "(yabai|skhd)"

# Validate yabai config
yabai --check-config

# Check SKHD logs
tail -f /usr/local/var/log/skhd/skhd.out.log

# Restart services
brew services restart yabai skhd
```

### Session Management

```bash
# List sessions
sesh list

# Connect to session
sesh connect <session-name>

# Check tmux sessions
tmux list-sessions
```

### Service Log Locations

**Yabai**:
```bash
tail -f /usr/local/var/log/yabai/yabai.out.log
```

**SKHD**:
```bash
tail -f /usr/local/var/log/skhd/skhd.out.log
```

**SketchyBar**:
```bash
log stream --predicate 'process == "sketchybar"'
```

## 🔄 Recent Changes (Oct 2025)

### Critical Migrations

**1. Sesh Script Migration**
- **FROM**: `sesh/.config/sesh/scripts/` (7 scripts)
- **TO**: `tmux/.tmux/scripts/` (11 scripts)
- **IMPACT**: Session management now fully integrated into tmux workflow
- **NOTE**: `~/bin/validate_sesh.sh` was REMOVED

**2. Nvim Git Subtree**
- Converted from git submodule to git subtree
- Can be updated with: `git subtree pull --prefix nvim <repo> main`
- Can be used independently on any system

## 🏷️ Key Integration Points

### SketchyBar-Brew Integration

**CRITICAL**: `.zshrc` contains custom `brew()` function (lines ~45-53) that triggers SketchyBar updates.

**Location**: `zsh/.zshrc`

**Why Critical**: SketchyBar's brew plugin depends on this function.

**DO NOT**:
- Delete or rename the `brew()` function
- Modify trigger logic without testing
- Remove the `sketchybar --trigger brew_update` line

### FZF Shell Functions

Custom navigation in `.zshrc`:
- `fcd` - Fuzzy directory navigation
- `fv` - Fuzzy file open with editor
- `f` - General fuzzy file operations

### Tmux Custom Scripts

**Location**: `tmux/.tmux/scripts/`

**Scripts** (11 files):
- `sesh_list_enhanced.sh` - Enhanced session listing
- `sesh_list_icons.sh` - Icon mapping
- `sesh_preview.sh` - FZF preview window content
- `sesh_switcher.sh` - Main session switching logic
- `sesh_smart_start.sh` - Intelligent session creation
- `sesh_edit.sh` - Edit session configurations
- `session_helper.sh` - General utilities

Referenced in:
- `tmux/.tmux.conf` (keybindings)
- `sesh/.config/sesh/sesh.toml` (preview_command)

## 🛡️ Safety Protocols

### Before Making Changes

1. **Always validate configuration first**:
   ```bash
   yabai --check-config  # For yabai changes
   tmux source-file ~/.tmux.conf  # For tmux changes
   ```

2. **Test in dry-run mode**:
   ```bash
   stow -nv component-name  # See what would be changed
   ```

3. **Backup existing configs**:
   ```bash
   cp ~/.config/tool/config ~/.config/tool/config.backup
   ```

4. **Check service logs** after changes

### After Making Changes

1. **Restart affected services**
2. **Run validation scripts**
3. **Test functionality**
4. **Check logs for errors**

### Rollback Strategy

```bash
# Git rollback
cd ~/dotfiles
git reset --hard <commit_hash>

# Re-stow
stow -D */ && stow */

# Restart services
```

## 📋 Code Style & Conventions

- **Bash**: Use `#!/usr/bin/env bash`, include error handling
- **Lua**: Follow kickstart.nvim patterns, modular plugin structure
- **Stow**: Keep directory structure matching target locations
- **Comments**: Inline for complex logic, header blocks for files

## 🔍 Key File Locations

### Configuration Files

| Component | File | Purpose |
|-----------|------|---------|
| Shell | `zsh/.zshrc` | Aliases, functions, keybinds |
| Multiplexer | `tmux/.tmux.conf` | Ctrl+A prefix, theme |
| Editor | `nvim/.config/nvim/init.lua` | 68 plugins, 45 configs |
| Window Manager | `yabai/.config/yabai/yabairc` | BSP layout, 1px gaps |
| Hotkeys | `skhd/.config/skhd/skhdrc` | Window management |
| Menu Bar | `sketchybar/.config/sketchybar/sketchybarrc` | 69 plugins |
| Terminal | `ghostty/.config/ghostty/config` | GPU-accelerated |
| Prompt | `starship/.config/starship/starship.toml` | Gruvbox Dark Neon |
| Keyboard | `karabiner/.config/karabiner/karabiner.json` | Caps→Ctrl |

### Validation Scripts

| Script | Purpose |
|--------|---------|
| `~/.config/sketchybar/test_sketchybar.sh` | Test all SketchyBar plugins |
| `~/.config/sketchybar/debug_sketchybar.sh` | Debug SketchyBar issues |
| `~/.config/sketchybar/plugin_health_monitor.sh` | Monitor plugin health |

## 🤝 How to Contribute Changes

### For Human Users

1. Fork the repository
2. Create a feature branch
3. Make changes following these guidelines
4. Test thoroughly
5. Submit a pull request

### For AI Agents

1. **Understand the task** completely before starting
2. **Read relevant documentation** files first
3. **Check existing implementation** before modifying
4. **Validate changes** using appropriate scripts
5. **Document modifications** clearly
6. **Test thoroughly** before completion

**When uncertain**:
- Ask the user for clarification
- Check the most recent commits for context
- Review related configuration files
- Use validation scripts to verify

## 📚 Documentation Navigation

### For Component Information

- **Quick Start**: See `README.md` installation section
- **Detailed Component Info**: See `docs/COMPONENTS.md`
- **Keybindings**: See `docs/KEYBINDS.md`
- **Neovim Specific**: See `docs/NEOVIM_KEYBINDS.md` and `nvim/README.md`
- **Workflows**: See `docs/WORKFLOW_GUIDES.md`
- **Troubleshooting**: See `docs/MAINTENANCE.md`

### For Maintenance Tasks

- **Service Management**: See `docs/MAINTENANCE.md#service-management`
- **Validation**: See `docs/MAINTENANCE.md#validation-scripts`
- **Troubleshooting**: See `docs/MAINTENANCE.md#troubleshooting`
- **Updates**: See `docs/MAINTENANCE.md#updates--upgrades`

### For Development

- **Agent Guidelines**: This file (AGENTS.md)
- **Claude Code**: See `CLAUDE.md`
- **System Architecture**: See `docs/DOCUMENTATION_STRATEGY.md`

---

**Remember**: When working with this repository, prioritize safety, testing, and thorough validation. The system is highly integrated, so changes in one area may affect others.

*Last Updated: Oct 2025 - Post Sesh Script Migration*
