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

## 🌟 Features

- **🪟 Tiling Window Management**: Yabai + SKHD for seamless window control
- **🎨 Beautiful Terminal**: Ghostty with custom shaders and Starship prompt
- **⌨️ Advanced Key Remapping**: Karabiner-Elements for ergonomic keyboard improvements
- **📊 System Monitoring**: SketchyBar for elegant macOS menu bar replacement
- **🚀 Terminal Multiplexing**: Tmux with Catppuccin theme and advanced plugins
- **⚡ Modern Shell**: Zsh with FZF, syntax highlighting, and intelligent completions
- **🛠️ Development Ready**: Neovim with extensive plugin ecosystem

## 📂 Project Structure

```
dotfiles/
├── ghostty/          # Modern terminal emulator configuration
├── karabiner/        # Keyboard remapping and shortcuts
├── nvim/            # Neovim editor configuration  
├── sketchybar/      # macOS menu bar replacement
├── skhd/            # Hotkey daemon for window management
├── starship/        # Cross-shell prompt themes
├── tmux/            # Terminal multiplexer configuration
├── yabai/           # Tiling window manager
└── zsh/             # Z shell configuration and plugins
```

## 🛠️ Components Overview

### 👻 **Ghostty** - Terminal Emulator
Modern GPU-accelerated terminal with extensive customization:
- **Font**: MonaspiceNe Nerd Font family with ligatures
- **Theme**: Monokai Remastered with transparency and blur effects
- **Features**: Extensive shader collection for visual effects
- **Shortcuts**: Global quick terminal toggle (`cmd+/`)

**Key Features:**
- 30+ custom GLSL shaders (Matrix, CRT, Galaxy, etc.)
- Font ligatures and stylistic sets
- macOS-specific optimizations
- Secure input handling

### ⛓️‍💥 **Karabiner-Elements** - Keyboard Remapping
Advanced keyboard customization for ergonomic improvements:
- **Caps Lock** → Left Control (vim-friendly)
- **Right Command** → Backspace
- **Right Shift** → Backspace
- **Function Keys**: Customized F1-F12 mappings

### 🎛️ **SKHD** - Hotkey Daemon
Powerful hotkey system for window management and system control:

**Window Management:**
- `ctrl+cmd+w` - Toggle fullscreen
- `ctrl+cmd+q` - Float/unfloat window
- `shift+ctrl+alt+hjkl` - Move windows
- `ctrl+alt+cmd+hjkl` - Resize windows

**Workspace Navigation:**
- `ctrl+1-5` - Switch to desktop 1-5
- `shift+alt+1-7` - Move window to desktop
- `shift+alt+p/n` - Move window to prev/next space

### 🦞 **Yabai** - Tiling Window Manager
Binary space partitioning window manager:
- **Layout**: BSP (Binary Space Partitioning)
- **Padding**: Minimal 1px gaps for clean appearance
- **Mouse**: Follows focus with drag-to-move/resize
- **Integration**: Works with SketchyBar (32px external bar)

**Excluded Apps**: System Settings, Calculator, Karabiner-Elements

### 📊 **SketchyBar** - Menu Bar Replacement
Elegant and customizable macOS menu bar:
- **Appearance**: Top position, 40px height, blur effects
- **Font**: MonaspiceRn Nerd Font
- **Modules**: Spaces, front app, clock, volume, battery
- **Integration**: Yabai space indicators with click-to-focus

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
Comprehensive Neovim configuration based on kickstart.nvim:
- **Base**: Adapted from nvim-lua/kickstart.nvim
- **Plugins**: 30+ custom plugins for development
- **Features**: LSP, completion, debugging, AI assistance
- **Themes**: Multiple colorscheme options

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
brew install yabai                          # Tiling window manager
brew install skhd                           # Hotkey daemon
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
brew install tmuxinator                    # Tmux session manager
brew install switchaudio-osx              # Audio source switcher
```

#### Quick Install Script
For convenience, you can install all essential dependencies at once:
```bash
# Essential packages only
brew install --cask ghostty karabiner-elements font-monaspace font-meslo-lg-nerd-font
brew install yabai skhd sketchybar stow starship tmux zsh-fast-syntax-highlighting zsh-autosuggestions fzf fd bat eza zoxide ripgrep nvim git gh yazi sesh jq wget curl

