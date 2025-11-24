---
id: README
tags: []
---

# 👾 cyperx's Dotfiles

```
          ▄████▄  ▓██   ██▓ ██▓███  ▓█████  ██▀███  ▒██   ██▒
         ▒██▀ ▀█   ▒██  ██▒▓██░  ██▒▓█   ▀ ▓██ ▒ ██▒▒▒ █ █ ▒░
         ▒▓█    ▄   ▒██ ██░▓██░ ██▓▒▒███   ▓██ ░▄█ ▒░░  █   ░
         ▒▓▓▄ ▄██▒  ░ ▐██▓░▒██▄█▓▒ ▒▒▓█  ▄ ▒██▀▀█▄   ░ █ █ ▒ 
         ▒ ▓███▀ ░  ░ ██▒▓░▒██▒ ░  ░░▒████▒░██▓ ▒██▒▒██▒ ▒██▒
         ░ ░▒ ▒  ░   ██▒▒▒ ▒▓▒░ ░  ░░░ ▒░ ░░ ▒▓ ░▒▓░▒▒ ░ ░▓ ░
           ░  ▒    ▓██ ░▒░ ░▒ ░      ░ ░  ░  ░▒ ░ ▒░░░   ░▒ ░
         ░         ▒ ▒ ░░  ░░          ░     ░░   ░  ░    ░  
         ░ ░       ░ ░                 ░  ░   ░      ░    ░  
         ░         ░ ░                                       
```

A curated collection of configuration files for a complete macOS development environment. This setup creates a beautiful, efficient, and highly customized workflow centered around tiling window management, terminal productivity, and modern development tools.

## 📚 Documentation Hub

