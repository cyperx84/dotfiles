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
| **[🤖 Multi-LLM Workflow](docs/MULTI_LLM_WORKFLOW.md)** | Claude Code + CodeCompanion orchestration | AI development workflows |
| **[📊 Claude Statusline Guide](docs/CLAUDE_STATUSLINE.md)** | Enhanced statusline interpretation | Reading context, cost, and session info |
| **[🔧 Maintenance Guide](docs/MAINTENANCE.md)** | Validation, troubleshooting, updates | System reliability |
| **[🤖 Claude Documentation](CLAUDE.md)** | Claude Code guidance & agent guidelines | AI-assisted development |

## 🌟 Features

- **🪟 Tiling Window Management**: Aerospace tiling window manager
- **🔲 Window Borders**: JankyBorders for visual window separation
- **🎨 Beautiful Terminal**: Ghostty with custom shaders and Starship prompt
- **⌨️ Advanced Key Remapping**: Kanata with home row mods + Karabiner-Elements
- **📊 System Monitoring**: SketchyBar for elegant macOS menu bar replacement
- **🚀 Terminal Multiplexing**: Tmux with Catppuccin theme and advanced plugins
- **⚡ Modern Shell**: Zsh with FZF, syntax highlighting, and intelligent completions
- **🛠️ Development Ready**: Neovim with extensive plugin ecosystem

## 📂 Project Structure

```
dotfiles/
├── aerospace/       # Aerospace tiling window manager
├── borders/         # JankyBorders window border configuration
├── ghostty/         # Modern terminal emulator configuration
├── kanata/          # Advanced keyboard remapper with home row mods
├── karabiner/       # Keyboard remapping and shortcuts
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

### 🦾 **Kanata** - Advanced Keyboard Remapper (Active)
Sophisticated keyboard remapping with home row modifiers:
- **Caps Lock**: Escape on tap, Ctrl on hold
- **Home Row Mods**: Hold a/s/d/f/j/k/l/; for modifiers (Cmd/Alt/Shift/Ctrl)
- **Right Shift**: Backspace
- **Tab**: Hyper key (Cmd+Alt+Shift+Ctrl) on hold
- **Apostrophe (')**: ' on tap, Numbers layer on hold
- **Forward slash (/)**: Regular / key (no layer)
- **Right Cmd**: Toggle home row mods on/off (tap to switch base↔vanilla layers)
- **Timing**: 200ms tap, 230ms hold thresholds
- **Binary**: `/opt/homebrew/bin/kanata` (Homebrew symlink)
- **Auto-start**: LaunchDaemon with 5s startup delay via bash wrapper
- **TCC Permissions**: Uses Homebrew symlink so permissions survive `brew upgrade`
- **Status**: ✅ Active (PRIMARY)

### ⛓️‍💥 **Karabiner-Elements** - Keyboard Remapping (Unconfigured)
Installed but currently unused:
- **Status**: ⚠️ `simple_modifications` is empty
- Kanata is the primary keyboard remapper

### 🚀 **Aerospace** - Tiling Window Manager (PRIMARY)
macOS tiling window manager with native keybindings:
- **Configuration**: `~/.config/aerospace/aerospace.toml` (TOML format)
- **Auto-start**: Launches at login automatically
- **SketchyBar Integration**: Direct workspace callbacks for seamless integration
- **Padding**: 52px top padding for SketchyBar, 20px inner gaps

**Key Features:**
- Native window management without external dependencies
- Smart resize adapts to window position
- Workspace navigation: `cmd+j/k/l` for workspaces 1-3
- Window focus: `shift+ctrl+hjkl`
- Window movement: `shift+ctrl+alt+hjkl`
- Toggle fullscreen: `shift+ctrl+w`
- Service mode: `shift+alt+cmd+r` for advanced operations

### 🔲 **JankyBorders** - Window Borders
Lightweight window border system for visual clarity:
- **Active Window**: Bright green border (`0xff00ff00`)
- **Inactive Windows**: Muted gray border (`0xff494d64`)
- **Style**: Rounded corners, 5px width
- **Config**: `~/.config/borders/bordersrc`
- **Auto-start**: Via Aerospace `after-startup-command`

### 📊 **SketchyBar** - Menu Bar Replacement
Elegant and customizable macOS menu bar:
- **Appearance**: Top position, 40px height, blur effects
- **Font**: MonaspiceRn Nerd Font
- **Modules**: Spaces, front app, clock, volume, battery
- **Integration**: Aerospace workspace indicators with instant updates

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
- **Available Themes**: 5 different configurations
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
**Included via Git submodule** - works seamlessly on any system (macOS, Linux, Windows).

**Quick Facts:**
- **38 Plugin** configuration files
- **100+ Keybindings** organized by function
- **4 LSP Servers** configured (C/C++, Python, Rust, Lua)
- **4 AI Integrations** (Claude, CodeCompanion, Copilot, SuperMaven)
- **40+ Treesitter Languages** for syntax highlighting

**Key Features:**
- AI-assisted development with Claude Code and CodeCompanion
- Obsidian integration for knowledge management
- Advanced git workflow (Neogit, Gitsigns)
- DAP debugging with UI
- Multiple file explorers (Mini.files, Oil, Yazi)
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
brew install --cask nikitabobko/tap/aerospace  # Aerospace tiling window manager
brew tap FelixKratz/formulae && brew install borders  # JankyBorders window borders
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

# Temperature monitoring (required for M4 Macs)
brew tap narugit/tap && brew install narugit/tap/smctemp
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
brew install --cask ghostty karabiner-elements font-monaspace font-meslo-lg-nerd-font nikitabobko/tap/aerospace
brew tap FelixKratz/formulae && brew install borders
brew tap narugit/tap && brew install narugit/tap/smctemp  # M4 temperature monitoring
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

   # Start JankyBorders (auto-starts with Aerospace, but manual start if needed)
   borders &

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

## 📦 Git Submodule Management

### About Nvim as a Git Submodule

The Neovim configuration is included via **Git submodule**, which allows:
- ✅ Complete nvim independence (can be used separately on Linux/Mac)
- ✅ Fast push/pull — no history scanning
- ✅ Simple two-repo workflow
- ✅ Works perfectly with `stow` for configuration management

> **Note**: Clone dotfiles with `--recurse-submodules` to get the nvim config automatically.

### Cloning (includes nvim)

```bash
git clone --recurse-submodules https://github.com/cyperx84/dotfiles.git ~/dotfiles

