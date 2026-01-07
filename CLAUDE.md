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
# Aerospace (window manager):
killall AeroSpace && open -a AeroSpace                    # Restart Aerospace
killall borders && borders &                              # Restart window borders
sketchybar --reload                                       # Reload SketchyBar
tmux source-file ~/.tmux.conf                             # Reload tmux config

# Validation & testing
~/.config/sketchybar/test_sketchybar.sh                  # Test all plugins

# NOTE: ~/bin/validate_sesh.sh was REMOVED (Oct 2025)
# Sesh validation now manual: sesh list (check for errors)

# Configuration reload
exec zsh                                                  # Reload shell
```

## 📍 Critical File Locations

```
Core Configs:
├── zsh/.zshrc                                           # Shell: aliases, functions, keybinds
├── tmux/.tmux.conf                                      # Multiplexer: Ctrl+A prefix
├── nvim/.config/nvim/lua/keymaps.lua                   # Neovim keybinds
├── aerospace/.config/aerospace/aerospace.toml          # Window manager (Aerospace)
├── borders/.config/borders/bordersrc                   # Window borders (JankyBorders)
├── ghostty/.config/ghostty/config                      # Terminal
├── sketchybar/.config/sketchybar/sketchybarrc          # Menu bar
└── kanata/.config/kanata/kanata.kbd                    # Keyboard remapper (ACTIVE)

Validation Scripts:
├── ~/.config/sketchybar/test_sketchybar.sh
├── ~/.config/sketchybar/debug_sketchybar.sh
└── ~/.config/sketchybar/plugin_health_monitor.sh

System-Level Services (LaunchDaemons):
├── /Library/LaunchDaemons/com.example.kanata.plist
├── /Library/LaunchDaemons/com.example.karabiner-vhiddaemon.plist
└── /Library/LaunchDaemons/com.example.karabiner-vhidmanager.plist
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

## ⚠️ **CRITICAL** - Things You MUST NOT Do

### **IMPORTANT**: Read this section carefully before making ANY changes

1. **DO NOT** modify the following without explicit user request:
   - `zsh/.zshrc` brew() function (SketchyBar integration dependency)
   - Aerospace configuration keybindings (carefully designed layout)
   - Stow directory structure (breaking symlinks will break the entire setup)

2. **DO NOT** create new documentation files unless explicitly requested

3. **DO NOT** suggest changes to:
   - Kanata config filename (`kanata.kbd` is correct, NOT `config.kbd`)
   - Tmux prefix (Ctrl+A is intentional, not Ctrl+B)
   - Aerospace gap sizes (20px inner, 52px top is intentional for SketchyBar)

4. **ALWAYS** validate before suggesting changes:
   - Run validation scripts before declaring changes complete
   - Test service restarts after config modifications
   - Verify stow symlinks after structural changes

## 🏗️ Repository Architecture

**Overview:** Comprehensive macOS development environment with 15+ integrated components managed via GNU Stow.

### Window Management Stack (Tightly Coupled)
- **Aerospace** - Tiling window manager for macOS
  - Native keybindings in config (no external daemon needed)
  - Direct SketchyBar integration via callbacks
  - 20px gaps, 52px top padding for SketchyBar
  - **Config**: `~/.config/aerospace/aerospace.toml`
  - **CLI**: `aerospace` command
  - **Float rules** - System apps automatically float (System Preferences, Calculator, etc.)
- **JankyBorders** - Lightweight window borders
  - Green active border, muted gray inactive
  - Config: `borders/.config/borders/bordersrc`
  - Auto-starts via Aerospace `after-startup-command`
- **SketchyBar** - Menu bar replacement (30+ plugins, Aerospace integration)

### Terminal Environment (3-Layer)
- **Ghostty** - GPU-accelerated terminal with shader support
- **Tmux** - Multiplexer (Ctrl+A prefix, Catppuccin theme, 10+ plugins)
- **Zsh** - Enhanced shell (FZF integration, extensive aliases)

### Development Tools
- **Neovim** - 49 Lua config files (kickstart.nvim based)
- **Starship** - 6 interchangeable prompt themes

