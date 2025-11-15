# Dotfiles Documentation Index

> **🎯 Central Documentation Hub**
> Complete documentation for the cyperx dotfiles repository with cross-references and navigation for both human users and AI agents.

## 📖 Documentation Overview

This comprehensive documentation system covers all aspects of the dotfiles repository, from individual component details to cross-tool workflows. Each document is designed to be both human-readable and AI agent-friendly.

---

## 🗂️ Document Structure

### Core Documentation
| Document | Purpose | Best For |
|----------|---------|----------|
| **[📋 COMPONENTS.md](COMPONENTS.md)** | Detailed documentation for all 15+ tools | Understanding each component in depth |
| **[⌨️ KEYBINDS.md](KEYBINDS.md)** | Complete keybindings across all tools | Quick reference and command lookup |
| **[📝 NEOVIM_KEYBINDS.md](NEOVIM_KEYBINDS.md)** | Comprehensive Neovim mappings | Editor workflow mastery |
| **[🔄 WORKFLOW_GUIDES.md](WORKFLOW_GUIDES.md)** | Cross-tool integration patterns | Learning tool combinations |
| **[🔧 MAINTENANCE.md](MAINTENANCE.md)** | Validation and troubleshooting | System reliability and debugging |

### Repository Documentation
| Document | Purpose | Best For |
|----------|---------|----------|
| **[🏠 README.md](../README.md)** | Repository overview and quick start | First-time setup and navigation |
| **[🔄 WM_SWITCHING.md](../WM_SWITCHING.md)** | Window manager switching guide | Switching between Aerospace and Yabai |
| **[🤖 CLAUDE.md](../CLAUDE.md)** | Claude Code specific guidance | AI-assisted development |
| **[👨‍💻 AGENTS.md](../AGENTS.md)** | Development and testing procedures | Contributing and maintenance |

### Strategy & Architecture
| Document | Purpose | Best For |
|----------|---------|----------|
| **[📐 DOCUMENTATION_STRATEGY.md](DOCUMENTATION_STRATEGY.md)** | Documentation approach and principles | Understanding the documentation system |
| **[🏗️ DOCS_WEBSITE_STRUCTURE.md](DOCS_WEBSITE_STRUCTURE.md)** | Website-ready documentation structure | Building a docs website |

---

## 🧭 Navigation by Use Case

### 🆕 New User Journey
1. **[README.md](../README.md)** - Start here for overview and installation
2. **[COMPONENTS.md](COMPONENTS.md)** - Understand what each tool does
3. **[KEYBINDS.md](KEYBINDS.md)** - Learn essential keybindings
4. **[WORKFLOW_GUIDES.md](WORKFLOW_GUIDES.md)** - See how tools work together

### 🔍 Quick Reference
- **Find a keybind**: [KEYBINDS.md](KEYBINDS.md) or [NEOVIM_KEYBINDS.md](NEOVIM_KEYBINDS.md)
- **Understand a tool**: [COMPONENTS.md](COMPONENTS.md)
- **Learn a workflow**: [WORKFLOW_GUIDES.md](WORKFLOW_GUIDES.md)
- **Fix an issue**: [MAINTENANCE.md](MAINTENANCE.md)