# Or after a plain clone:
cd ~/dotfiles && git submodule update --init
```

### Updating Nvim

```bash
cd ~/dotfiles
git submodule update --remote nvim
git add nvim && git commit -m "Update nvim submodule"
git push
```

### Using Nvim Independently

```bash
# Clone the nvim-specific repository
git clone https://github.com/cyperx84/nvim.git ~/.config/nvim

# Launch Neovim (plugins auto-install on first run)
nvim
```

### Modifying and Pushing Nvim Changes

```bash
# 1. Make changes inside the submodule
cd ~/dotfiles/nvim
git add . && git commit -m "Your change"
git push

# 2. Update the submodule pointer in dotfiles
cd ~/dotfiles
git add nvim && git commit -m "Update nvim submodule"
git push
```

### Troubleshooting

**Submodule shows as dirty after clone:**
```bash
git submodule update --init --recursive
```

**Check submodule status:**
```bash
git submodule status
```

## ⚙️ Customization

### Keyboard Remapping
Kanata is the active keyboard remapper with home row mods:

**Kanata (Active):**
- **Binary**: `/opt/homebrew/bin/kanata` (Homebrew symlink, TCC permissions survive `brew upgrade`)
- **LaunchDaemon**: Uses bash wrapper with 5s startup delay to ensure Karabiner VirtualHID is ready

```bash
# Check status
sudo launchctl print system/com.example.kanata

# Restart after config changes
sudo launchctl kickstart -k system/com.example.kanata

# View config
cat ~/.config/kanata/kanata.kbd

# Verify binary path
ls -la /opt/homebrew/bin/kanata
```

**To switch to Karabiner-Elements:**
```bash
# Disable Kanata
sudo launchctl bootout system /Library/LaunchDaemons/com.example.kanata.plist

# Configure Karabiner-Elements via its GUI
# Add remappings to simple_modifications
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
killall borders && borders &              # Restart window borders
sketchybar --reload                       # Reload menu bar
exec zsh                                  # Reload shell config
```

**🔧 Troubleshooting**: See [Maintenance Guide](docs/MAINTENANCE.md) for detailed procedures

## 🔍 File Highlights

### Configuration Files
- `ghostty/config` - Terminal appearance and behavior
- `karabiner/karabiner.json` - Simple keyboard remapping rules
- `kanata/kanata.kbd` - Advanced keyboard remapping with home row mods
- `aerospace/aerospace.toml` - Aerospace window manager
- `borders/bordersrc` - JankyBorders window borders
- `tmux/.tmux.conf` - Terminal multiplexer setup
- `zsh/.zshrc` - Shell configuration and aliases

### Special Features
- **Aerospace**: Tiling window management with tiles/accordion layouts
- **JankyBorders**: Visual window borders (green active, gray inactive)
- **SketchyBar Plugins**: 40 custom status bar plugins in `sketchybar/plugins/`
- **Starship Themes**: 5 different prompt configurations
- **Tmux Plugins**: Auto-installing plugin manager with 10 plugins
- **Neovim**: 38 plugin configuration files (git submodule)
- **Multi-LLM Workflow**: Claude Code + CodeCompanion integration (see `docs/MULTI_LLM_WORKFLOW.md`)

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

---

## Author

**cyperx** - [GitHub Profile](https://github.com/cyperx84)

For issues or contributions, visit the [dotfiles repository](https://github.com/cyperx84/dotfiles).
