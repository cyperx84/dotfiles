# Neovim Configuration

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

A comprehensive, AI-powered Neovim configuration built on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) with extensive customizations for modern development workflows.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Core Keybindings](#core-keybindings)
- [Plugin Categories](#plugin-categories)
- [AI Assistance](#ai-assistance)
- [Git Workflows](#git-workflows)
- [File Navigation](#file-navigation)
- [Obsidian Integration](#obsidian-integration)
- [Session Management](#session-management)
- [Configuration Structure](#configuration-structure)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)

## Overview

**Stats at a Glance:**
- 68 plugins managed by lazy.nvim
- 100+ custom keybindings with mnemonic grouping
- 4 AI assistants (CodeCompanion, Claude Code, Copilot, Supermaven)
- 6 git integration plugins
- 4 file explorer options
- 15+ language formatters via conform.nvim
- Deep Obsidian.nvim integration for note-taking

**Architecture:**
- **Plugin Manager:** lazy.nvim (aggressive lazy-loading)
- **Foundation:** kickstart.nvim patterns + extensive customizations
- **Configuration:** Modular Lua structure (42 plugin files)
- **Philosophy:** AI-first, keyboard-driven, multiple workflow options

## Features

### Development
- LSP support for Lua, C/C++, Python, Rust
- Auto-formatting on save (15+ languages)
- Treesitter syntax highlighting
- DAP debugging (Go configured)
- Code folding with LSP + indent fallback

### AI-Powered Coding
- **CodeCompanion:** Chat interface with 4 AI providers (DeepSeek default)
- **Claude Code:** Terminal integration with model switching
- **Copilot:** Inline suggestions
- **MCPHub:** Tool and resource integration

### Git Integration
- **Neogit:** Full-featured git UI
- **Gitsigns:** Inline change indicators and hunk operations
- **Git Worktrees:** Telescope-integrated worktree management
- **Diffview:** Side-by-side diff viewing

### File Navigation
- **Oil.nvim:** Edit filesystem like a buffer (primary)
- **Yazi:** TUI file manager integration
- **Telescope:** Fuzzy finding for files, grep, buffers
- **Harpoon:** Lightning-fast file marking and jumping

### UI/UX
- Tokyo Night Storm colorscheme with transparency
- Custom lualine with mode-based colors
- Markdown rendering with colored headers (H1-H6)
- Smooth cursor animations (smear-cursor)
- Snacks.nvim dashboard with session shortcuts

### Note-Taking
- Deep Obsidian.nvim integration (wiki-links, backlinks, daily notes)
- Live markdown rendering with custom highlighting
- Image paste and inline rendering
- Auto-sync with Obsidian app via iCloud

## Installation

### Prerequisites

```bash
# Required
brew install neovim git ripgrep fd

# For Telescope
brew install fzf

# For LSP/formatters (auto-installed via Mason)
# lua_ls, clangd, pyright, rust_analyzer, stylua, etc.

# Optional but recommended
brew install yazi               # TUI file manager
brew install --cask ghostty     # Terminal (native integration)

# For image rendering in markdown
brew install imagemagick        # Via luarocks in config
```

### Install Configuration

```bash
# Using GNU Stow (if in dotfiles repo)
cd ~/dotfiles
stow nvim

# Or manual installation
git clone <your-repo> ~/.config/nvim

# Launch Neovim - plugins will auto-install
nvim
```

On first launch:
1. lazy.nvim will install automatically
2. All plugins will be installed (may take 2-3 minutes)
3. Treesitter parsers will auto-install on file open
4. LSP servers will be suggested for installation via Mason

### Post-Installation

```bash
# Install LSP servers (via Mason in Neovim)
:MasonInstall lua-language-server clangd pyright rust-analyzer

# Install formatters
:MasonInstall stylua prettier

# Check health
:checkhealth
```

## Quick Start

### Essential Keybindings

| Key | Action | Context |
|-----|--------|---------|
| `Space` | Leader key | All modes |
| `-` | Open Yazi file manager | Normal |
| `Ctrl+e` | Toggle Oil explorer | Normal |
| `Alt+c` | Toggle CodeCompanion chat | Normal |
| `Alt+;` | Toggle Claude Code | Normal |
| `Alt+a` | Harpoon mark file | Normal |
| `<leader>sf` | Search files (Telescope) | Normal |
| `<leader>sg` | Live grep (Telescope) | Normal |
| `<leader>gg` | Open Neogit | Normal |

### First Steps

1. **Open Dashboard:** Start Neovim to see the dashboard
2. **Search Files:** `<leader>sf` to fuzzy find files
3. **Open File Explorer:** `Ctrl+e` for Oil or `-` for Yazi
4. **Start Coding:** Open a file, LSP will auto-start
5. **Format Code:** `<leader>l` to format current file
6. **Get AI Help:** `Alt+c` for CodeCompanion chat

## Core Keybindings

### Leader Key: `Space`

All leader-based keybindings use Space as the prefix. Which-key.nvim provides instant visual guidance.

### Navigation

| Key | Action |
|-----|--------|
| `Ctrl+h/j/k/l` | Navigate between splits/tmux panes |
| `Ctrl+d/u` | Scroll half-page down/up (centered) |
| `n/N` | Next/previous search result (centered) |
| `Esc` | Clear search highlight |
| `]c` / `[c` | Next/previous git hunk |

### Window Management

| Key | Action |
|-----|--------|
| `Ctrl+h/j/k/l` | Switch to left/down/up/right window |
| Navigation works seamlessly with tmux panes |

### Editing

| Key | Action |
|-----|--------|
| `jk` | Exit insert mode |
| `Y` | Yank to end of line |
| `==` | Select all text |
| `J` | Join lines (keep cursor position) |
| `<leader>y/Y` | Yank to system clipboard |
| `<leader>D` | Delete to void register (don't overwrite clipboard) |
| `v` then `p` | Paste without overwriting register |

### File Explorers

| Key | Action |
|-----|--------|
| `Ctrl+e` | Toggle Oil float (at current file) |
| `Ctrl+Alt+e` | Toggle Oil float (at cwd) |
| `-` | Open Yazi (at parent directory) |
| `<leader>ew` | Open Yazi (at cwd) |

#### Oil.nvim (in explorer)

| Key | Action |
|-----|--------|
| `L` or `l` | Navigate into directory |
| `H` or `h` | Navigate to parent |
| `g.` | Toggle hidden files |
| `=` | Synchronize changes |
| `q` | Close explorer |

#### Yazi (in explorer)

| Key | Action |
|-----|--------|
| `Ctrl+v/x/t` | Open in split/horizontal/tab |
| `Ctrl+s` | Grep in directory |
| `Ctrl+g` | Replace in directory |
| `Ctrl+y` | Copy relative path |
| `Ctrl+q` | Send to quickfix |

### Code Actions

| Key | Action |
|-----|--------|
| `gd` | Go to definition (Telescope) |
| `gr` | Go to references (Telescope) |
| `gI` | Go to implementation |
| `gD` | Go to declaration |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>l` | Format file/range |
| `<leader>D` | Type definition |
| `<leader>th` | Toggle inlay hints |

### Diagnostics

| Key | Action |
|-----|--------|
| `[d` / `]d` | Previous/next diagnostic |
| `<leader>e` | Show diagnostic message |
| `<leader>q` | Open diagnostic list |
| `<leader>dq` | Diagnostics to quickfix |

### Search (Telescope)

All search commands use `<leader>s` prefix:

| Key | Action |
|-----|--------|
| `<leader>sf` | Search files |
| `<leader>sg` | Live grep |
| `<leader>sw` | Search current word |
| `<leader>sh` | Search help tags |
| `<leader>sk` | Search keymaps |
| `<leader>ss` | Select Telescope picker |
| `<leader>sr` | Resume last search |
| `<leader>s.` | Recent files |
| `<leader><leader>` | Find buffers |
| `<leader>/` | Fuzzy search current buffer |
| `<leader>sn` | Search Neovim config |

### Buffer Management

| Key | Action |
|-----|--------|
| `<leader>bq` | Close buffer |
| `<leader>bw` | Close buffer, retain split |
| `<leader>bd` | Buffer delete (Snacks) |
| `<leader>ba` | Buffer delete all |
| `<leader>bo` | Buffer delete other |

### Quickfix & Location Lists

| Key | Action |
|-----|--------|
| `<leader>qn/qp` | Next/previous quickfix item |
| `<leader>ln/lp` | Next/previous location item |

## Plugin Categories

### LSP & Language Support

**nvim-lspconfig** with Mason ecosystem
- **Servers:** lua_ls, clangd, pyright, rust_analyzer
- **Features:** Auto-completion, diagnostics, go-to-definition, hover docs
- **Progress:** Fidget.nvim shows LSP loading status

**nvim-treesitter**
- **Parsers:** JavaScript, TypeScript, C, Lua, Go, Rust, Ruby, Markdown, YAML, etc.
- **Features:** Syntax highlighting, smart indentation, text objects

**conform.nvim** (Formatting)
- **Supported:** Lua (stylua), JS/TS (prettier), Python (black), Rust (rustfmt), Go (gofmt), Markdown, YAML, TOML, Shell, XML
- **Keymap:** `<leader>l` - Format file or range (1000ms timeout)

### Completion

**blink.cmp** (Rust-based completion engine)
- **Sources:** LSP, path, snippets, buffer
- **Features:** Fast, minimal UI, auto-documentation
- **Integration:** CodeCompanion per-filetype source

**nvim-autopairs**
- Auto-close brackets, quotes, parens
- Integrates with blink.cmp

### Fuzzy Finding

**telescope.nvim**
- **Extensions:** fzf-native, ui-select, git-worktree
- **Layout:** Flexible (auto-switches at 100 columns)
- **Ignore:** .git, node_modules, .cache, .obsidian

**fzf-lua**
- Used by Claude Code history integration

### File Explorers

**Oil.nvim** (Primary - Active)
- Edit filesystem like a buffer
- Delete to trash, LSP file operations
- Natural sorting, hidden file toggle
- Float mode with rounded borders

**Yazi.nvim**
- Full TUI file manager
- Grep and replace in directories
- Quickfix integration
- Multi-tab support

**Mini.files** (Miller columns)
- Three-column view (parent/current/preview)
- Vim-like navigation

**Neo-tree** (Available)
- Classic tree view
- Command: `:Neotree`

### Git Integration

**Neogit** (Primary UI)
- Comprehensive staging and committing
- Branch management
- Diffview integration
- Float and split modes

**gitsigns.nvim**
- Inline change indicators (+/~/-)
- Hunk staging and preview
- Line blame
- Navigation: `]c` / `[c`

**Mini.diff**
- Sign column diff overlay
- Toggle: `<leader>td`

**git-worktree.nvim**
- Telescope picker for worktrees
- Create: `<leader>gW`
- Switch: `<leader>gt`

**vim-fugitive**
- Classic Git commands
- `:Git` interface

**diffview.nvim**
- Side-by-side diff viewing
- Integration with Neogit

## AI Assistance

### CodeCompanion (Primary AI Interface)

**Providers:** 4 AI services configured
- **DeepSeek** (default) - Budget-friendly
- **Anthropic** (Claude Sonnet 4) - High quality
- **OpenAI** (GPT-4o-mini) - Fast
- **Gemini** (2.0-flash-exp) - Alternative

**Chat Interface:**
- Position: Left vertical split (60 cols × 50 lines)
- Start mode: Normal (not insert)

#### CodeCompanion Keybindings

| Key | Action | Mode |
|-----|--------|------|
| `Alt+c` | Toggle chat | Normal |
| `<leader>CC` | CodeCompanion menu | Normal |
| `<leader>Cc` | CodeCompanion actions | Normal |
| `<leader>Ca` | Add buffer/selection to chat | Normal/Visual |
| `Ctrl+Enter` | Send message | Chat (insert) |
| `Ctrl+s` | Send message | Chat (normal) |
| `Ctrl+x` | Trigger completion | Chat |
| `gw` | Watch buffer | Chat |
| `gp` | Pin context | Chat |
| `Ctrl+b` | /buffer slash command | Chat |
| `Ctrl+f` | /fetch slash command | Chat |
| `Ctrl+i` | /image (visual mode) | Chat |

**Features:**
- MCPHub integration (tools, resources, prompts)
- Image support from ~/Documents/Screenshots
- Persistent chat history
- Context pinning and buffer watching

### Claude Code (Terminal AI)

AI-powered terminal integration with model switching.

#### Claude Code Keybindings

| Key | Action | Provider |
|-----|--------|----------|
| `Alt+;` | Toggle Claude Code | Anthropic |
| `Alt+'` | Toggle Claude Code | DeepSeek |
| `<leader>cf` | Focus Claude window | - |
| `<leader>cm` | Select model | - |
| `<leader>cr` | Resume session | - |
| `<leader>cC` | Continue session | - |
| `<leader>cb` | Add current buffer | - |
| `<leader>cs` | Send selection | - |
| `<leader>ca` | Add file from tree | - |
| `<leader>cc` | Open Claude Code | - |
| `<leader>cq` | Quit Claude Code | - |
| `<leader>ch` | View history (fzf) | - |

**Features:**
- Terminal: Right split, 35% width
- Git root detection for CWD
- DeepSeek API integration via environment variables
- Auto-reload buffers on external changes
- Fixed terminal width (60 columns)

### Copilot (Inline Suggestions)

**Keybindings:**
- `Ctrl+Alt+l` - Accept suggestion
- `Alt+]` / `Alt+[` - Next/previous suggestion
- `Ctrl+]` - Dismiss

**Configuration:**
- Auto-trigger enabled (75ms debounce)
- Disabled for: YAML, Markdown, help, git commits

### MCPHub Integration

**Features:**
- Tools and resources from MCP servers
- Integration with CodeCompanion
- Variables from resources
- Slash commands from prompts

**Keybindings:**
- `<leader>m` - Open MCPHub UI

**Configuration:**
- Port: 37373
- Config: ~/.config/mcphub/servers.json
- Auto-approve in CodeCompanion

## Git Workflows

### Daily Git Workflow

1. **Check Status:** `<leader>gg` (Neogit float)
2. **View Changes:** Navigate in Neogit, press `Tab` to see diff
3. **Stage Hunks:**
   - Option A: `<leader>hs` (individual hunks via gitsigns)
   - Option B: `s` in Neogit on file/hunk
4. **Commit:** `c` in Neogit, write message, `Ctrl+c` twice to confirm
5. **Push:** `<leader>gP` or `P` in Neogit

### Inline Change Management

```
Navigate changes: ]c (next) / [c (previous)
Preview hunk: <leader>hp
Stage hunk: <leader>hs
Reset hunk: <leader>hr
Stage buffer: <leader>hS
Undo stage: <leader>hu
Blame line: <leader>hb
Diff: <leader>hd (index) / <leader>hD (last commit)
Toggle blame: <leader>tb
Toggle diff overlay: <leader>td
```

### Git Worktrees

**Use Case:** Work on multiple branches simultaneously without stashing.

```bash
# Create new worktree
<leader>gW

# Switch between worktrees
<leader>gt  # Opens Telescope picker
```

### Branch Management (Neogit)

```
In Neogit:
  b - Branch menu
    b - Checkout branch
    c - Create branch
    d - Delete branch
    r - Rename branch

  l - Log menu
    l - Current branch
    o - Other branches

  m - Merge menu
```

## File Navigation

### Quick Switching with Harpoon

**Philosophy:** Mark 4-8 frequently used files for instant access.

```
Mark current file: Alt+a
Toggle menu: Alt+e

Jump to marks:
  Alt+j - File 1
  Alt+k - File 2
  Alt+l - File 3
  Alt+h - File 4
  Alt+g - File 5
  Alt+f - File 6
  Alt+d - File 7
  Alt+s - File 8
```

**Workflow:**
1. Open project
2. Mark main files (e.g., config, main logic, tests, docs)
3. Jump instantly with Alt+[key]

### File Browsing with Oil

**Philosophy:** Edit filesystem like a text buffer.

```bash
# Open Oil
Ctrl+e              # Float at current file location
Ctrl+Alt+e          # Float at current working directory

# In Oil buffer
l / Enter           # Open file or enter directory
h / -               # Go to parent directory
g.                  # Toggle hidden files
d                   # Delete (to trash)
_                   # Open in new split
=                   # Apply changes
q                   # Close

# Edit like text
dd                  # Cut file
yy                  # Copy file
p                   # Paste file
cc                  # Rename file (change text)
```

**Advanced:**
- Create files: Add line with filename, press `=`
- Create directories: Add line ending with `/`, press `=`
- Batch operations: Use visual mode, then `=`

### File Browsing with Yazi

**Philosophy:** Full-featured TUI file manager.

```bash
# Open Yazi
-                   # Open at parent directory
<leader>ew          # Open at cwd
Ctrl+Up             # Resume last session

# In Yazi
Enter               # Open file
Ctrl+v              # Open in vertical split
Ctrl+x              # Open in horizontal split
Ctrl+t              # Open in new tab
Ctrl+s              # Grep in directory
Ctrl+g              # Replace in directory
Ctrl+y              # Copy relative path
Ctrl+q              # Send to quickfix
Tab                 # Cycle open buffers
```

### Telescope Fuzzy Finding

```bash
# Files
<leader>sf          # All files (respects .gitignore)
<leader>s.          # Recent files
<leader><leader>    # Open buffers

# Content
<leader>sg          # Live grep (search in files)
<leader>sw          # Search word under cursor
<leader>/           # Fuzzy search current buffer

# Special
<leader>sn          # Search Neovim config files
<leader>sh          # Search help tags
<leader>sk          # Search keymaps
```

**Telescope Navigation:**
- `Ctrl+j/k` - Move down/up in results
- `Ctrl+n/p` - Next/previous (alternative)
- `Ctrl+u/d` - Scroll preview up/down
- `?` - Show which-key help in picker

## Obsidian Integration

### Setup

**Vault Location:** `~/Library/Mobile Documents/iCloud~md~obsidian/Documents/notes`

**Daily Notes:**
- Folder: `_inbox`
- Default tags: `#type/fleeting-note`

**Link Style:** Wiki-style `[[links]]`

### Obsidian Keybindings

All Obsidian commands use `<leader>o` prefix:

| Key | Action | Mode |
|-----|--------|------|
| `<leader>on` | New note | Normal |
| `<leader>oo` | Open in Obsidian app | Normal |
| `<leader>of` | Quick switch note | Normal |
| `<leader>os` | Search notes | Normal |
| `<leader>ob` | Backlinks | Normal |
| `<leader>ol` | Links | Normal |
| `<leader>ot` | Tags | Normal |
| `<leader>od` | Today's daily note | Normal |
| `<leader>oy` | Yesterday's daily | Normal |
| `<leader>om` | Tomorrow's daily | Normal |
| `<leader>oF` | Follow link under cursor | Normal |
| `<leader>oi` | Paste image | Normal |
| `<leader>or` | Rename note | Normal |
| `<leader>ow` | Workspace switcher | Normal |
| `<leader>ox` | Table of contents | Normal |
| `<leader>oc` | Toggle checkbox | Normal/Visual |
| `<leader>oe` | Extract note | Visual |
| `<leader>oL` | Link selection | Visual |
| `<leader>oln` | Link to new note | Visual |
| `gf` | Follow link | Normal |
| `Enter` | Smart action (follow/toggle) | Normal |

### Daily Note Workflow

```bash
# Morning capture
<leader>od          # Open today's daily note
# Write fleeting thoughts, meeting notes, TODOs

# Link to existing notes
[[Note Title]]      # Wiki-style link
<leader>oL          # Link selected text (visual mode)

# Check tasks
<leader>oc          # Toggle checkbox

# Navigate
gj / gk             # Jump between headers
<leader>ob          # View backlinks
gf or Enter         # Follow link under cursor
```

### Note Organization

```bash
# Create structured notes
<leader>on          # New note (prompted for title)
# Add frontmatter: tags, id, aliases

# Refactor fleeting notes
<leader>oe          # Extract visual selection to new note

# Link management
<leader>ol          # View all links in note
<leader>ob          # View all backlinks to note
<leader>oln         # Create link to new note (visual)
```

### Tags & Search

```bash
# Add tags in note
#type/fleeting-note
#type/permanent-note
#type/literature-note
#status/active
#status/archived
#project/dotfiles
#area/development

# Search
<leader>os          # Full-text search notes
<leader>ot          # Search by tags
<leader>of          # Quick switch (fuzzy file names)
```

### Image Handling

```bash
<leader>oi          # Paste image from clipboard
                    # Saves to vault, inserts markdown link

# Images render inline (kitty backend)
# Toggle rendering: <leader>tm
```

### Markdown Rendering

**Headers (colored H1-H6):**
- H1: Red
- H2: Yellow
- H3: Green
- H4: Purple
- H5: Cyan
- H6: Pink

**Code Blocks:**
- Dark background (#121212)
- Thin borders
- Language indicator

**Features:**
- Live rendering as you type
- Conceallevel: 2 (hides markup characters)
- Custom padding (2 left/right)
- Min width: 80 characters

**Toggle:** `<leader>tm` - Toggle markdown rendering

### Obsidian Sync

**Bi-directional sync:**
- Edit in Neovim → Auto-syncs to iCloud → Obsidian app sees changes
- Edit in Obsidian app → iCloud syncs → Neovim auto-reloads on focus

**Auto-reload triggers:**
- FocusGained
- BufEnter
- CursorHold

## Session Management

### Mini.sessions Integration

**Session Directory:** `~/.local/share/nvim/sessions/`

**Features:**
- Auto-save on session switch/quit
- Named sessions
- Dashboard shortcuts

### Session Keybindings

| Key | Action |
|-----|--------|
| `<leader>Ss` | Save session (prompts for name) |
| `<leader>Sl` | Load session (picker) |
| `<leader>Sr` | Restore session (by name) |
| `<leader>Sx` | Delete session |
| `<leader>Sw` | Write current session |
| `<leader>Sn` | Open "notes" session |
| `<leader>Sd` | Open "dotfiles" session |
| `<leader>Sc` | Open "code" session |
| `<leader>Sh` | Return to dashboard |

### Session Workflow

```bash
# First time in project
nvim                # Dashboard appears
<leader>Ss          # Save session with project name

# Quick project sessions
<leader>Sn          # Switch to notes (Obsidian vault)
<leader>Sd          # Switch to dotfiles
<leader>Sc          # Switch to code project

# Daily workflow
<leader>Sl          # Load session picker
# Select project
# Work on files
# Auto-saves on quit

# Return to launcher
<leader>Sh          # Dashboard with session shortcuts
```

### Dashboard

**Snacks Dashboard** - Custom Neovim logo

**Shortcuts:**
- `s` - Search files
- `n` - New file
- `g` - Find text
- `r` - Recent files
- `c` - Config
- `e` - Restore session
- `l` - Lazy (plugin manager)
- `q` - Quit

## Configuration Structure

```
nvim/.config/nvim/
├── init.lua                              # Entry point
├── lazy-lock.json                        # Plugin version lock
├── README.md                             # This file
└── lua/
    ├── options.lua                       # Core Neovim settings
    ├── keymaps.lua                       # Global keybindings (195 lines)
    ├── autocmds.lua                      # Autocommands
    ├── lazy-bootstrap.lua                # lazy.nvim setup
    ├── lazy-plugins.lua                  # Plugin loader
    └── custom/
        └── plugins/                      # 42 plugin configs
            ├── ai/                       # AI assistants
            │   ├── codecompanion.lua
            │   ├── claudecode.lua
            │   ├── copilot.lua
            │   └── supermaven.lua
            ├── completion/               # Completion engine
            │   └── blink.lua
            ├── editor/                   # Editing enhancements
            │   ├── autopairs.lua
            │   ├── harpoon.lua
            │   ├── mini.lua
            │   ├── navigator.lua
            │   ├── todo-comments.lua
            │   └── ufo.lua
            ├── file-explorer/            # File navigation
            │   ├── oil.lua
            │   ├── yazi.lua
            │   ├── mini-files.lua
            │   └── neo-tree.lua
            ├── git/                      # Git integration
            │   ├── neogit.lua
            │   ├── gitsigns.lua
            │   ├── mini-diff.lua
            │   ├── fugitive.lua
            │   └── git-worktree.lua
            ├── lsp/                      # Language servers
            │   ├── lspconfig.lua
            │   ├── conform.lua
            │   ├── lazydev.lua
            │   └── treesitter.lua
            ├── markdown/                 # Note-taking
            │   ├── obsidian.lua
            │   ├── render-markdown.lua
            │   ├── markdown-preview.lua
            │   └── image.lua
            ├── search/                   # Fuzzy finding
            │   ├── telescope.lua
            │   └── fzf.lua
            ├── ui/                       # Appearance
            │   ├── tokyonight.lua
            │   ├── lualine.lua
            │   ├── transparent.lua
            │   ├── snacks.lua
            │   ├── noice.lua
            │   └── indent-blankline.lua
            └── debug/                    # Debugging
                ├── nvim-dap.lua
                └── nvim-dap-go.lua
```

### Core Files

**init.lua**
```lua
-- Sets leader keys (Space)
-- Enables Nerd Font
-- Loads modules in order:
--   1. options.lua
--   2. keymaps.lua
--   3. autocmds.lua
--   4. lazy-bootstrap.lua
--   5. lazy-plugins.lua
```

**options.lua** - Core settings
- Line numbers (relative + absolute)
- Clipboard (system integration)
- Search (smart case-insensitive)
- UI (cursorline, signcolumn, scrolloff)
- Splits (right and below)
- Undo (persistent undofile)

**keymaps.lua** - Global keybindings
- 195 lines of custom mappings
- Organized by category
- Buffer-local LSP keymaps
- Plugin-specific bindings

**autocmds.lua** - Autocommands
- Markdown navigation (gj/gk headers)
- Yank highlight
- File watchers for auto-reload

### Plugin Loading Pattern

All plugins use lazy.nvim with these patterns:

```lua
-- Lazy-load by filetype
{
  'plugin/name',
  ft = { 'markdown', 'lua' }
}

-- Lazy-load by command
{
  'plugin/name',
  cmd = { 'CommandName' }
}

-- Lazy-load by keymap
{
  'plugin/name',
  keys = {
    { '<leader>x', '<cmd>Command<cr>', desc = 'Description' }
  }
}

-- Lazy-load by event
{
  'plugin/name',
  event = 'VeryLazy'  -- or 'BufRead', 'InsertEnter', etc.
}

-- Priority loading (colorschemes, core UI)
{
  'plugin/name',
  priority = 1000
}
```

## Customization

### Adding a New Plugin

1. Create file in appropriate category:
   ```bash
   nvim lua/custom/plugins/category/plugin-name.lua
   ```

2. Return plugin spec:
   ```lua
   return {
     'author/plugin-name',
     config = function()
       require('plugin-name').setup({
         -- your config
       })
     end,
   }
   ```

3. Restart Neovim - lazy.nvim auto-discovers new files

### Changing Colorscheme

Edit `lua/custom/plugins/ui/tokyonight.lua`:

```lua
-- Change variant
opts = {
  style = 'night',  -- or 'storm', 'day', 'moon'
}
```

Or install alternative:
```lua
-- Create lua/custom/plugins/ui/gruvbox.lua
return {
  'ellisonleao/gruvbox.nvim',
  priority = 1000,
  config = function()
    vim.cmd.colorscheme('gruvbox')
  end,
}
```

### Adding LSP Server

Edit `lua/custom/plugins/lsp/lspconfig.lua`:

```lua
-- Add to servers table
local servers = {
  gopls = {},  -- Add Go language server
  lua_ls = {
    -- existing config
  },
}
```

Install via Mason: `:MasonInstall gopls`

### Custom Keybindings

Edit `lua/keymaps.lua`:

```lua
-- Add after existing keymaps
vim.keymap.set('n', '<leader>x', '<cmd>YourCommand<cr>',
  { desc = 'Your description' })
```

Or add to plugin config:
```lua
{
  'plugin/name',
  keys = {
    { '<leader>x', '<cmd>Command<cr>', desc = 'Description' },
  },
}
```

### Disabling Plugins

Lazy-load plugins can be disabled with `enabled = false`:

```lua
return {
  'plugin/name',
  enabled = false,
}
```

Or delete the plugin file and restart Neovim.

### Adjusting AI Providers

Edit `lua/custom/plugins/ai/codecompanion.lua`:

Change default adapter:
```lua
opts = {
  adapters = {
    anthropic = function() -- Change to your preferred
      return require('codecompanion.adapters').extend('anthropic', {
        -- config
      })
    end,
  },
  display = {
    diff = {
      provider = 'anthropic',  -- Change default here
    },
  },
}
```

Add API keys via `pass` command:
```bash
pass ai/deepseek
pass ai/anthropic
pass ai/openai
pass ai/gemini
```

## Troubleshooting

### LSP Not Starting

1. Check if server is installed:
   ```vim
   :Mason
   ```

2. Check LSP status:
   ```vim
   :LspInfo
   ```

3. Restart LSP:
   ```vim
   :LspRestart
   ```

4. Check logs:
   ```vim
   :lua vim.cmd('e ' .. vim.lsp.get_log_path())
   ```

### Plugins Not Loading

1. Check lazy.nvim status:
   ```vim
   :Lazy
   ```

2. Update plugins:
   ```vim
   :Lazy sync
   ```

3. Clear plugin cache:
   ```vim
   :Lazy clear
   ```

4. Check for errors:
   ```vim
   :Lazy log
   ```

### Telescope Errors

**Issue:** `rg: command not found`
```bash
brew install ripgrep
```

**Issue:** Slow search in large directories
```lua
-- Add to Telescope config
defaults = {
  file_ignore_patterns = { 'node_modules', '.git' }
}
```

### Oil.nvim Errors

**Issue:** Trash not working
```bash
# macOS
brew install trash

# Check trash command
which trash
```

### CodeCompanion API Errors

**Issue:** Authentication failed
```bash
# Check API keys
pass ai/deepseek
pass ai/anthropic

# Test API
curl -H "Authorization: Bearer $(pass ai/anthropic)" \
  https://api.anthropic.com/v1/messages
```

**Issue:** Rate limit exceeded
- Switch to different provider:
  ```vim
  :CodeCompanion adapter anthropic  " Change to openai, gemini, etc.
  ```

### Obsidian Sync Issues

**Issue:** Notes not syncing
1. Check iCloud path:
   ```vim
   :lua print(vim.fn.expand('~/Library/Mobile Documents/iCloud~md~obsidian/Documents/notes'))
   ```

2. Verify Obsidian vault location matches

**Issue:** Images not rendering
- Requires kitty terminal with image protocol
- Alternative: Use markdown-preview for browser viewing

### Performance Issues

**Issue:** Slow startup
1. Profile startup time:
   ```bash
   nvim --startuptime startup.log
   ```

2. Check which plugins load on startup (should be minimal)

3. Ensure lazy-loading is configured

**Issue:** Large file handling
- Snacks.nvim bigfile detection should auto-disable features
- Manually disable treesitter:
  ```vim
  :TSDisable highlight
  ```

### Debugging Configuration

Enable debug logging:

```lua
-- Add to init.lua temporarily
vim.lsp.set_log_level("debug")
```

Check Neovim health:
```vim
:checkhealth
:checkhealth telescope
:checkhealth treesitter
:checkhealth lspconfig
```

### Common Error Messages

**"No LSP server found"**
- Install server via Mason: `:MasonInstall <server-name>`

**"Clipboard not working"**
- macOS: Should work by default
- Check: `vim.opt.clipboard = 'unnamedplus'` in options.lua

**"Treesitter parser not found"**
- Install parser: `:TSInstall <language>`

**"Which-key timeout"**
- Normal behavior - shows after 300ms
- Adjust in which-key config if needed

## Additional Resources

### Documentation

- [Neovim Docs](https://neovim.io/doc/)
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
- [Lua Guide](https://learnxinyminutes.com/docs/lua/)

### Plugin Specific

- [CodeCompanion](https://github.com/olimorris/codecompanion.nvim)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [Obsidian.nvim](https://github.com/epwalsh/obsidian.nvim)
- [Neogit](https://github.com/NeogitOrg/neogit)

### Community

- [r/neovim](https://reddit.com/r/neovim)
- [Neovim Discourse](https://neovim.discourse.group/)

---

## Credits

**Built on:**
- [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) - Foundation and patterns
- [lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin management
- [Tokyo Night](https://github.com/folke/tokyonight.nvim) - Colorscheme

**Maintained by:** cyperx

**Last Updated:** 2025-10-28

---

**Philosophy:** This configuration balances power-user features with thoughtful defaults. It provides multiple ways to accomplish tasks (Oil vs Yazi, Telescope vs Harpoon) allowing you to choose the workflow that fits your style. The AI integrations (CodeCompanion, Claude Code, Copilot) make this a modern AI-assisted development environment while maintaining traditional Vim efficiency.
