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
   - Always restart: HyprSpace → borders → sketchybar
   - Don't change service management procedures without testing

3. **Stow directory structure**
   - Breaking symlinks breaks the entire setup
   - Always test with `stow -nv <component>` before applying

4. **Key system preferences**
   - Tmux prefix (Ctrl+A is intentional, not Ctrl+B)
   - HyprSpace gap sizes (20px inner, 52px top for SketchyBar)
   - Kanata is PRIMARY keyboard remapper (Karabiner unconfigured)

## 📂 Repository Structure

### Core Configuration Directories

```
dotfiles/
├── aerospace/              # HyprSpace tiling WM: hyprspace.toml (dwindle layout)
├── borders/                # JankyBorders: bordersrc (window borders)
├── zsh/                    # Shell: .zshrc, aliases, functions
├── tmux/                   # Multiplexer: .tmux.conf + plugins
├── nvim/                   # Editor: 42+ plugins (git subtree)
├── sketchybar/             # Menu bar: sketchybarrc + 37 plugins
├── ghostty/                # Terminal: config + 13 shaders
├── starship/               # Prompt: 5 theme variants
├── kanata/                 # Keyboard: kanata.kbd (ACTIVE - PRIMARY)
├── karabiner/              # Keyboard alt: karabiner.json (inactive)
├── sesh/                   # Session manager: sesh.toml + 25 scripts
├── mcp/ + mcphub/          # Model Context Protocol
└── claude/                 # Claude Code config + agents
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
brew install --cask BarutSRB/tap/hyprspace  # HyprSpace tiling WM
brew tap FelixKratz/formulae && brew install borders  # JankyBorders
brew install sketchybar stow starship tmux

# Install all configs
stow */

# Start services
open -a HyprSpace  # App-based, not brew service
brew services start sketchybar
```

### Service Management

**Start**:
```bash
open -a HyprSpace                          # Window manager (app)
borders &                                   # Window borders
brew services start sketchybar
```

**Restart** (after config changes):
```bash
killall HyprSpace && open -a HyprSpace     # Restart HyprSpace
killall borders && borders &                # Restart borders
brew services restart sketchybar
```

**Reload** (without restart):
```bash
hyprspace reload-config                     # Reload HyprSpace config
sketchybar --reload
tmux source-file ~/.tmux.conf
exec zsh
```

### Validation & Testing

**Components WITH automated validation**:
```bash
hyprspace reload-config                     # HyprSpace validates on reload
~/.config/sketchybar/test_sketchybar.sh     # Test SketchyBar plugins
nvim --cmd "checkhealth"                    # Neovim health check
```

**Components WITHOUT automated validation**:
```bash
# Manual checks required:
sesh list                         # Check sesh (no script available)
killall borders && borders &      # Borders - restart to check
tmux source-file ~/.tmux.conf     # Tmux syntax check
# Check Console.app for HyprSpace errors
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
Currently using **Kanata** (PRIMARY) with home row mods. Karabiner-Elements is installed but unconfigured.
Config: `kanata/.config/kanata/kanata.kbd`

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
# Check if HyprSpace is running
pgrep -l HyprSpace

# Check if borders is running
pgrep -l borders

# Restart HyprSpace (validates config on startup)
killall HyprSpace && open -a HyprSpace

# Check Console.app for "HyprSpace" errors

# Restart borders
killall borders && borders &
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

**HyprSpace**:
```bash
# View in Console.app - filter for "HyprSpace"
# Or use log stream:
log show --predicate 'process == "HyprSpace"' --last 10m
```

**SketchyBar**:
```bash
log stream --predicate 'process == "sketchybar"'
```

**Kanata**:
```bash
sudo launchctl print system/com.example.kanata  # Check status
log show --predicate 'process == "kanata"' --last 10m
```

## 🔄 Recent Changes

### Dec 2025 Updates
- **Kanata**: Now PRIMARY keyboard remapper (Karabiner unconfigured)
- **Sesh Scripts**: Located in `sesh/.config/sesh/scripts/` (organized into core/, lib/, utils/)
- **Validation**: `~/bin/validate_sesh.sh` was removed; use `sesh list` for manual validation

### Oct 2025 Updates
- **Nvim Git Subtree**: Converted from git submodule to git subtree
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

### Sesh Session Scripts

**Location**: `sesh/.config/sesh/scripts/`

**Structure**:
- `core/sesh_switcher.sh` - Main session switching logic
- `lib/sesh_colors.sh` - Color definitions
- `utils/` - Utility scripts
- Root: sesh_list_enhanced.sh, sesh_preview.sh, sesh_smart_start.sh, etc.

Referenced in:
- `tmux/.tmux.conf` (keybindings)
- `sesh/.config/sesh/sesh.toml` (preview_command)

## 🛡️ Safety Protocols

### Before Making Changes

1. **Always validate configuration first**:
   ```bash
   hyprspace reload-config  # For HyprSpace changes (validates on reload)
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
| Editor | `nvim/.config/nvim/init.lua` | 42+ plugins (git subtree) |
| Window Manager | `aerospace/.config/aerospace/hyprspace.toml` | Dwindle layout |
| Window Borders | `borders/.config/borders/bordersrc` | JankyBorders |
| Menu Bar | `sketchybar/.config/sketchybar/sketchybarrc` | 37 plugins |
| Terminal | `ghostty/.config/ghostty/config` | GPU-accelerated + shaders |
| Prompt | `starship/.config/starship/starship.toml` | Gruvbox Dark Neon |
| Keyboard | `kanata/.config/kanata/kanata.kbd` | Home row mods (PRIMARY) |

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

*Last Updated: Jan 2026 - HyprSpace + Dwindle Layout Migration*