> **🚀 Quick Start**: [Installation](#-installation) • **🔧 Components**: [Detailed Guide](docs/COMPONENTS.md) • **⌨️ Keybinds**: [Reference](docs/KEYBINDS.md) • **🔄 Workflows**: [Integration Guide](docs/WORKFLOW_GUIDES.md)

| Document | Purpose | For |
|----------|---------|-----|
| **[📋 Components Guide](docs/COMPONENTS.md)** | Detailed documentation for all 15+ tools | Understanding each component |
| **[⌨️ Keybinds Reference](docs/KEYBINDS.md)** | Complete keybindings across all tools | Quick reference and lookup |
| **[📝 Neovim Keybinds](docs/NEOVIM_KEYBINDS.md)** | Comprehensive Neovim mappings | Editor workflow mastery |
| **[🔄 Workflow Guides](docs/WORKFLOW_GUIDES.md)** | Cross-tool integration patterns | Learning tool combinations |
| **[📊 Claude Statusline Guide](docs/CLAUDE_STATUSLINE.md)** | Enhanced statusline interpretation | Reading context, cost, and session info |
| **[🔧 Maintenance Guide](docs/MAINTENANCE.md)** | Validation, troubleshooting, updates | System reliability |
| **[🤖 Claude Documentation](CLAUDE.md)** | Claude Code specific guidance | AI-assisted development |
| **[👨‍💻 Agent Guidelines](AGENTS.md)** | Development and testing procedures | Contributing and maintenance |

## 🌟 Features

- **🪟 Tiling Window Management**: Aerospace for modern, integrated window control (Primary)
- **🎨 Beautiful Terminal**: Ghostty with custom shaders and Starship prompt
- **⌨️ Advanced Key Remapping**: Kanata with home row mods + Karabiner-Elements
- **📊 System Monitoring**: SketchyBar for elegant macOS menu bar replacement
- **🚀 Terminal Multiplexing**: Tmux with Catppuccin theme and advanced plugins
- **⚡ Modern Shell**: Zsh with FZF, syntax highlighting, and intelligent completions
- **🛠️ Development Ready**: Neovim with extensive plugin ecosystem

## 📂 Project Structure

```
dotfiles/
├── aerospace/       # Tiling window manager
├── ghostty/          # Modern terminal emulator configuration
├── kanata/           # Advanced keyboard remapper with home row mods
├── karabiner/        # Keyboard remapping and shortcuts
├── nvim/            # Neovim editor configuration
├── sketchybar/      # macOS menu bar replacement
├── starship/        # Cross-shell prompt themes
├── tmux/            # Terminal multiplexer configuration
└── zsh/             # Z shell configuration and plugins
```

## 🛠️ Components Overview

### 👻 **Ghostty** - Terminal Emulator
Modern GPU-accelerated terminal with extensive customization:
- **Font**: MonaspiceNe Nerd Font family with ligatures
- **Theme**: Monokai Remastered with transparency and blur effects
- **Features**: GPU-accelerated rendering with blur effects
- **Shortcuts**: Global quick terminal toggle (`cmd+/`)

**Key Features:**
- Font ligatures and stylistic sets (ss01-ss04, liga)
- Background blur and transparency effects
- macOS-specific optimizations
- Secure input handling

### ⛓️‍💥 **Karabiner-Elements** - Keyboard Remapping
Advanced keyboard customization for ergonomic improvements:
- **Caps Lock** → Left Control (vim-friendly)
- **Right Command** → Backspace
- **Right Shift** → Backspace
- **Function Keys**: Customized F1-F12 mappings

### 🦾 **Kanata** - Advanced Keyboard Remapper (Alternative)
Sophisticated keyboard remapping with home row modifiers:
- **Home Row Mods**: Hold a/s/d/f/j/k/l/; for modifiers (Cmd/Alt/Shift/Ctrl)
- **Layer System**: Function layer accessible via Fn key
- **Timing**: 150ms tap time, 200ms hold time for optimal response
- **Status**: Configured but inactive (use instead of Karabiner if preferred)

### 🚀 **Aerospace** - Modern Tiling Window Manager (PRIMARY)
Next-generation tiling window manager for macOS:
- **Configuration**: Single TOML file with integrated keybindings (no external daemon)
- **Layout**: Tiles and accordion modes with 2px gaps
- **Auto-start**: Launches at login automatically
- **SketchyBar Integration**: Direct workspace callbacks for seamless integration
- **Padding**: 32px top padding for SketchyBar

**Key Features:**
- Native window management without external dependencies
- Smart resize adapts to window position
- Workspace navigation: `cmd+ctrl+jkl` for workspaces 1-3
- Window focus: `shift+ctrl+hjkl`
- Window movement: `shift+ctrl+alt+hjkl`
- Toggle fullscreen: `shift+ctrl+w`
- Service mode: `shift+alt+cmd+r` for advanced operations

### 📊 **SketchyBar** - Menu Bar Replacement
Elegant and customizable macOS menu bar:
- **Appearance**: Top position, 40px height, blur effects
- **Font**: MonaspiceRn Nerd Font
- **Modules**: Spaces, front app, clock, volume, battery
- **Integration**: Aerospace workspace indicators

### 🪟 **Tmux** - Terminal Multiplexer
Feature-rich terminal session management:
- **Prefix**: `Ctrl+A` (instead of default Ctrl+B)
- **Theme**: Catppuccin Mocha with custom status line
- **Navigation**: Vim-style pane navigation (`hjkl`)
- **Plugins**: 10+ plugins for enhanced functionality

**Key Plugins:**
- `tmux-sessionx` - Smart session management
- `tmux-floax` - Floating terminal windows
- `vim-tmux-navigator` - Seamless Vim integration
- `tmux-resurrect` + `tmux-continuum` - Session persistence

### 🚀 **Starship** - Cross-Shell Prompt
Highly customizable prompt with multiple themes:
- **Active Theme**: Gruvbox Dark Neon
- **Available Themes**: 6 different configurations
- **Features**: Git integration, language detection, performance metrics
- **Style**: Powerline-inspired with custom symbols

### 🦪 **Zsh** - Z Shell
Modern shell with extensive enhancements:
- **Syntax Highlighting**: Fast syntax highlighting
- **Autosuggestions**: Intelligent command completion
- **FZF Integration**: Fuzzy finding for files, commands, and history
- **Aliases**: 50+ productivity aliases for Git, Docker, K8s

**Key Features:**
- Custom FZF functions for navigation (`fcd`, `fv`, `f`)
- Yazi file manager integration
- UV Python environment management
- Extensive Git, Docker, and Kubernetes aliases

### 👾 **Neovim** - Text Editor
A powerful, modern Neovim setup based on kickstart.nvim with extensive customization.
**Included via Git subtree** - works seamlessly on any system (macOS, Linux, Windows).

**Quick Facts:**
- **68 Plugins** across 45 configuration files
- **100+ Keybindings** organized by function
- **4 LSP Servers** configured (C/C++, Python, Rust, Lua)
- **4 AI Integrations** (Claude, CodeCompanion, Copilot, SuperMaven)
- **18 Treesitter Languages** for syntax highlighting

**Key Features:**
- AI-assisted development with Claude Code and CodeCompanion
- Obsidian integration for knowledge management
- Advanced git workflow (Neogit, Gitsigns, Fugitive)
- DAP debugging with UI
- Multiple file explorers (Mini.files, Oil, Neo-tree, Yazi)
- Tokyo Night theme with transparency

**Complete Documentation:** See [nvim/README.md](nvim/README.md) for full details, keybindings, and setup instructions.

## 🔧 Installation

### Prerequisites

First, ensure you have Homebrew installed:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Essential Dependencies

#### Core Applications (Casks)
```bash
# Terminal & Input
brew install --cask ghostty                 # Modern GPU-accelerated terminal
brew install --cask karabiner-elements      # Advanced keyboard remapping

# Fonts
brew install --cask font-monaspace         # MonaspiceNe Nerd Font family
brew install --cask font-meslo-lg-nerd-font # MesloLGS Nerd Font
```

#### System & Window Management
```bash
brew install --cask aerospace               # Tiling window manager
brew install sketchybar                     # Menu bar replacement
brew install stow                           # Configuration management
```

#### Shell & Terminal Enhancement
```bash
brew install starship                       # Cross-shell prompt
brew install tmux                           # Terminal multiplexer
brew install zsh-fast-syntax-highlighting  # Shell syntax highlighting
brew install zsh-autosuggestions           # Shell autosuggestions
brew install fzf                           # Fuzzy finder
brew install fd                            # Modern 'find' replacement
brew install bat                           # Modern 'cat' with syntax highlighting
brew install eza                           # Modern 'ls' replacement
brew install zoxide                        # Smart directory jumper
brew install ripgrep                       # Fast text search
```

#### Development Tools
```bash
brew install nvim                          # Neovim text editor
brew install git                           # Version control
brew install gh                            # GitHub CLI
brew install yazi                          # Terminal file manager
brew install sesh                          # Session management
```

#### System Utilities
```bash
brew install jq                            # JSON processor
brew install wget                          # File downloader
brew install curl                          # Data transfer tool
```

#### Optional Tools
```bash
# Programming Languages
brew install uv                            # Python package manager
brew install node                          # Node.js runtime
brew install python                        # Python interpreter

# Kubernetes (if needed)
brew install kubectl                       # Kubernetes CLI
brew install kubectx                       # Kubernetes context switcher
brew install kubens                        # Kubernetes namespace switcher

# Additional Utilities
brew install docker                        # Containerization
brew install switchaudio-osx              # Audio source switcher
```

#### Quick Install Script
For convenience, you can install all essential dependencies at once:
```bash
# Essential packages only
brew install --cask ghostty karabiner-elements font-monaspace font-meslo-lg-nerd-font aerospace
brew install sketchybar stow starship tmux zsh-fast-syntax-highlighting zsh-autosuggestions fzf fd bat eza zoxide ripgrep nvim git gh yazi sesh jq wget curl

# Optional additions
brew install uv node python kubectl kubectx kubens docker switchaudio-osx kanata
```

### Setup Instructions

1. **Clone the repository:**
   ```bash
   git clone https://github.com/cyperx84/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **Install configurations using Stow:**
   ```bash
   # Install GNU Stow if not already installed
   brew install stow

   # Install all configurations at once
   stow */

   # Or install individual components
   stow ghostty karabiner sesh sketchybar starship tmux zsh nvim aerospace
   ```

3. **Start services:**
   ```bash
   # Start Aerospace (or it will auto-start on login)
   open -a AeroSpace

   # Start SketchyBar
   brew services start sketchybar

   # Restart shell to load Zsh config
   exec zsh

   # Install Neovim plugins (on first launch)
   nvim  # Wait for plugins to download (~30-60 seconds)
   ```

4. **Configure permissions:**
   - Grant accessibility permissions to Aerospace in System Preferences
   - Allow Karabiner-Elements to modify keyboard input
   - Configure Ghostty as default terminal

## 📦 Git Subtree Management

### About Nvim as a Git Subtree

The Neovim configuration is included via **Git subtree**, which allows:
- ✅ Seamless cloning with `git clone` (no special flags needed)
- ✅ Complete nvim independence (can be used separately on Linux/Mac)
- ✅ Simple unified git history
- ✅ Works perfectly with `stow` for configuration management

### Updating Nvim

To update nvim to the latest version:

```bash
# Update nvim subtree to latest
cd ~/dotfiles
git subtree pull --prefix nvim https://github.com/cyperx84/nvim.git main

# Or if you prefer to be explicit:
git subtree pull --prefix nvim https://github.com/cyperx84/nvim.git main --squash
```

### Using Nvim Independently

If you want just the Neovim configuration without other dotfiles:

```bash
# Clone the nvim-specific repository
git clone https://github.com/cyperx84/nvim.git ~/.config/nvim

# Launch Neovim (plugins auto-install on first run)
nvim
```

### Modifying and Pushing Nvim Changes

If you make changes to nvim and want to sync them back:

```bash
cd ~/dotfiles

# Make your changes to nvim configs
# ...

# Push changes back to nvim repository
git subtree push --prefix nvim https://github.com/cyperx84/nvim.git main

# Or create a branch first (safer):
git subtree split --prefix nvim -b nvim-update
git push https://github.com/cyperx84/nvim.git nvim-update:main
```

### Troubleshooting Subtree Issues

**Pull subtree updates without merging:**
```bash
git subtree pull --prefix nvim https://github.com/cyperx84/nvim.git main --squash
```

**Check subtree history:**
```bash
git log --all -- nvim/
```

**Merge nvim updates from main branch:**
```bash
git subtree merge --prefix nvim https://github.com/cyperx84/nvim.git main --squash
```

## ⚙️ Customization

### Keyboard Remapping Choice
Choose between two keyboard remapping solutions:

**Karabiner-Elements (Default):**
```bash
# Already active if you followed installation
# Simple remappings work out of the box
```

**Kanata (Advanced Alternative):**
```bash
# Disable Karabiner-Elements first
# Then start kanata with:
sudo kanata --cfg ~/.config/kanata/kanata.kbd

# For permanent activation, create a launch daemon
```

### Starship Themes
Switch between different prompt themes by modifying `~/.zshrc`:
```bash
export STARSHIP_CONFIG=~/.config/starship/starship-gruvbox-dark-neon.toml
# export STARSHIP_CONFIG=~/.config/starship/starship-gruvbox-rainbow.toml
# export STARSHIP_CONFIG=~/.config/starship/starship-jetpack.toml
```

### Tmux Customization
Modify plugin settings in `.tmux.conf`:
```bash
# Float window settings
set -g @floax-width '80%'
set -g @floax-height '80%'
set -g @floax-bind 'p'
```

## 🎯 Quick Reference

### Most Used Commands
```bash
# Session Management
sd                    # Fuzzy connect to session (sesh + fzf)
Alt+s                 # Quick session selector (zsh keybind)
sesh-dashboard        # Comprehensive session overview
ta                    # Attach to tmux

# File Operations
fcd                   # Fuzzy directory navigation
fv                    # Fuzzy file selection + edit
f                     # Yazi file manager with cd
ls                    # Enhanced listing (eza)

# Git Workflow
gs                    # Git status
gc "message"          # Quick commit
gp                    # Push current branch
glog                  # Enhanced git log

# Development
n                     # Open Neovim
conf                  # Edit dotfiles
no                    # Open notes (Obsidian)
```

### Essential Keybinds
```bash
# Window Management (Aerospace)
cmd+ctrl+jkl         # Switch workspaces 1-3
shift+ctrl+hjkl      # Focus windows
shift+ctrl+w         # Toggle fullscreen

# Tmux (Prefix: Ctrl+A)
C-a T                # Session switcher
C-a hjkl             # Navigate panes
C-a sv               # Split panes

# Neovim
<leader>sf           # Find files (telescope)
<leader>gg           # Git interface (neogit)
<leader>e            # File manager (mini.files)
jk                   # Exit insert mode
```

**📖 Complete Reference**: See [Keybinds Documentation](docs/KEYBINDS.md) for full listings

### Validation & Maintenance
```bash
# System Health Checks
sesh list                                 # Check sesh sessions (manual)
~/.config/sketchybar/test_sketchybar.sh   # Test SketchyBar plugins

# Service Management
killall AeroSpace && open -a AeroSpace    # Restart window manager
sketchybar --reload                       # Reload menu bar
exec zsh                                  # Reload shell config
```

**🔧 Troubleshooting**: See [Maintenance Guide](docs/MAINTENANCE.md) for detailed procedures

## 🔍 File Highlights

### Configuration Files
- `ghostty/config` - Terminal appearance and behavior
- `karabiner/karabiner.json` - Simple keyboard remapping rules
- `kanata/kanata.kbd` - Advanced keyboard remapping with home row mods
- `aerospace/aerospace.toml` - Window manager configuration
- `tmux/.tmux.conf` - Terminal multiplexer setup
- `zsh/.zshrc` - Shell configuration and aliases

### Special Features
- **SketchyBar Plugins**: Custom status bar modules in `sketchybar/plugins/`
- **Starship Themes**: 6 different prompt configurations
- **Tmux Plugins**: Auto-installing plugin manager with 10+ plugins
- **Neovim**: 68 plugins across 45 configuration files

## 🤝 Contributing

Feel free to fork this repository and adapt it to your needs. If you have improvements or suggestions:

1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

## 🙏 Acknowledgments

- [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) - Neovim configuration base
- [Catppuccin](https://github.com/catppuccin) - Beautiful color schemes
- The amazing macOS community for tool development

---

*This dotfiles setup represents years of refinement for optimal productivity and aesthetics on macOS.*
