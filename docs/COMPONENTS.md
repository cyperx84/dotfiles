# Dotfiles Components Reference

> **🧭 Navigation Hub**
> [Window Management](#window-management) • [Terminal Environment](#terminal-environment) • [Development Tools](#development-tools) • [Input Management](#input-management) • [System Integration](#system-integration)

## Overview

This document provides comprehensive documentation for all 15+ components in the dotfiles repository, organized by functional category with detailed configuration references and integration points.

**Repository Structure**: Each component follows GNU Stow conventions with configurations in `component/.config/tool/` format for automatic symlinking.

---

## Window Management

### 🚀 Aerospace - Tiling Window Manager
**Purpose**: macOS tiling window manager with native keybindings
**Status**: ✅ Active (PRIMARY)
**Dependencies**: None (self-contained)

**Key Files**:
- `aerospace/.config/aerospace/aerospace.toml` - Complete configuration

**Configuration Highlights**:
```toml
# Tiles layout
default-root-container-layout = 'tiles'

# Auto-start on login
start-at-login = true

# SketchyBar integration
exec-on-workspace-change = ['/bin/bash', '-c',
    "sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE"
]

# Window change trigger for instant SketchyBar updates
[[on-window-detected]]
run = 'exec-and-forget sketchybar --trigger window_change'

# Gaps configuration
[gaps]
    inner.horizontal = 20
    inner.vertical = 20
    outer.top = 52  # SketchyBar padding
```

**Integration Points**:
- **SketchyBar**: Direct workspace callbacks + window change events for instant updates
- **JankyBorders**: Auto-started via `after-startup-command`
- **Native Keybindings**: All hotkeys defined in aerospace.toml (no external daemon)
- **Automatic**: Launches at login, validates config on startup

**Key Features**:
- **Tiles/Accordion Layouts**: Standard tiling window layouts
- **Smart Resize**: Context-aware window resizing
- **Service Mode**: Advanced operations mode (`shift+alt+cmd+r`)
- **Normalization**: Automatic container flattening and orientation handling
- **CLI**: `aerospace` command

**Service Management**:
```bash
open -a AeroSpace                         # Start
killall AeroSpace && open -a AeroSpace    # Restart
aerospace reload-config                   # Reload config only
aerospace list-workspaces --focused       # Check focused workspace
```

**Common Operations**: See [KEYBINDS.md - Window Management](KEYBINDS.md#window-management)

### 🔲 JankyBorders - Window Borders
**Purpose**: Lightweight window border system for visual clarity
**Status**: ✅ Active
**Dependencies**: None

**Key Files**:
- `borders/.config/borders/bordersrc` - Configuration script

**Configuration**:
```bash
options=(
    style=round
    width=5.0
    hidpi=on
    active_color=0xff00ff00    # Bright green for active window
    inactive_color=0xff494d64  # Muted gray for inactive windows
)
borders "${options[@]}"
```

**Integration Points**:
- **Aerospace**: Auto-started via `after-startup-command`
- **Visual**: Provides clear window boundaries

**Service Management**:
```bash
borders                          # Start
killall borders && borders &     # Restart
pgrep -l borders                 # Check if running
```

### 📊 SketchyBar - Menu Bar Replacement
**Purpose**: Customizable macOS menu bar with system information
**Status**: ✅ Active
**Dependencies**: Aerospace for workspace information, various system tools

**Key Files**:
- `sketchybar/.config/sketchybar/sketchybarrc` - Main configuration
- `sketchybar/.config/sketchybar/plugins/` - 39 plugin scripts
- `sketchybar/.config/sketchybar/items/` - 29 item configurations
- `sketchybar/.config/sketchybar/helper/` - C helper binary

**Plugin Architecture** (39 plugins total):
```
plugins/
├── aerospace.sh          # Aerospace workspace management (PRIMARY)
├── create_workspace.sh   # Workspace creation handler
├── space_window_count.sh # Window count per workspace
├── space.sh             # Space display (click to switch)
├── brew.sh               # Package updates
├── calendar.sh           # Date/time display
├── cpu.sh                # System monitoring (via helper binary)
├── memory.sh             # RAM usage
├── disk.sh               # Disk usage
├── battery.sh            # Battery status
├── front_app.sh          # Active application
├── git.sh                # Git repository status
├── github.sh             # GitHub notifications
├── docker.sh             # Container monitoring
├── dev_servers.sh        # Dev server port monitoring
├── temperature.sh        # CPU temperature (M4-aware, uses smctemp)
├── volume.sh             # Audio control
├── audio_output.sh       # Audio device indicator
├── wifi.sh               # WiFi status
├── network.sh            # Network speed
├── ssh.sh                # SSH session indicator
├── tmux.sh               # Tmux session indicator
├── memory_graph.sh       # Memory usage graph
├── memory_ring.sh        # Memory usage ring display
└── ... (17+ more plugins)
```

**Temperature Monitoring (M4 Mac)**:
The temperature plugin uses `smctemp` to read heatsink temperature (TH0x sensor) instead of die hotspot sensors. This provides meaningful temperature readings on M4 Macs where die sensors report 90°C+ even at idle.
- **Dependency**: `brew tap narugit/tap && brew install narugit/tap/smctemp`
- **Fallback**: Uses macmon if smctemp unavailable (less accurate on M4)
- **Cache**: `/tmp/sketchybar_temp_cache`

**Styling**:
- **Position**: Top bar, 35px height
- **Font**: MonaspiceKr Nerd Font
- **Theme**: Green/orange color scheme with blur effects
- **Interaction**: Click handlers for space switching

**Testing & Validation**:
- `~/.config/sketchybar/test_sketchybar.sh` - Plugin testing
- `~/.config/sketchybar/debug_sketchybar.sh` - Debugging tools
- `~/.config/sketchybar/plugin_health_monitor.sh` - Health monitoring

---

## Terminal Environment

### 👻 Ghostty - Terminal Emulator
**Purpose**: Modern GPU-accelerated terminal with extensive customization
**Status**: ✅ Active (Primary Terminal)
**Dependencies**: MonaspiceNe Nerd Font

**Key Files**:
- `ghostty/.config/ghostty/config` - Main configuration

**Core Configuration**:
```toml
# Font & Appearance
font-family = "MonaspiceNe Nerd Font"
font-size = 11
theme = "Monokai Remastered"

# macOS Integration
macos-titlebar-style = hidden
macos-option-as-alt = true
window-decoration = false

# Performance
renderer = opengl
```

**Visual Effects Library**:
```
shaders/
├── matrix-hallway.glsl    # Matrix digital rain
├── starfield.glsl         # Animated starfield
├── crt.glsl              # CRT monitor effect
├── galaxy.glsl           # Galaxy spiral
├── nordic-aurora.glsl    # Aurora borealis
└── ... (25+ more effects)
```

**Integration**:
- Works with Tmux for color passthrough
- Optimized for macOS with proper input handling

### 🪟 Tmux - Terminal Multiplexer
**Purpose**: Advanced terminal session management with plugin ecosystem
**Status**: ✅ Active
**Dependencies**: TPM (plugin manager), various utilities

**Key Files**:
- `tmux/.tmux.conf` - Main configuration (164 lines)
- Plugin configurations embedded

**Core Features**:
```bash
# Prefix key: Ctrl+A (not default Ctrl+B)
set-option -g prefix C-a

# Vi-style navigation
setw -g mode-keys vi
bind-key h select-pane -L
bind-key j select-pane -D
bind-key k select-pane -U
bind-key l select-pane -R
```

**Plugin Ecosystem** (10+ plugins):
- `tmux-plugins/tmux-yank` - System clipboard integration
- `christoomey/vim-tmux-navigator` - Neovim integration
- `tmux-plugins/tmux-resurrect` - Session persistence
- `sainnhe/tmux-fzf` - FZF integration
- `omerxx/tmux-floax` - Floating terminals
- `niksingh710/minimal-tmux-status` - Clean status bar

**Session Management**:
- **Sesh Integration**: `C-a T` for advanced session switcher
- **Quick Operations**: `C-a N` (new), `C-a R` (rename), `C-a X` (kill)

**Integration Points**:
- **Neovim**: Seamless pane navigation via vim-tmux-navigator
- **Sesh**: Session management and templates
- **FZF**: Fuzzy finding for sessions and files
- **Ghostty**: Color and terminal capability passthrough

**Session Scripts**:
**Location**: `sesh/.config/sesh/scripts/`

**Structure**:
- `core/` - Core session logic (sesh_switcher.sh)
- `lib/` - Shared libraries (sesh_colors.sh)
- `utils/` - Utility scripts
- Root scripts: sesh_list_enhanced.sh, sesh_preview.sh, sesh_smart_start.sh, etc.

**Integration**:
- Called from tmux keybindings: Alt+e (session switcher via `core/sesh_switcher.sh`)
- Used by FZF session switcher for previews
- Referenced in `sesh.toml` for preview_command
- Provide enhanced display with icons and contextual information

### 🐚 Zsh - Z Shell
**Purpose**: Modern shell with extensive enhancements and aliases
**Status**: ✅ Active (Default Shell)
**Dependencies**: Homebrew packages for various tools

**Key Files**:
- `zsh/.zshrc` - Main configuration (271 lines)

**Enhancement Categories**:

**Terminal Integration**:
```bash
# Ghostty + Tmux detection
if [ -n "$TMUX" ]; then
    export TERM="tmux-256color"
elif [ "$TERM_PROGRAM" = "ghostty" ]; then
    export TERM="xterm-ghostty"
fi
```

**FZF Integration**:
```bash
# Enhanced preview and completion
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always --icons --level=3 {} | head -200'"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"

# Custom functions
fcd() { cd "$(find . -type d -not -path '*/.*' | fzf)" && l; }
fv() { nvim "$(find . -type f -not -path '*/.*' | fzf)" }
```

**Alias Categories** (50+ aliases):
- **Git**: `gc`, `gp`, `gs`, `glog`, etc. ([full list](KEYBINDS.md#git-workflow))
- **Docker**: `dock`, `dco`, `dps`, `dx`, etc.
- **Kubernetes**: `k`, `kg`, `kd`, `kl`, etc.
- **Navigation**: `..`, `...`, `C` (Code), `conf` (dotfiles)
- **File Operations**: `ls` (eza), `lt` (tree), `l` (clean listing)

**Plugin Integration**:
- `zsh-fast-syntax-highlighting` - Real-time syntax highlighting
- `zsh-autosuggestions` - Intelligent completions
- `fzf-tab` - FZF-powered tab completion

### 🌟 Starship - Cross-Shell Prompt
**Purpose**: Highly customizable shell prompt with multiple themes
**Status**: ✅ Active
**Dependencies**: Nerd fonts for icons

**Key Files**:
- `starship/.config/starship/starship.toml` - Active configuration
- `starship/.config/starship/starship-*.toml` - 5 theme variants

**Available Themes** (5 total):
```
starship/
├── starship.toml                    # Default (Gruvbox Dark Neon)
├── starship-gruvbox-rainbow.toml    # Colorful variant
├── starship-jetpack.toml           # Minimal modern
├── starship-gruvbox-dark-neon.toml # High contrast
└── starship-tokyo-night.toml       # Tokyo Night variant
```

**Theme Switching**:
```bash
# In zsh/.zshrc, change the export line:
export STARSHIP_CONFIG=~/.config/starship/starship-gruvbox-rainbow.toml
```

**Features**:
- Git integration with branch/status indicators
- Language detection (Python, Node, Rust, etc.)
- Performance metrics and timing
- Tmux-aware prompt handling

---

## Development Tools

### 🎨 Neovim - Text Editor
**Purpose**: Comprehensive development environment based on kickstart.nvim
**Status**: ✅ Active
**Dependencies**: LSP servers, various CLI tools

**Key Files**:
- `nvim/.config/nvim/init.lua` - Entry point
- `nvim/.config/nvim/lua/keymaps.lua` - Core keybindings ([detailed guide](NEOVIM_KEYBINDS.md))
- `nvim/.config/nvim/lua/custom/plugins/` - 39 plugin configurations

**Core Architecture**:
```
nvim/
├── init.lua                    # Main entry point
├── lua/
│   ├── keymaps.lua            # Core keybindings
│   ├── options.lua            # Editor settings
│   ├── autocmds.lua           # Auto commands
│   ├── lazy-plugins.lua       # Plugin management
│   └── custom/plugins/        # Plugin configurations
│       ├── telescope.lua      # Fuzzy finding
│       ├── lspconfig.lua      # Language servers
│       ├── codecompanion.lua  # AI assistance
│       ├── obsidian.lua       # Note-taking
│       └── ... (25+ more)
```

**Key Plugin Categories**:
- **Language Support**: LSP, completion, debugging
- **File Management**: Telescope, mini.files, oil, yazi
- **Git Integration**: Neogit, fugitive, gitsigns
- **AI Assistance**: CodeCompanion, Claude integration
- **Note-taking**: Obsidian integration with 15+ commands

**Integration Points**:
- **Tmux**: `vim-tmux-navigator` for seamless pane navigation
- **System Clipboard**: `<leader>y` bindings
- **File Managers**: Multiple options (telescope, oil, yazi, mini.files)
- **Git Workflows**: Terminal aliases + Neovim GUI operations

### 🌊 Sesh - Session Management
**Purpose**: Modern session management with fuzzy finding and templates
**Status**: ✅ Active
**Dependencies**: Tmux, FZF

**Key Files**:
- `sesh/.config/sesh/sesh.toml` - Session definitions
- `sesh/.config/sesh/scripts/` - Session management scripts

**Session Templates**:
```toml
[[session]]
name = "⚙️ Dotfiles"
path = "~/dotfiles"
startup_command = "nvim"

[[session]]
name = "💻 Claude Dev"
path = "~/.local/share/nvim/lazy/claudecode.nvim"
startup_script = "~/.config/sesh/scripts/claude_dev.sh"
```

**Enhanced Workflow**:
- **Quick Access**: `sd` (fuzzy connect), `sl` (list), `sc` (connect)
- **Status Monitoring**: `sesh-dashboard`, `sesh-current`, `sesh-info`
- **Integration**: Works with tmux for complete session management

**Validation**: Manual validation via `sesh list` (validation script removed Oct 2025)

---

## Input Management

### 🥋 Kanata - Advanced Keyboard Remapper (Active)
**Purpose**: Sophisticated keyboard remapping with home row modifiers
**Status**: ✅ Active (PRIMARY)
**Dependencies**: Karabiner-DriverKit-VirtualHIDDevice (for input interception)

**Key Files**:
- `kanata/.config/kanata/kanata.kbd` - Layer definitions
- `/Library/LaunchDaemons/com.example.kanata.plist` - Auto-start daemon

**Binary Path**: `/opt/homebrew/bin/kanata` (Homebrew symlink)

**Homebrew Symlink Strategy**: The LaunchDaemon references the stable Homebrew symlink at `/opt/homebrew/bin/kanata` rather than the versioned Cellar path. This is critical because macOS TCC (Transparency, Consent, and Control) grants Input Monitoring permissions to a specific binary path. When `brew upgrade kanata` replaces the binary in the Cellar, the old path in the TCC database becomes invalid. The Homebrew symlink at `/opt/homebrew/bin/kanata` survives upgrades, so Input Monitoring permissions persist without needing to re-grant them.

**LaunchDaemon Details**:
- Uses a bash wrapper script with a **5-second startup delay** to allow the Karabiner DriverKit VirtualHID daemons to initialize first
- **KeepAlive**: `true` (unconditional restart on crash or exit)

**Active Remappings**:
- **Caps Lock**: Escape on tap, Ctrl on hold
- **Home Row Mods**: a/s/d/f → Cmd/Alt/Shift/Ctrl, j/k/l/; → Ctrl/Shift/Alt/Cmd
- **Right Shift**: Backspace
- **Tab**: Tab on tap, Hyper (Cmd+Alt+Shift+Ctrl) on hold
- **Apostrophe (')**: ' on tap, Numbers layer on hold
- **Forward slash (/)**: Regular / key (no layer)
- **Right Cmd**: Toggle home row mods on/off (tap to switch base↔vanilla layers)
- **Timing**: 200ms tap, 230ms hold thresholds

**Service Management**:
```bash
sudo launchctl print system/com.example.kanata   # Check status
sudo launchctl kickstart -k system/com.example.kanata  # Restart
ps aux | grep kanata | grep -v grep              # Verify running binary path
```

### ⌨️ Karabiner-Elements - Keyboard Remapping (Unconfigured)
**Purpose**: Alternative keyboard modifier (currently unused)
**Status**: ⚠️ Installed but unconfigured
**Dependencies**: None

**Key Files**:
- `karabiner/.config/karabiner/karabiner.json` - Configuration

**Current State**: `simple_modifications` is empty - no active remappings.
Kanata is the primary keyboard remapper.

---

## System Integration

### 🔧 Development Workflow Integration

**File Validation Scripts**:
- `sesh list` - Sesh session validation (manual, validate_sesh.sh removed Oct 2025)
- `~/.config/sketchybar/test_sketchybar.sh` - SketchyBar plugin testing
- `~/.config/sketchybar/debug_sketchybar.sh` - SketchyBar debugging
- `yabai --check-config` - Yabai configuration validation

**BrewIntegration** (in `zsh/.zshrc:45-53`):
```bash
function brew() {
    command brew "$@"
    if [[ $* =~ "upgrade|update|install|uninstall" ]]; then
        sketchybar --trigger brew_update
    fi
}
```

**Cross-Tool Integration Points**:

1. **Window Management**: Aerospace ↔ JankyBorders ↔ SketchyBar
2. **Terminal Stack**: Ghostty ↔ Tmux ↔ Zsh ↔ Starship
3. **Session Management**: Sesh ↔ Tmux ↔ FZF
4. **Development**: Neovim ↔ Tmux ↔ Git ↔ File Managers
5. **Input**: Karabiner/Kanata ↔ All Applications

**Stow Management**:
All components use GNU Stow for deployment:
```bash
# Deploy all components
stow */

# Deploy individual components
stow ghostty aerospace sketchybar # etc.

# Remove components
stow -D component_name
```

---

## Component Status Overview

| Component | Status | Dependencies | Integration Level |
|-----------|--------|--------------|------------------|
| **Aerospace** | ✅ Active | None | Core (Window Management) |
| **JankyBorders** | ✅ Active | Aerospace | Medium (Visual Enhancement) |
| **SketchyBar** | ✅ Active | Aerospace, System Tools | High (System Info) |
| **Ghostty** | ✅ Active | Fonts | Core (Terminal) |
| **Tmux** | ✅ Active | Plugins | High (Session Management) |
| **Zsh** | ✅ Active | Many CLI Tools | High (Shell Environment) |
| **Starship** | ✅ Active | Nerd Fonts | Medium (Prompt) |
| **Neovim** | ✅ Active | LSP Servers | High (Development) |
| **Sesh** | ✅ Active | Tmux, FZF | High (Session Management) |
| **Kanata** | ✅ Active | Karabiner-DriverKit | High (Input Remapping) |
| **Karabiner** | ⚠️ Unconfigured | None | Installed but unused |

---

## Related Documentation

- **[Keybinds Reference](KEYBINDS.md)** - Complete keybindings across all tools
- **[Neovim Keybinds](NEOVIM_KEYBINDS.md)** - Detailed Neovim mappings
- **[Workflow Guides](WORKFLOW_GUIDES.md)** - Cross-tool integration workflows
- **[Multi-LLM Workflow](MULTI_LLM_WORKFLOW.md)** - Claude Code + CodeCompanion orchestration
- **[Maintenance Guide](MAINTENANCE.md)** - Validation and troubleshooting
- **[Main Repository](../README.md)** - Installation and overview
- **[Claude Documentation](../CLAUDE.md)** - Claude Code specific guidance

---

*This documentation provides complete coverage of all 15+ components in the dotfiles repository with cross-references and integration details for both human users and AI agents.*

---

## Author

**cyperx** - [GitHub Profile](https://github.com/cyperx84)

For issues or contributions, visit the [dotfiles repository](https://github.com/cyperx84/dotfiles).