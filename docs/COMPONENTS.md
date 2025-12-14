# Dotfiles Components Reference

> **🧭 Navigation Hub**
> [Window Management](#window-management) • [Terminal Environment](#terminal-environment) • [Development Tools](#development-tools) • [Input Management](#input-management) • [System Integration](#system-integration)

## Overview

This document provides comprehensive documentation for all 15+ components in the dotfiles repository, organized by functional category with detailed configuration references and integration points.

**Repository Structure**: Each component follows GNU Stow conventions with configurations in `component/.config/tool/` format for automatic symlinking.

---

## Window Management

### 🚀 HyprSpace - Tiling Window Manager with Dwindle Layout
**Purpose**: Aerospace fork with Hyprland-style binary tree tiling (dwindle layout)
**Status**: ✅ Active (PRIMARY)
**Dependencies**: None (self-contained)

**Key Files**:
- `aerospace/.config/aerospace/hyprspace.toml` - Complete configuration
- Symlinked to `~/.hyprspace.toml`

**Configuration Highlights**:
```toml
# Dwindle layout - auto split direction based on aspect ratio
default-root-container-layout = 'dwindle'

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
    inner.horizontal = 2
    inner.vertical = 2
    outer.top = 32  # SketchyBar padding
```

**Integration Points**:
- **SketchyBar**: Direct workspace callbacks + window change events for instant updates
- **JankyBorders**: Auto-started via `after-startup-command`
- **Native Keybindings**: All hotkeys defined in hyprspace.toml (no external daemon)
- **Automatic**: Launches at login, validates config on startup

**Key Features**:
- **Dwindle Layout**: Hyprland-style binary tree tiling (auto split direction)
- **Smart Resize**: Context-aware window resizing
- **Service Mode**: Advanced operations mode (`shift+alt+cmd+r`)
- **Normalization**: Automatic container flattening and orientation handling
- **CLI**: `hyprspace` command (same syntax as `aerospace`)

**Service Management**:
```bash
open -a HyprSpace                         # Start
killall HyprSpace && open -a HyprSpace    # Restart
hyprspace reload-config                   # Reload config only
hyprspace list-workspaces --focused       # Check focused workspace
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
- **HyprSpace**: Auto-started via `after-startup-command`
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
**Dependencies**: HyprSpace for workspace information, various system tools

**Key Files**:
- `sketchybar/.config/sketchybar/sketchybarrc` - Main configuration
- `sketchybar/.config/sketchybar/plugins/` - 30+ plugin scripts
- `sketchybar/.config/sketchybar/helper/` - C helper binary

**Plugin Architecture**:
```
plugins/
├── aerospace.sh          # HyprSpace workspace management (PRIMARY)
├── create_workspace.sh   # Workspace creation handler
├── space_window_count.sh # Window count per workspace
├── space.sh             # Space display (click to switch)
├── brew.sh               # Package updates
├── calendar.sh           # Date/time display
├── claude.sh             # Claude integration
├── cpu.sh                # System monitoring
├── front_app.sh          # Active application
├── git.sh                # Git repository status
├── github.sh             # GitHub notifications
├── volume.sh             # Audio control
└── ... (25+ more plugins)
```

**Styling**:
- **Position**: Top bar, 40px height
- **Font**: MonaspiceRn Nerd Font
- **Theme**: Blur effects with custom colors
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

**Custom Scripts**:
**Location**: `tmux/.tmux/scripts/` (migrated from `sesh/.config/sesh/scripts/` Oct 2025)

**Scripts** (12 files):
- `sesh_list_enhanced.sh` - Enhanced session listing with icons, git integration, and resource monitoring (7.3KB)
- `sesh_list_wrapper.sh` - Toggles session list display mode (compact/detailed)
- `sesh_list_icons.sh` - Icon mapping for different session types
- `sesh_preview.sh` - FZF preview window content with detailed session information (18KB)
- `sesh_switcher.sh` - Smart session switching logic with fallback
- `sesh_smart_start.sh` - Intelligent session creation with context detection
- `sesh_clean_selection.sh` - Enhanced FZF selection with cleanup
- `sesh_edit.sh` - Edit session configurations interactively
- `session_helper.sh` - General session utilities and helpers
- `kill_sesh_session.sh` - Kill specific session with confirmation
- `sesh_create_new.sh` - Create new named sessions
- `sesh_preview_with_keybinds.sh` - Preview with embedded keybind reference

**Integration**:
- Called from tmux keybindings: `C-a e` (session switcher), `C-a L` (session list)
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
- `starship/.config/starship/starship-*.toml` - 6 theme variants

**Available Themes**:
```
starship/
├── starship.toml                    # Default (Gruvbox Dark Neon)
├── starship-gruvbox-rainbow.toml    # Colorful variant
├── starship-jetpack.toml           # Minimal modern
├── starship-gruvbox-dark-neon.toml # High contrast
└── ... (2 more variants)
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
- `nvim/.config/nvim/lua/custom/plugins/` - 30+ plugin configurations

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
- `tmux/.tmux/scripts/sesh_*.sh` - Session management scripts (migrated Oct 2025)

**⚠️ NOTE**: Sesh-specific scripts were migrated from `sesh/.config/sesh/scripts/` to `tmux/.tmux/scripts/` in Oct 2025

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

### ⌨️ Karabiner-Elements - Keyboard Remapping
**Purpose**: Simple, reliable keyboard modifications for ergonomic improvements
**Status**: ✅ Active (Default Choice)
**Dependencies**: None

**Key Files**:
- `karabiner/.config/karabiner/karabiner.json` - Configuration

**Remapping Rules**:
```json
{
  "simple_modifications": [
    { "from": "caps_lock", "to": "left_control" },
    { "from": "right_command", "to": "delete_or_backspace" },
    { "from": "right_shift", "to": "delete_or_backspace" }
  ]
}
```

**Features**:
- **Function Key Passthrough**: F1-F12 work as expected
- **Device-Specific**: Different rules per keyboard
- **Stability**: Reliable, simple configuration

### 🥋 Kanata - Advanced Keyboard Remapper
**Purpose**: Sophisticated keyboard remapping with home row modifiers
**Status**: ⚠️ Configured but Inactive (Alternative to Karabiner)
**Dependencies**: None (runs as system service)

**Key Files**:
- `kanata/.config/kanata/kanata.kbd` - Layer definitions

**Home Row Modifiers**:
```lisp
(defalias
  a (tap-hold 150 200 a lmet)    ; a/Left Cmd
  s (tap-hold 150 200 s lalt)    ; s/Left Alt
  d (tap-hold 150 200 d lsft)    ; d/Left Shift
  f (tap-hold 150 200 f lctl)    ; f/Left Control
  j (tap-hold 150 200 j rctl)    ; j/Right Control
  k (tap-hold 150 200 k rsft)    ; k/Right Shift
  l (tap-hold 150 200 l ralt)    ; l/Right Alt
  ; (tap-hold 150 200 ; rmet)    ; ;/Right Cmd
)
```

**Advanced Features**:
- **Layer System**: Function layer via Fn key
- **Timing Control**: 150ms tap, 200ms hold thresholds
- **Ergonomic**: Reduces finger movement for modifier keys

**Activation** (if preferred over Karabiner):
```bash
# Stop Karabiner-Elements
# Start kanata as system service:
sudo kanata --cfg ~/.config/kanata/kanata.kbd
```

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

1. **Window Management**: HyprSpace ↔ JankyBorders ↔ SketchyBar
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
| **HyprSpace** | ✅ Active | None | Core (Window Management) |
| **JankyBorders** | ✅ Active | HyprSpace | Medium (Visual Enhancement) |
| **SketchyBar** | ✅ Active | HyprSpace, System Tools | High (System Info) |
| **Ghostty** | ✅ Active | Fonts | Core (Terminal) |
| **Tmux** | ✅ Active | Plugins | High (Session Management) |
| **Zsh** | ✅ Active | Many CLI Tools | High (Shell Environment) |
| **Starship** | ✅ Active | Nerd Fonts | Medium (Prompt) |
| **Neovim** | ✅ Active | LSP Servers | High (Development) |
| **Sesh** | ✅ Active | Tmux, FZF | High (Session Management) |
| **Karabiner** | ✅ Active | None | Medium (Input Remapping) |
| **Kanata** | ⚠️ Configured | None | Alternative Input Option |

---

## Related Documentation

- **[Keybinds Reference](KEYBINDS.md)** - Complete keybindings across all tools
- **[Neovim Keybinds](NEOVIM_KEYBINDS.md)** - Detailed Neovim mappings
- **[Workflow Guides](WORKFLOW_GUIDES.md)** - Cross-tool integration workflows
- **[Maintenance Guide](MAINTENANCE.md)** - Validation and troubleshooting
- **[Main Repository](../README.md)** - Installation and overview
- **[Claude Documentation](../CLAUDE.md)** - Claude Code specific guidance

---

*This documentation provides complete coverage of all 15+ components in the dotfiles repository with cross-references and integration details for both human users and AI agents.*