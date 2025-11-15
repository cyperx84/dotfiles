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
~/.config/sketchybar/test_sketchybar.sh                  # Test all plugins
yabai --check-config                                      # Validate yabai config

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
├── yabai/.config/yabai/yabairc                         # Window manager
├── skhd/.config/skhd/skhdrc                            # Hotkey daemon
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
   - Service restart sequences (order matters: yabai → skhd → sketchybar)
   - Stow directory structure (breaking symlinks will break the entire setup)

2. **DO NOT** create new documentation files unless explicitly requested

3. **DO NOT** suggest changes to:
   - Kanata config filename (`kanata.kbd` is correct, NOT `config.kbd`)
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
- **Tmuxinator** - Complex tmux session layouts

### Input Management
- **Karabiner-Elements** - Active (Caps→Ctrl, Right Cmd/Shift→Backspace)
- **Kanata** - Keyboard remapper with home row mods (a/s/d/f, j/k/l/;)
  - **Config**: `~/.config/kanata/kanata.kbd` (CRITICAL: NOT config.kbd!)
  - **Auto-start**: LaunchDaemon at `/Library/LaunchDaemons/com.example.kanata.plist`
  - **Install script**: `kanata/install_kanata_macos.sh` (sets up all 3 LaunchDaemons)
  - **Dependencies**: Karabiner-DriverKit-VirtualHIDDevice (required for input interception)
  - **Status check**: `sudo launchctl print system/com.example.kanata`

## 🛠️ Common Tasks

### Installation & Setup

```bash
# Prerequisites
brew install yabai skhd sketchybar stow starship tmux \
  zsh-fast-syntax-highlighting zsh-autosuggestions fzf fd bat eza zoxide ripgrep \
  nvim git gh yazi jq wget curl

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
# Homebrew services
brew services start yabai skhd sketchybar

# Restart after config changes (REQUIRED)
brew services restart yabai
brew services restart sketchybar

# Kanata (LaunchDaemon - NOT Homebrew service)
sudo launchctl print system/com.example.kanata          # Check status
sudo launchctl kickstart -k system/com.example.kanata   # Restart
ps aux | grep kanata | grep -v grep                      # Verify running

# After Kanata config changes
sudo launchctl kickstart -k system/com.example.kanata
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
Two session management systems:
1. **Tmux resurrect/continuum** - Session persistence
2. **Tmuxinator** - Complex multi-window layouts

When modifying session configs, consider interactions between these tools.

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
- Yabai/SKHD config changes → `brew services restart`
- SketchyBar config changes → `sketchybar --reload`
- Plugin changes → Test individual plugin before full reload

### Configuration Validation Workflow
1. Make changes to config files
2. Run validation script (`yabai --check-config`, etc.)
3. Restart affected service
4. Verify functionality
5. Check logs if issues occur

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
- Caps Lock → Ctrl
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

### Claude Code Integration

**Directory**: `.claude/` in home directory (also project-level)

**Structure**:
```
~/.claude/
├── agents/              # Custom agents
├── config/              # Claude Code configuration
├── data/                # Conversation history
├── shell-snapshots/     # Shell state snapshots
├── todos/               # Task tracking
└── tools/               # Custom tools
```

**Shell Aliases** (in `zsh/.zshrc`):

```bash
# Claude Code - clean environment (unsets DeepSeek vars)
cc() {
    unset ANTHROPIC_BASE_URL ANTHROPIC_AUTH_TOKEN API_TIMEOUT_MS
    unset ANTHROPIC_MODEL ANTHROPIC_SMALL_FAST_MODEL
    unset CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC
    /Users/cyperx/.claude/local/claude --dangerously-skip-permissions "$@"
}

# DeepSeek with Claude Code (alternative model)
ccds() {
    export ANTHROPIC_BASE_URL=https://api.deepseek.com/anthropic
    export ANTHROPIC_AUTH_TOKEN=$(pass apis/DEEPSEEK_API_KEY)
    export API_TIMEOUT_MS=600000
    export ANTHROPIC_MODEL=deepseek-chat
    export ANTHROPIC_SMALL_FAST_MODEL=deepseek-chat
    export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1
    claude "$@"
}
```

**Usage**: Run `cc` for Claude Code, `ccds` for DeepSeek-powered Claude Code

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

**Yabai**:
```bash
# Standard output log
tail -f /usr/local/var/log/yabai/yabai.out.log

# Error log
tail -f /usr/local/var/log/yabai/yabai.err.log