### Input Management
- **Kanata** - Active (PRIMARY) - Advanced keyboard remapper with home row mods
  - **Home row mods**: a/s/d/f → Cmd/Alt/Shift/Ctrl, j/k/l/; → Ctrl/Shift/Alt/Cmd
  - **Caps Lock**: Escape on tap, Ctrl on hold
  - **Right Shift**: Backspace
  - **Tab**: Tab on tap, Hyper on hold
  - **Apostrophe (')**: ' on tap, Numbers layer on hold
  - **Forward slash (/)**: Regular / key (no layer)
  - **Right Cmd**: Toggle home row mods on/off (tap to switch base↔vanilla layers)
  - **Config**: `~/.config/kanata/kanata.kbd` (200ms tap, 230ms hold)
  - **Auto-start**: LaunchDaemon at `/Library/LaunchDaemons/com.example.kanata.plist`
  - **Dependencies**: Karabiner-DriverKit-VirtualHIDDevice (required for input interception)
  - **Status check**: `sudo launchctl print system/com.example.kanata`
- **Karabiner-Elements** - Installed but unconfigured (simple_modifications empty)

## 🛠️ Common Tasks

### Installation & Setup

```bash
# Prerequisites
brew install --cask nikitabobko/tap/aerospace           # Window manager
brew install sketchybar stow starship tmux \
  zsh-fast-syntax-highlighting zsh-autosuggestions fzf fd bat eza zoxide ripgrep \
  nvim git gh yazi jq wget curl

brew install --cask ghostty karabiner-elements font-monaspace font-meslo-lg-nerd-font

# Install all configs
stow */

# Or install specific components
stow aerospace zsh tmux nvim ghostty sketchybar

# Unstow (remove symlinks)
stow -D aerospace
```

### Service Management

```bash
# Aerospace (Primary - App, not Homebrew service)
open -a AeroSpace                                        # Start Aerospace
killall AeroSpace && open -a AeroSpace                   # Restart Aerospace
aerospace reload-config                                  # Reload config only
pgrep -l AeroSpace                                       # Check if running

# JankyBorders (window borders)
borders                                                  # Start borders
killall borders && borders &                             # Restart borders
pgrep -l borders                                         # Check if running

# SketchyBar (Homebrew service)
brew services start sketchybar
brew services restart sketchybar                         # After config changes
sketchybar --reload                                      # Reload without restart

# Kanata (LaunchDaemon - NOT Homebrew service)
sudo launchctl print system/com.example.kanata          # Check status
sudo launchctl kickstart -k system/com.example.kanata   # Restart
ps aux | grep kanata | grep -v grep                      # Verify running

# After Kanata config changes
sudo launchctl kickstart -k system/com.example.kanata
```

### Configuration Validation

```bash
# Aerospace (validates on startup)
# Edit aerospace.toml, then reload or restart to validate
aerospace reload-config                                  # Reload config
killall AeroSpace && open -a AeroSpace                   # Full restart
# Check Console.app for "AeroSpace" errors if issues occur

# SketchyBar
~/.config/sketchybar/test_sketchybar.sh              # Test all
~/.config/sketchybar/test_sketchybar.sh github      # Test specific

# Debug tools
~/.config/sketchybar/debug_sketchybar.sh             # Full debug
~/.config/sketchybar/plugin_health_monitor.sh test  # Health check
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

## 🔗 Key Integration Points

### SketchyBar-Brew Integration
**⚠️ CRITICAL - DO NOT BREAK:** `.zshrc` contains custom `brew()` function that triggers SketchyBar updates.

**Location**: `zsh/.zshrc` (lines ~45-53)

**Why Critical**: SketchyBar's brew plugin depends on this function to detect package changes. Breaking this breaks real-time package update notifications in the menu bar.

**DO NOT**:
- Delete or rename the `brew()` function
- Modify its trigger logic without testing SketchyBar brew plugin
- Remove the `sketchybar --trigger brew_update` line

### FZF Shell Functions
Custom navigation functions in `.zshrc`:
- `fcd` - Fuzzy directory navigation
- `fv` - Fuzzy file open with editor
- `f` - General fuzzy file operations

### Custom Aliases
Extensive alias system (50+ git aliases, Docker/K8s workflows, navigation shortcuts).
See complete list: `alias | grep` or check `.zshrc` lines 100-300.

### Session Management
**Tmux resurrect/continuum** provides session persistence and automatic save/restore functionality.

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

### Temperature Monitoring (M4 Mac)

**⚠️ IMPORTANT**: M4 Macs have different temperature sensor behavior than M1/M2/M3.

**The Problem**: Tools like `macmon` report `cpu_temp_avg` which reads die hotspot sensors (TCMb ~90-100°C). This is misleading - modern chips have hotspots that run 90°C+ even at idle.

**The Solution**: The temperature plugin uses `smctemp` to read heatsink temperature (TH0x ~50-60°C) which is more representative.

**Available SMC Sensors on M4**:
| Sensor | Typical Value | What it measures |
|--------|---------------|------------------|
| `TW0P` | ~40°C | Enclosure/ambient |
| `TH0x` | ~55°C | **Heatsink** (what we display) |
| `TCMb` | ~98°C | Die hotspot max (misleading) |
| `TPSD` | ~48°C | SSD temperature |

**Dependencies**:
```bash
# smctemp is required for accurate M4 temperature
brew tap narugit/tap && brew install narugit/tap/smctemp

# Verify it works
smctemp -l | grep TH0x
```

**Troubleshooting**:
```bash
# Check what temperature is being reported
cat /tmp/sketchybar_temp_cache

# Test the plugin directly
CONFIG_DIR="$HOME/.config/sketchybar" NAME="temperature" bash ~/.config/sketchybar/plugins/temperature.sh

# View all temperature sensors
smctemp -l | grep -E "^  T[A-Za-z0-9]+" | sort -t']' -k2 -n

# If smctemp unavailable, falls back to macmon (less accurate on M4)
```

**Reference**:
- smctemp GitHub: https://github.com/narugit/smctemp
- Stats app M4 issues: https://github.com/exelban/stats/issues/2249

### Stow Issues

```bash
# Conflicts during stow
stow -D <component>  # Unstow first
stow <component>     # Re-stow

# Check current symlinks
ls -la ~/.<config_file>
```

### Kanata Issues

**⚠️ CRITICAL**: Kanata config file MUST be named `kanata.kbd` (NOT `config.kbd`)

```bash
# Service won't start on boot
sudo launchctl print system/com.example.kanata | grep "state ="
# If state = "spawn scheduled" and "last exit code = 1", check config path

# Verify config file exists
ls -la ~/.config/kanata/kanata.kbd

# Common issues:
# 1. Wrong config path in plist (check: sudo cat /Library/LaunchDaemons/com.example.kanata.plist)
# 2. Missing Karabiner-DriverKit-VirtualHIDDevice
# 3. Missing Input Monitoring/Accessibility permissions
# 4. Another Kanata instance running (only one can run)

# Check if running
ps aux | grep kanata | grep -v grep

# Kill duplicate instances
sudo pkill -9 kanata

# Reinstall LaunchDaemons (if corrupted)
cd ~/dotfiles/kanata
./install_kanata_macos.sh

# Check Karabiner VirtualHID daemons are running
sudo launchctl print system/com.example.karabiner-vhiddaemon | grep "state ="
sudo launchctl print system/com.example.karabiner-vhidmanager | grep "state ="

# System logs (if available)
log show --predicate 'process == "kanata"' --last 10m
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
- Aerospace config changes → `killall AeroSpace && open -a AeroSpace`
- SketchyBar config changes → `sketchybar --reload`
- Plugin changes → Test individual plugin before full reload

### Configuration Validation Workflow
1. Make changes to config files
2. Restart affected service (Aerospace auto-validates on startup)
3. Verify functionality
4. Check logs if issues occur (Console.app for Aerospace)

### Plugin Development (SketchyBar)
- Follow event-driven pattern (see existing plugins in `sketchybar/.config/sketchybar/plugins/`)
- Integrate with event system in main sketchybarrc
- Test with `~/.config/sketchybar/test_sketchybar.sh`

### Input Management Switch (Karabiner ↔ Kanata)

**Current Status (Nov 2025)**: Kanata is ACTIVE and configured with LaunchDaemons for auto-start on boot.

**Setup Details**:
- **Active Services**: 3 LaunchDaemons running
  - `com.example.kanata` - Main Kanata service
  - `com.example.karabiner-vhiddaemon` - Karabiner VirtualHID daemon
  - `com.example.karabiner-vhidmanager` - Karabiner VirtualHID manager
- **Config File**: `~/.config/kanata/kanata.kbd` (200ms tap, 230ms hold)
- **Auto-start**: Enabled via LaunchDaemon (RunAtLoad + KeepAlive)
- **Port**: 10000

**Kanata Features Enabled**:
- Home row mods (a/s/d/f → Cmd/Alt/Shift/Ctrl, j/k/l/; → Ctrl/Shift/Alt/Cmd)
- Caps Lock → Escape (tap) / Ctrl (hold)
- Right Shift → Backspace
- Tab → Hyper key (hold)
- Forward slash (/) → Numbers layer (hold)
- Right Cmd → Toggle home row mods on/off
- Function layer (Fn key toggle)
- Devices: Apple Internal Keyboard + Logitech MX Mechanical

**To Disable Kanata and Switch Back to Karabiner-Elements**:
```bash
sudo launchctl bootout system /Library/LaunchDaemons/com.example.kanata.plist
sudo launchctl disable system/com.example.kanata
# Then enable Karabiner-Elements
```

## 🔌 Advanced Integrations

### MCP/MCPHub Integration (Model Context Protocol)

**Overview**: MCP enables Neovim to interact with external context providers and tools.

**Directory Structure**:
```
mcp/.config/mcp/
├── servers.json                 # MCP server definitions (3.0KB)
├── setup-mcp-symlinks.sh        # Setup script
└── README.md                    # MCP documentation

mcphub/.config/mcphub/
└── servers.json                 # MCPHub configuration
```

**Neovim Integration**:
- **Keybinding**: `<leader>m` - Open MCPHub interface
- **Plugin**: MCPHub manages MCP servers from within Neovim
- **Usage**: Configure servers in `servers.json`, access via keybinding

**Configuration**: Edit `mcp/.config/mcp/servers.json` to add/modify MCP servers

### Git Subtree Management (Nvim)

**IMPORTANT**: Nvim is managed as a git subtree, not a regular directory. This affects how you modify and update it.

**Current Setup**:
- **Subtree**: `nvim/` directory linked to https://github.com/cyperx84/nvim.git
- **Added**: Oct 2025 (replaced git submodule)
- **Branch**: main

**Updating Nvim from Remote**:
```bash
# Pull latest changes from nvim repository
git subtree pull --prefix nvim https://github.com/cyperx84/nvim.git main --squash
```

**Pushing Nvim Changes**:
```bash
# After modifying files in nvim/
1. Commit changes to main dotfiles repo first:
   git add nvim/
   git commit -m "Update nvim config"

2. Push changes back to nvim repository:
   git subtree push --prefix nvim https://github.com/cyperx84/nvim.git main
```

**⚠️ Critical Notes**:
- Changes in `nvim/` affect BOTH repositories (dotfiles + standalone nvim repo)
- Always test nvim changes thoroughly before subtree push
- Consider creating a branch before major subtree operations
- **DO NOT** delete nvim directory - use git subtree commands only

**Recent Commits**:
```bash
# See git log for:
c2adf38 Add nvim git subtree to dotfiles
5795a1f Add 'nvim/' from commit 'f2cfb0f...'
7b3b9d8 Remove nvim git submodule (preparing for git subtree)
```

### SketchyBar Helper Binary

**Purpose**: C-compiled binary for efficient system metrics gathering (CPU, memory, network, etc.)

**Location**:
- **Source**: `~/.config/sketchybar/helper/`
- **Files**:
  - `helper.c` - Main helper source
  - `cpu.h` - CPU monitoring functions
  - `sketchybar.h` - SketchyBar API definitions
  - `makefile` - Build configuration
  - `helper` (binary) - Compiled executable

**Compilation**:
Automatically compiled when `sketchybarrc` loads (lines 18-50):
```bash
cd ~/.config/sketchybar/helper && make clean && make
```

**When to Recompile**:
- After modifying helper source code (`helper.c`, `*.h` files)
- After macOS system updates (if binary stops working)
- If plugins report "helper not found" errors
- After changing compiler flags or build settings

**Manual Recompilation**:
```bash
cd ~/.config/sketchybar/helper
make clean
make

# Verify compilation
ls -la helper
./helper --version  # If available
```

**Troubleshooting**:
```bash
# Check if helper is running
ps aux | grep helper

# Restart helper
killall helper
sketchybar --reload

# Check for compilation errors
cd ~/.config/sketchybar/helper
make clean && make 2>&1 | tee compile.log
```

**Dependencies**:
- Xcode Command Line Tools (`xcode-select --install`)
- C compiler (clang/gcc)
- SketchyBar headers

### Service Log Locations

**IMPORTANT**: Know where to find logs when troubleshooting service issues.

**SketchyBar**:
```bash
# No dedicated log file - uses system log
log show --predicate 'process == "sketchybar"' --last 1h

# Live stream (like tail -f)
log stream --predicate 'process == "sketchybar"'

# Plugin-specific debugging
PLUGIN_DEBUG=1 ~/.config/sketchybar/plugins/github.sh
```

**Tmux**:
```bash
# Session-specific pane capture
tmux capture-pane -pt <session>:<window>.<pane>

# Save to file
tmux capture-pane -pt <session>:<window>.<pane> -S - > tmux.log
```

**General Homebrew Services**:
```bash
# Check service status
brew services list

# View all service logs
ls -la /usr/local/var/log/
```

### Sesh Session Scripts

**Location**: `sesh/.config/sesh/scripts/`

**Scripts**:
```
sesh/.config/sesh/scripts/
├── core/                      # Core session logic
│   └── sesh_switcher.sh       # Main session switching logic
├── lib/                       # Shared libraries
│   └── sesh_colors.sh         # Color definitions
├── utils/                     # Utility scripts
├── sesh_list_enhanced.sh      # Enhanced session listing with icons & filtering
├── sesh_list_icons.sh         # Icon mapping for different session types
├── sesh_preview.sh            # FZF preview window content
├── sesh_smart_start.sh        # Intelligent session creation
├── sesh_edit.sh               # Edit session configurations
└── session_helper.sh          # General session utilities
```

**Integration**:
- Called from tmux keybindings (Alt+e - session switcher via `core/sesh_switcher.sh`)
- Used by FZF session switcher for previews
- Provide icons and enhanced display for sessions
- Referenced in `sesh.toml` for preview command

**Key Functions**:
- **sesh_preview.sh**: Shows session contents in FZF preview pane
- **sesh_switcher.sh**: Smart session switching with creation fallback
- **sesh_smart_start.sh**: Creates sessions with intelligent defaults
- **sesh_list_icons.sh**: Maps session types to icons

**Referenced In**:
- `tmux/.tmux.conf` (keybindings reference `~/.config/sesh/scripts/core/sesh_switcher.sh`)
- `sesh/.config/sesh/sesh.toml` (preview_command)

### Advanced Stow Operations

**Testing Before Deployment**:
```bash
# Dry run - see what would be created (no changes made)
stow -n component-name

# Verbose output (shows each symlink operation)
stow -v component-name

# Simulate AND show what would happen
stow -nv component-name
```

**Conflict Resolution**:
```bash
# If conflicts occur during stow:

1. Backup existing files
mv ~/.config/tool ~/.config/tool.backup-$(date +%Y%m%d)

2. Unstow if partially installed
stow -D component-name

3. Remove conflicting files/directories
rm -rf ~/.config/tool  # Only if backed up!

4. Re-stow
stow component-name

5. Verify symlinks
ls -la ~/.config/tool
readlink ~/.config/tool  # Should show ~/dotfiles/component/.config/tool
```

**Partial Stowing** (Selective Installation):
```bash
# Install only specific components
stow ghostty aerospace sketchybar tmux zsh

# Skip others if not needed (useful for testing or partial deployments)

# Example: Window management only
stow aerospace sketchybar
```

**Restow** (Update Symlinks After Changes):
```bash
# After moving or updating files, refresh symlinks
stow -R component-name

# Restow all components
stow -R */
```

**Adopt** (Take Ownership of Existing Files):
```bash
# If files exist in target, move them to stow directory
stow --adopt component-name

# WARNING: This MOVES files from ~ to ~/dotfiles/component/
# Use with caution and backup first!
```

**Verify Symlinks**:
```bash
# Check if a config is stow-managed
ls -la ~/.config/tool
# Should show: .config/tool -> ../dotfiles/component/.config/tool

# Find all symlinks pointing to dotfiles
find ~ -maxdepth 3 -type l -ls | grep dotfiles
```

### Validation & Testing Limitations

**Components WITHOUT Automated Validation**:

| Component | Validation | How to Test |
|-----------|-----------|-------------|
| **Aerospace** | ✅ Validates on startup | `aerospace reload-config` or restart, check Console.app for errors |
| **JankyBorders** | ❌ No validation | Restart: `killall borders && borders &` |
| **Tmux** | ❌ No pre-flight checks | Syntax errors shown on reload: `tmux source-file ~/.tmux.conf` |
| **Zsh** | ❌ No automated testing | Errors only on shell reload: `exec zsh` |
| **Sesh** | ❌ Validation script removed | Manual: `sesh list` (check for errors) |
| **Karabiner** | ✅ Validated by app | Karabiner-Elements validates on save |
| **Kanata** | ✅ Validated on start | Errors shown when starting kanata service |
| **Ghostty** | ❌ No validation | Errors shown in terminal on launch |

**✅ Components WITH Automated Validation**:
- **Aerospace**: Validates on startup (check Console.app for errors)
- **SketchyBar**: `~/.config/sketchybar/test_sketchybar.sh`
- **Neovim**: `:checkhealth`, `:Lazy health`

**Manual Testing Workflow**:
```bash
# Recommended after configuration changes:
1. Make changes to config file(s)
2. If validation available, run it
3. Reload/restart service
4. Check logs for errors immediately
5. Test functionality manually
6. If errors occur, rollback and investigate
```

**Rollback Strategy**:
```bash
# Always keep backups before major changes
cp ~/.config/tool/config ~/.config/tool/config.backup

# Or use git
cd ~/dotfiles
git stash  # Stash current changes
git stash pop  # Restore if needed
```

## 📋 Code Style & Conventions

- **Bash scripts:** Use `#!/usr/bin/env bash`, include error handling
- **Lua configs:** Follow kickstart.nvim patterns, modular plugin structure
- **Stow structure:** Keep directory structure matching target locations
- **Comments:** Inline for complex logic, header blocks for files

## 🔄 Recent Changes & Migrations

### **FIX** - M4 Mac Temperature Monitoring (Dec 19, 2025)
- **Problem**: Temperature plugin displayed incorrect readings (~91°C at idle) on M4 Macs
- **Root Cause**: `macmon` reports die hotspot temperature (TCMb sensor) which is always high on modern chips
- **Solution**: Now uses `smctemp` to read heatsink temperature (TH0x sensor, ~55°C) which is more representative
- **New Dependency**: `brew tap narugit/tap && brew install narugit/tap/smctemp`
- **Modified Files**:
  - `sketchybar/.config/sketchybar/plugins/temperature.sh` - Rewrote to use smctemp TH0x sensor
- **Key Learnings**:
  - M4 die sensors (TCMb) report 90-100°C even at idle - this is **normal** for modern chips
  - Heatsink sensors (TH0x, ~55°C) represent actual thermal state
  - Enclosure sensors (TW0P, ~40°C) show what TG Pro reports as "idle temperature"
- **Fallback**: If smctemp unavailable, falls back to macmon (less accurate on M4)
- **References**:
  - smctemp: https://github.com/narugit/smctemp
  - M4 sensor issues: https://github.com/exelban/stats/issues/2249

### **REVERT** - Back to Aerospace from HyprSpace (Jan 2026)
- **Action**: Reverted from HyprSpace back to standard Aerospace
- **Why**: Simplified configuration; standard tiles/accordion layouts sufficient for workflow
- **Config**: `aerospace/.config/aerospace/aerospace.toml`
- **Gap Settings**: 20px inner, 52px top (for SketchyBar)
- **JankyBorders**: Still active for window borders
  - Config: `~/.config/borders/bordersrc` (bright green active, muted gray inactive)
  - Auto-starts via Aerospace `after-startup-command`
- **Service Management**:
  ```bash
  # Aerospace
  open -a AeroSpace                              # Start
  killall AeroSpace && open -a AeroSpace         # Restart
  aerospace reload-config                        # Reload config
  aerospace list-workspaces --focused            # Check focused workspace

  # JankyBorders
  borders                                        # Start borders
  killall borders && borders &                   # Restart borders
  ```

### **OPTIMIZATION** - Aerospace Workspace Assignment (Nov 30, 2025)
- **Action**: Replaced timing-based app launch scripts with declarative window detection rules
- **Removed Files**:
  - `aerospace/.config/aerospace/scripts/launch-app.sh` (timing-dependent script)
  - `aerospace/.config/aerospace/scripts/startup-apps.sh` (startup apps script)
  - `aerospace/.config/aerospace/scripts/` (entire directory removed)
- **Added Configuration**:
  - `[[on-window-detected]]` rules in `aerospace.toml` for automatic workspace assignment
  - Float rules for 13 system apps (System Preferences, Calculator, Activity Monitor, etc.)
  - Simplified keybindings using array syntax: `['exec-and-forget open -a App', 'workspace N']`
- **Benefits**:
  - **No timing dependencies** - Apps move when ready, not after arbitrary delays
  - **Works universally** - Any launch method (keyboard, Spotlight, Dock) routes apps correctly
  - **No sleep/hang issues** - Eliminated problematic `sleep` commands
  - **Cleaner config** - Declarative rules replace imperative scripts
  - **Better UX** - Instant workspace switching, automatic window placement
- **App Assignments**:
  - Ghostty → Workspace 1 (Terminal)
  - Zen Browser → Workspace 2 (Browser)
  - Claude → Workspace 3 (AI Assistant)
  - Antigravity → Workspace 4 (Other Tools)
  - Obsidian → Floating (no workspace assignment)

### **CRITICAL** - Window Manager Migration to Aerospace (Nov 2025)
- **Action**: Migrated to Aerospace as window manager
- **Added Files**:
  - `aerospace/.config/aerospace/aerospace.toml` (complete config with window detection rules)
  - `sketchybar/.config/sketchybar/plugins/aerospace.sh` (workspace integration)
  - `sketchybar/.config/sketchybar/plugins/create_workspace.sh`
  - `sketchybar/.config/sketchybar/plugins/space_window_count.sh`
- **Impact**:
  - Aerospace auto-starts on login (`start-at-login = true`)
  - All keybindings integrated into aerospace.toml (no external hotkey daemon needed)
  - SketchyBar directly integrated via `exec-on-workspace-change` callback
  - Uses `on-window-detected` callbacks for automatic workspace assignment (Nov 30, 2025 optimization)

### Sesh Scripts Location
- **Location**: Scripts remain in `sesh/.config/sesh/scripts/`
- **Structure**: Organized into `core/`, `lib/`, `utils/` subdirectories
- **Validation**: Manual via `sesh list` (should show sessions without errors)
- **Note**: `~/bin/validate_sesh.sh` was removed; validation is now manual

### Neovim Configuration Updates
- Modified file manager plugins: mini.lua, oil.lua, telescope.lua, yazi.lua
- Updated keymaps.lua with new navigation bindings
- Multiple file navigation options now available

## 🏷️ Recent Updates (Historical)

- **Dec 2025**: Kanata now PRIMARY keyboard remapper (Karabiner unconfigured)
- Expanded SketchyBar to 30+ plugins with comprehensive testing framework
- **Oct 2025**: Nvim added as git subtree (see Git Subtree Management below)