# Optional additions
brew install uv node python kubectl kubectx kubens docker tmuxinator switchaudio-osx
```

### Setup Instructions

1. **Clone the repository:**
   ```bash
   git clone https://github.com/cyperx/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **Install configurations using Stow:**
   ```bash
   # Install GNU Stow if not already installed
   brew install stow

   # Install all configurations at once
   stow */

   # Or install individual components
   stow ghostty
   stow karabiner
   stow nvim
   stow sketchybar
   stow skhd
   stow starship
   stow yabai
   stow tmux
   stow zsh
   ```

3. **Start services:**
   ```bash
   # Start yabai and skhd
   brew services start yabai
   brew services start skhd

   # Start SketchyBar
   brew services start sketchybar

   # Restart shell to load Zsh config
   exec zsh
   ```

4. **Configure permissions:**
   - Grant accessibility permissions to SKHD and Yabai in System Preferences
   - Allow Karabiner-Elements to modify keyboard input
   - Configure Ghostty as default terminal

## ⚙️ Customization

### Starship Themes
Switch between different prompt themes by modifying `~/.zshrc`:
```bash
export STARSHIP_CONFIG=~/.config/starship/starship-gruvbox-dark-neon.toml
# export STARSHIP_CONFIG=~/.config/starship/starship-gruvbox-rainbow.toml
# export STARSHIP_CONFIG=~/.config/starship/starship-jetpack.toml
```

### Ghostty Shaders
Enable visual effects by uncommenting shader lines in `ghostty/config`:
```bash
# Uncomment any of these for visual effects:
# custom-shader = shaders/matrix-hallway.glsl
# custom-shader = shaders/starfield.glsl
# custom-shader = shaders/crt.glsl
```

### Tmux Customization
Modify plugin settings in `.tmux.conf`:
```bash
# Float window settings
set -g @floax-width '80%'
set -g @floax-height '80%'
set -g @floax-bind 'p'
```

## 🎯 Key Bindings Reference

### Window Management (SKHD + Yabai)
| Binding | Action |
|---------|--------|
| `ctrl+cmd+w` | Toggle fullscreen |
| `ctrl+cmd+q` | Float/unfloat window |
| `ctrl+cmd+r` | Balance windows |
| `ctrl+cmd+e` | Toggle split type |
| `shift+ctrl+alt+hjkl` | Move windows |
| `ctrl+alt+cmd+hjkl` | Resize windows |

### Workspace Navigation
| Binding | Action |
|---------|--------|
| `ctrl+1-5` | Switch to desktop |
| `shift+alt+1-7` | Move window to desktop |
| `shift+alt+p/n` | Move to prev/next space |

### Tmux (Prefix: `Ctrl+A`)
| Binding | Action |
|---------|--------|
| `prefix+s` | Split horizontal |
| `prefix+v` | Split vertical |
| `prefix+hjkl` | Navigate panes |
| `prefix+o` | Session manager |
| `prefix+p` | Float terminal |

## 🔍 File Highlights

### Configuration Files
- `ghostty/config` - Terminal appearance and behavior
- `karabiner/karabiner.json` - Keyboard remapping rules
- `skhd/skhdrc` - Hotkey definitions
- `yabai/yabairc` - Window manager settings
- `tmux/.tmux.conf` - Terminal multiplexer setup
- `zsh/.zshrc` - Shell configuration and aliases

### Special Features
- **Ghostty Shaders**: 30+ visual effect shaders in `ghostty/shaders/`
- **SketchyBar Plugins**: Custom status bar modules in `sketchybar/plugins/`
- **Starship Themes**: 6 different prompt configurations
- **Tmux Plugins**: Auto-installing plugin manager with 10+ plugins

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