### 🤖 AI Agent Usage
- **Understanding user questions**: [CLAUDE.md](../CLAUDE.md#understanding-user-intent)
- **Finding file locations**: [CLAUDE.md](../CLAUDE.md#quick-file-location-reference)
- **Component details**: [COMPONENTS.md](COMPONENTS.md)
- **Command validation**: [MAINTENANCE.md](MAINTENANCE.md#validation-scripts)

### 🛠️ Maintenance & Development
- **System validation**: [MAINTENANCE.md](MAINTENANCE.md#validation-scripts)
- **Troubleshooting**: [MAINTENANCE.md](MAINTENANCE.md#troubleshooting)
- **Development guidelines**: [AGENTS.md](../AGENTS.md)
- **Documentation strategy**: [DOCUMENTATION_STRATEGY.md](DOCUMENTATION_STRATEGY.md)

---

## 🔗 Cross-Reference Map

### Tool Integration Points
```
Window Management: Aerospace (PRIMARY) ↔ SketchyBar
                   Yabai + SKHD (LEGACY) ↔ SketchyBar
Terminal Stack: Ghostty ↔ Tmux ↔ Zsh ↔ Starship
Session Management: Sesh ↔ Tmux ↔ Tmuxinator ↔ FZF
Development: Neovim ↔ Tmux ↔ Git ↔ File Managers
Input: Kanata + Karabiner ↔ All Applications
```

### Documentation Cross-References
- **Keybind mentioned** → Links to [KEYBINDS.md](KEYBINDS.md) or [NEOVIM_KEYBINDS.md](NEOVIM_KEYBINDS.md)
- **Tool mentioned** → Links to [COMPONENTS.md](COMPONENTS.md#component-name)
- **Workflow described** → Links to [WORKFLOW_GUIDES.md](WORKFLOW_GUIDES.md#workflow-name)
- **Issue mentioned** → Links to [MAINTENANCE.md](MAINTENANCE.md#issue-type)
- **File referenced** → Exact path from repository root

---

## 📁 File Location Quick Reference

### Configuration Files
```
zsh/.zshrc                                      # Shell aliases, functions, keybinds
tmux/.tmux.conf                                 # Terminal multiplexer config
nvim/.config/nvim/lua/keymaps.lua              # Neovim core keybinds
aerospace/.config/aerospace/aerospace.toml     # Window manager (PRIMARY)
yabai/.config/yabai/yabairc                    # Window manager (LEGACY)
skhd/.config/skhd/skhdrc                       # Hotkey daemon (LEGACY - for Yabai)
ghostty/.config/ghostty/config                 # Terminal emulator settings
sesh/.config/sesh/sesh.toml                    # Session management config
sketchybar/.config/sketchybar/sketchybarrc     # Menu bar config
```

### Scripts & Utilities
```
sesh list                                # Sesh session validation (manual)
~/.config/sketchybar/test_sketchybar.sh  # SketchyBar testing
~/.config/sketchybar/debug_sketchybar.sh # SketchyBar debugging
tmux/.tmux/scripts/                      # Session management scripts (11 files)
```

### Plugin Directories
```
nvim/.config/nvim/lua/custom/plugins/    # Neovim plugin configs (45 files)
sketchybar/.config/sketchybar/plugins/   # SketchyBar plugins (69 scripts)
```

---

## 🎯 Quick Access Commands

### Validation & Health Checks
```bash
sesh list                                # Sesh session validation (manual check)
~/.config/sketchybar/test_sketchybar.sh   # Test SketchyBar plugins
~/.config/sketchybar/plugin_health_monitor.sh test  # Plugin health check
```

### Service Management
```bash
killall AeroSpace && open -a AeroSpace    # Restart window manager (PRIMARY)
brew services restart sketchybar          # Restart menu bar
sketchybar --reload                       # Reload SketchyBar config

# Legacy (if using Yabai instead of Aerospace):
# brew services restart yabai && brew services restart skhd
```

### Documentation Navigation
```bash
# Open documentation in default editor
nvim ~/dotfiles/docs/KEYBINDS.md         # Keybinds reference
nvim ~/dotfiles/docs/COMPONENTS.md       # Component guide
nvim ~/dotfiles/docs/WORKFLOW_GUIDES.md  # Workflow patterns
nvim ~/dotfiles/docs/MAINTENANCE.md      # Maintenance guide
```

---

## 📊 Documentation Metrics

### Coverage
- **Components Documented**: 15+ tools with detailed descriptions
- **Keybinds Catalogued**: 200+ keybinds and aliases across all tools
- **Workflows Described**: 10+ common integration patterns
- **Validation Scripts**: 5+ automated testing procedures

### Structure
- **Human Readable**: Clear explanations, examples, troubleshooting
- **Agent Readable**: Structured data, file references, command listings
- **Cross-Referenced**: Every component links to related documentation
- **Searchable**: Consistent formatting and clear section headers

---

## 🚀 Getting Started Paths

### Path 1: Quick Setup
1. [README.md](../README.md) → Installation
2. [KEYBINDS.md](KEYBINDS.md) → Essential commands
3. Start using the system

### Path 2: Deep Understanding
1. [README.md](../README.md) → Overview
2. [COMPONENTS.md](COMPONENTS.md) → Understand each tool
3. [WORKFLOW_GUIDES.md](WORKFLOW_GUIDES.md) → Learn integrations
4. [KEYBINDS.md](KEYBINDS.md) → Master all commands

### Path 3: Maintenance Focus
1. [MAINTENANCE.md](MAINTENANCE.md) → Validation procedures
2. [COMPONENTS.md](COMPONENTS.md) → Understand what to maintain
3. [AGENTS.md](../AGENTS.md) → Development guidelines

### Path 4: AI Agent Onboarding
1. [CLAUDE.md](../CLAUDE.md) → Agent-specific guidelines
2. [COMPONENTS.md](COMPONENTS.md) → System understanding
3. [KEYBINDS.md](KEYBINDS.md) → Command reference
4. [WORKFLOW_GUIDES.md](WORKFLOW_GUIDES.md) → Integration patterns

---

## 💡 Tips for Effective Usage

### For Humans
- **Bookmark frequently used sections** in your editor
- **Use search within documents** to find specific commands
- **Follow cross-references** to understand tool relationships
- **Check MAINTENANCE.md first** when something isn't working

### For AI Agents
- **Start with CLAUDE.md** for context and guidelines
- **Use exact file paths** when referencing configurations
- **Follow the cross-reference system** for comprehensive answers
- **Reference validation scripts** for testing changes

---

*This documentation index serves as the central hub for navigating the complete dotfiles documentation system. All documents are designed to work together as a cohesive knowledge base for both human users and AI agents.*