# Combined view
tail -f /usr/local/var/log/yabai/*.log
```

**SKHD**:
```bash
# Standard output log
tail -f /usr/local/var/log/skhd/skhd.out.log

# Error log
tail -f /usr/local/var/log/skhd/skhd.err.log

# Watch for hotkey press events
tail -f /usr/local/var/log/skhd/skhd.out.log | grep --line-buffered "hotkey"
```

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

### Tmux Custom Scripts

**Location**: `tmux/.tmux/scripts/` (7 scripts)

**IMPORTANT**: These scripts replaced the previous `sesh/.config/sesh/scripts/` directory (Oct 2025 migration).

**Scripts**:
```
tmux/.tmux/scripts/
├── sesh_list_enhanced.sh      # Enhanced session listing with icons & filtering (7.3KB)
├── sesh_list_icons.sh         # Icon mapping for different session types (942B)
├── sesh_preview.sh            # FZF preview window content (18KB)
├── sesh_switcher.sh           # Main session switching logic (3.0KB)
├── sesh_smart_start.sh        # Intelligent session creation (3.3KB)
├── sesh_edit.sh               # Edit session configurations (1.1KB)
└── session_helper.sh          # General session utilities (4.3KB)
```

**Integration**:
- Called from tmux keybindings (`C-a e` - session switcher, `C-a L` - session list)
- Used by FZF session switcher for previews
- Provide icons and enhanced display for sessions
- Referenced in `sesh.toml` for preview command

**Key Functions**:
- **sesh_preview.sh**: Shows session contents in FZF preview pane
- **sesh_switcher.sh**: Smart session switching with creation fallback
- **sesh_smart_start.sh**: Creates sessions with intelligent defaults
- **sesh_list_icons.sh**: Maps session types to icons (📁, 🔧, 📝, etc.)

**Referenced In**:
- `tmux/.tmux.conf` (keybindings)
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
stow ghostty yabai skhd sketchybar tmux zsh

# Skip others if not needed (useful for testing or partial deployments)

# Example: Window management only
stow yabai skhd sketchybar
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

**⚠️ Components WITHOUT Automated Validation**:

| Component | Validation | How to Test |
|-----------|-----------|-------------|
| **SKHD** | ❌ No syntax checking | Check logs: `tail -f /usr/local/var/log/skhd/skhd.out.log` |
| **Tmux** | ❌ No pre-flight checks | Syntax errors shown on reload: `tmux source-file ~/.tmux.conf` |
| **Zsh** | ❌ No automated testing | Errors only on shell reload: `exec zsh` |
| **Sesh** | ❌ Validation script removed | Manual: `sesh list` (check for errors) |
| **Karabiner** | ✅ Validated by app | Karabiner-Elements validates on save |
| **Kanata** | ✅ Validated on start | Errors shown when starting kanata service |
| **Ghostty** | ❌ No validation | Errors shown in terminal on launch |

**✅ Components WITH Automated Validation**:
- **Yabai**: `yabai --check-config`
- **SketchyBar**: `~/.config/sketchybar/test_sketchybar.sh`
- **Neovim**: `:checkhealth`, `:Lazy health`

**Manual Testing Workflow**:
```bash
# Recommended after configuration changes:
1. Make changes to config file(s)
2. If validation available, run it (yabai --check-config)
3. Reload/restart service
4. Check logs for errors immediately
5. Test functionality manually
6. If errors occur, rollback and investigate

# Example: SKHD changes
vim ~/.config/skhd/skhdrc
brew services restart skhd
tail -f /usr/local/var/log/skhd/skhd.out.log  # Watch for errors
# Press a hotkey to test
# If broken, fix and restart
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

## 🔄 Recent Changes & Migrations (Oct 2025)

### **CRITICAL** - Sesh Script Migration
- **Action**: Migrated all sesh-specific scripts from `sesh/.config/sesh/scripts/` to `tmux/.tmux/scripts/`
- **Deleted Files**:
  - `sesh/.config/sesh/scripts/*` (all 7 scripts removed)
  - `sesh/bin/validate_sesh.sh` (validation script removed)
- **Impact**:
  - Session management now fully integrated into tmux workflow
  - **IMPORTANT**: `~/bin/validate_sesh.sh` references in docs are OBSOLETE
  - Sesh validation is now manual: `sesh list` (should show sessions without errors)
  - All functionality moved to tmux scripts (see Tmux Scripts section below)

### Neovim Configuration Updates
- Modified file manager plugins: mini.lua, oil.lua, telescope.lua, yazi.lua
- Updated keymaps.lua with new navigation bindings
- Multiple file navigation options now available

### Tmuxinator Layouts Standardized
- All 4 layouts updated: coding.yml, docker.yml, dotfiles.yml, notes.yml
- Improved consistency across session definitions

## 🏷️ Recent Updates (Historical)

- Added Kanata keyboard remapper as alternative to Karabiner-Elements
- Added Tmuxinator for complex session layouts
- Expanded SketchyBar to 30+ plugins with comprehensive testing framework
- **Oct 2025**: Nvim added as git subtree (see Git Subtree Management below)
- do not run sleep with a areospace command it hangs