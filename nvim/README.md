---
id: neovim-config
tags:
  - neovim
  - editor
  - lua
---

# 👾 Neovim Configuration

A comprehensive, modern Neovim setup with 68 plugins, 100+ keybindings, and seamless AI integration. Built with Lua using Lazy.nvim, optimized for cross-platform use on macOS and Linux.

```
   ▄███▓██▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█▓███▄
  ▄███▀                          ▀███▄
 ▄██▀  N E O V I M  C O N F I G  ▀██▄
█▀                                  ▀█
█  A Powerful Development Environment  █
█  for Coding, Writing, and AI Work    █
█▄                                  ▄█
 ▀██▄  Modern • Fast • AI-Ready    ▄██▀
  ▀███▄                          ▄███▀
   ▀███▓██▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█▓███▀
```

## 🎯 Quick Stats

| Metric | Count |
|--------|-------|
| **Total Plugins** | 68 |
| **Plugin Config Files** | 45 |
| **Keybindings** | 100+ |
| **LSP Servers** | 4 configured |
| **Treesitter Languages** | 18 installed |
| **Supported Formatters** | 12+ |
| **AI Integrations** | 4 (Claude, CodeCompanion, Copilot, SuperMaven) |
| **Lines of Lua Configuration** | 4000+ |

## 🚀 Quick Start

### Installation

#### Prerequisites
- **Neovim** 0.10+ (`nvim --version`)
- **Git** for plugin management
- **Python 3** for some plugins
- **Node.js** (optional, for JavaScript/TypeScript support)

#### Clone Configuration

```bash
# If using as standalone (outside dotfiles)
mkdir -p ~/.config
git clone https://github.com/cyperx/nvim.git ~/.config/nvim

# If using within dotfiles repository with submodule
git clone --recurse-submodules https://github.com/cyperx/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow nvim
```

#### First Launch

```bash
nvim
# Lazy.nvim will automatically download and install all plugins
# Initial startup may take 30-60 seconds
# Subsequent launches are fast (<1 second)
```

### Post-Install Setup

1. **Install LSP Servers** (optional but recommended):
   ```bash
   # Inside Neovim, use Mason:
   :MasonInstall clangd pyright rust_analyzer lua_ls
   ```

2. **Install Formatters** (optional):
   ```bash
   :MasonInstall stylua prettier_d rustfmt
   ```

3. **Configure Claude API** (for AI features):
   ```bash
   # Set your Claude API key
   export ANTHROPIC_API_KEY="your-key-here"

   # Or use pass (password manager)
   pass insert anthropic/api-key
   ```

## 📁 Configuration Structure

```
~/.config/nvim/
├── init.lua                          # Main entry point
├── lazy-lock.json                    # Plugin versions lock file
└── lua/
    ├── options.lua                   # Editor options
    ├── keymaps.lua                   # Global keybindings
    ├── autocmds.lua                  # Autocommands
    ├── lazy-bootstrap.lua            # Lazy.nvim initialization
    ├── lazy-plugins.lua              # Plugin imports
    └── custom/
        ├── plugins/                  # 45 individual plugin configs
        │   ├── lspconfig.lua         # Language Server Protocol
        │   ├── cmp.lua               # Completion (blink.cmp)
        │   ├── telescope.lua         # Fuzzy finder
        │   ├── treesitter.lua        # Syntax highlighting
        │   ├── git-*.lua             # Git integrations (5 files)
        │   ├── claude.lua            # Claude Code integration
        │   ├── codecompanion.lua     # AI chat with multiple LLMs
        │   ├── obsidian.lua          # Obsidian vault integration
        │   ├── ai-*.lua              # AI plugins (Copilot, SuperMaven)
        │   ├── ui-*.lua              # UI enhancements
        │   ├── mini.lua              # Mini.nvim modules
        │   └── [30+ more plugin configs]
        └── test_mini.lua             # Mini.nvim test utilities
```

## 🔌 Plugin Categories

### 1️⃣ LSP & Completion (8 plugins)

| Plugin | Purpose | Status |
|--------|---------|--------|
| `nvim-lspconfig` | Language Server Protocol configuration | ✅ Core |
| `mason.nvim` | LSP/formatter/linter package manager | ✅ Core |
| `mason-lspconfig.nvim` | Mason + LSP integration | ✅ Core |
| `blink.cmp` | Modern completion engine (faster Rust-based) | ✅ Core |
| `cmp-nvim-lsp` | LSP source for completion | ✅ Core |
| `lazydev.nvim` | Lua dev environment helpers | ✅ Enhanced |
| `fidget.nvim` | LSP status notifications | ✅ UX |
| `mason-tool-installer.nvim` | Auto-install tools | ✅ Automation |

**Configured Servers:**
```lua
clangd          -- C/C++
pyright         -- Python
rust_analyzer   -- Rust
lua_ls          -- Lua
```

### 2️⃣ Syntax Highlighting & Parsing (5 plugins)

| Plugin | Purpose |
|--------|---------|
| `nvim-treesitter` | Advanced syntax highlighting & code navigation |
| `render-markdown.nvim` | Beautiful markdown rendering with colors |
| `todo-comments.nvim` | Highlight TODO/FIXME/HACK comments |
| `indent-blankline.nvim` | Visual indentation guides |
| `vim-sleuth` | Auto-detect indentation |

**Treesitter Languages:** JavaScript, TypeScript, C, Lua, Vim, Bash, Python, Go, Rust, HTML, JSON, YAML, Markdown, and more

### 3️⃣ Fuzzy Finder & File Navigation (8 plugins)

| Plugin | Purpose | Binding |
|--------|---------|---------|
| `telescope.nvim` | Fuzzy finder for files/buffers/search | `<leader>s*` |
| `telescope-fzf-native.nvim` | Native FZF sorter (faster) | Auto |
| `mini.files` | Column-view file explorer (Miller columns) | `<C-e>` |
| `oil.nvim` | Edit filesystem as a buffer | `<C-M-e>` |
| `neo-tree.nvim` | Tree-style file explorer | Optional |
| `yazi.nvim` | Yazi file manager integration | `-` |
| `harpoon` | Quick file marks (8 files with Alt+key) | `<M-[a-s]>` |
| `telescope-ui-select.nvim` | Telescope for vim.ui.select | Auto |

### 4️⃣ Git Integration (5 plugins)

| Plugin | Purpose | Binding |
|--------|---------|---------|
| `gitsigns.nvim` | Git change indicators in gutter | `]c`, `[c`, `<leader>h*` |
| `vim-fugitive` | Git command wrapper | `:Git` |
| `neogit` | Magit-style git interface | `<leader>gg` |
| `diffview.nvim` | Enhanced diff viewing | `:DiffviewOpen` |
| `git-worktree.nvim` | Git worktree management | `<leader>gt` |

### 5️⃣ AI & Coding Assistance (5 plugins)

| Plugin | Purpose | Binding |
|--------|---------|---------|
| `claudecode.nvim` | Claude Code integration | `<leader>cc`, `<M-;>` |
| `codecompanion.nvim` | AI chat (Anthropic, OpenAI, Gemini, DeepSeek) | `<M-c>` |
| `copilot.lua` | GitHub Copilot integration | Auto-suggest |
| `supermaven-nvim` | Supermaven code completion | Auto-suggest |
| `mcphub.nvim` | MCP (Model Context Protocol) servers | `<leader>m` |

### 6️⃣ UI & Aesthetics (8 plugins)

| Plugin | Purpose |
|--------|---------|
| `lualine.nvim` | Status line with AI spinner |
| `tokyonight.nvim` | Tokyo Night colorscheme (storm variant) |
| `transparent.nvim` | Transparent background support |
| `which-key.nvim` | Keymap suggestions & help |
| `noice.nvim` | Command/search UI enhancement |
| `nvim-notify` | Pretty notification system |
| `snacks.nvim` | Utilities (dashboard, terminal, buffers) |
| `smear-cursor.nvim` | Smooth cursor animation |

**Theme:** Tokyo Night - Storm with transparency

### 7️⃣ Markdown & Knowledge Management (4 plugins)

| Plugin | Purpose | Binding |
|--------|---------|---------|
| `obsidian.nvim` | Obsidian vault integration | `<leader>o*` |
| `markdown-preview.nvim` | Live markdown preview in browser | `:MarkdownPreview` |
| `render-markdown.nvim` | Enhanced markdown rendering | Auto |
| Custom markdown headers | Jump between headers | `gj`, `gk` |

### 8️⃣ Debugging & Development Tools (6 plugins)

| Plugin | Purpose | Binding |
|--------|---------|---------|
| `nvim-dap` | Debug Adapter Protocol support | `<leader>d*`, `<leader>b` |
| `nvim-dap-ui` | DAP UI (breakpoints, watches) | `<leader>dd` |
| `nvim-dap-go` | Go debugging support | `:DapContinue` |
| `mason-nvim-dap.nvim` | Auto-install debuggers | Auto |
| `promise-async` | Async/promise utilities | Auto |
| `plenary.nvim` | Lua utilities library | Auto |

### 9️⃣ Mini.nvim Modules (10+ modules)

A collection of small, powerful, well-tested modules:

| Module | Purpose | Binding |
|--------|---------|---------|
| `mini.ai` | Text object selection | `a`, `i` (enhanced) |
| `mini.surround` | Surround manipulation | `sa`, `sd`, `sr`, `sh` |
| `mini.sessions` | Session persistence | Auto save/restore |
| `mini.files` | File explorer (Miller columns) | `<C-e>` |
| `mini.pick` | Picker/selector | Auto |
| `mini.diff` | Diff visualization | `<leader>td` |
| `mini.statusline` | Status line | Auto |
| `mini.icons` | Icon provider | Auto |
| `mini.colors` | Color utilities | Auto |
| `mini.pairs` | Auto pairs (alternative) | Auto |

### 🔟 Terminal & Session Management (4 plugins)

| Plugin | Purpose | Binding |
|--------|---------|---------|
| `snacks.nvim` (terminal) | Toggle terminal window | `<leader>tT` |
| `tmux` integration | Tmux awareness | Auto |
| `mini.sessions` | Session auto-save | Auto |
| `ghostty.lua` | Terminal app config | Config file |

## ⌨️ Keybindings (100+ Mappings)

### 🪟 Window Navigation

```vim
<C-h>    -- Focus left window
<C-j>    -- Focus down window
<C-k>    -- Focus up window
<C-l>    -- Focus right window
```

### 📁 File Management

```vim
<C-e>         -- Toggle mini.files explorer
<C-M-e>       -- Toggle oil at working directory
-             -- Open Yazi file manager
<M-a>         -- Harpoon: Mark current file
<M-e>         -- Harpoon: Toggle menu
<M-j/k/l/h>   -- Harpoon: Jump to file 1-4
<M-g/f/d/s>   -- Harpoon: Jump to file 5-8
```

### 🔍 Search & Selection

```vim
<leader>sh    -- Search help tags
<leader>sk    -- Search keymaps
<leader>sf    -- Search files
<leader>ss    -- Search Telescope pickers
<leader>sw    -- Search current word
<leader>sg    -- Live grep
<leader>sd    -- Search diagnostics
<leader>sr    -- Resume last search
<leader>s.    -- Search recent files
<leader>//    -- Fuzzy search in buffer
<leader>s/    -- Live grep in open files
<leader>sn    -- Search Neovim config
<leader><leader> -- Search open buffers
```

### 🚀 Git Operations (Neogit)

```vim
<leader>gg    -- Floating Neogit window
<leader>gG    -- Full-window Neogit
<leader>gb    -- Branch menu
<leader>gc    -- Commit menu
<leader>gd    -- Diff menu
<leader>gl    -- Log menu
<leader>gs    -- Stash menu
<leader>gP    -- Pull
<leader>gp    -- Push
<leader>gt    -- Switch git worktree
<leader>gW    -- Create git worktree
```

### 🔀 Git Hunks (Gitsigns)

```vim
]c / [c       -- Jump to next/prev change
<leader>hs    -- Stage hunk (normal/visual)
<leader>hr    -- Reset hunk
<leader>hS    -- Stage buffer
<leader>hu    -- Undo stage hunk
<leader>hR    -- Reset buffer
<leader>hp    -- Preview hunk
<leader>hb    -- Blame line
<leader>hd    -- Diff against index
<leader>hD    -- Diff against last commit
<leader>tb    -- Toggle blame line
<leader>tD    -- Toggle deleted preview
```

### 🔗 LSP Operations

```vim
gd            -- Goto definition
gr            -- Goto references
gI            -- Goto implementation
gD            -- Goto declaration
<leader>D     -- Goto type definition
<leader>ds    -- Document symbols
<leader>ws    -- Workspace symbols
<leader>rn    -- Rename
<leader>ca    -- Code action (normal & visual)
<leader>th    -- Toggle inlay hints
<leader>dq    -- Open diagnostic quickfix
```

### 🎨 Code Formatting & Actions

```vim
<leader>l     -- Format file or selection
<leader>ca    -- Code action
<leader>cA    -- Range code action
K             -- Hover info
```

### 🛠️ Debugging

```vim
<leader>ds    -- Debug: Start/Continue
<leader>di    -- Debug: Step into
<leader>do    -- Debug: Step over
<leader>du    -- Debug: Step out
<leader>b     -- Toggle breakpoint
<leader>B     -- Set conditional breakpoint
<leader>dd    -- Toggle DAP UI
```

### 🤖 AI & Code Assistance

```vim
<M-;>              -- Toggle Claude (normal mode)
<M-'>              -- Toggle Claude (DeepSeek mode)
<M-c>              -- CodeCompanion: Chat toggle
<leader>CC         -- CodeCompanion: Chat main
<leader>Cc         -- CodeCompanion: Actions
<leader>Ca         -- CodeCompanion: Add to chat
<leader>cf         -- Claude: Focus
<leader>cm         -- Claude: Model selector
<leader>cr         -- Claude: Resume
<leader>cC         -- Claude: Continue
<leader>cb         -- Claude: Add buffer to context
<leader>cs         -- Claude: Send selection (visual)
<leader>cS         -- Claude: Send line (normal)
<leader>ca         -- Claude: Add from tree
<leader>cc         -- Claude Code: Launch
<leader>c?         -- Claude: Help
<leader>cq         -- Claude: Quit
<leader>ch         -- Claude: FZF History
<leader>m          -- MCPHub: Open
```

### 📓 Obsidian Integration

```vim
<leader>on    -- New note
<leader>oo    -- Open in Obsidian app
<leader>of    -- Quick switch note
<leader>os    -- Search notes
<leader>ob    -- Backlinks
<leader>ol    -- Links
<leader>ot    -- Tags
<leader>od    -- Today (daily note)
<leader>oy    -- Yesterday
<leader>om    -- Tomorrow
<leader>oF    -- Follow link
<leader>oi    -- Paste image
<leader>or    -- Rename note
<leader>ow    -- Switch workspace
<leader>ox    -- Table of contents
<leader>oc    -- Toggle checkbox
<leader>oe    -- Extract note (visual)
<leader>oL    -- Link selection (visual)
```

### 🔄 Toggles

```vim
<leader>tz    -- Zen mode (distraction-free)
<leader>tT    -- Terminal toggle
<leader>tt    -- Transparent background toggle
<leader>td    -- Mini.diff overlay toggle
<leader>tm    -- Markdown rendering toggle
<leader>tb    -- Git blame toggle
<leader>th    -- Inlay hints toggle
```

### 💾 Buffer Management

```vim
<leader>bq    -- Close buffer
<leader>bw    -- Close buffer (keep split)
<leader>bd    -- Delete buffer (snacks)
<leader>ba    -- Delete all buffers
<leader>bo    -- Delete other buffers
```

### 📋 Quickfix & Location List

```vim
<leader>qn    -- Next quickfix item
<leader>qp    -- Previous quickfix item
<leader>ln    -- Next location item
<leader>lp    -- Previous location item
```

### ✏️ Text Editing

```vim
jk            -- Escape insert mode
Y             -- Yank to end of line
==            -- Select all text
J             -- Join lines (centered)
<C-d>         -- Page down (centered)
<C-u>         -- Page up (centered)
n / N         -- Search next/prev (centered)
p             -- Paste without yanking (visual)
<leader>y     -- Yank to system clipboard
<leader>Y     -- Yank line to system clipboard
<leader>D     -- Delete to void register
Q             -- No-op (prevent recording)
```

### 📍 Which-Key Groups

```vim
<leader>b     -- Buffer operations
<leader>c     -- Code/Claude operations
<leader>d     -- Diagnostic/Debug operations
<leader>g     -- Git operations
<leader>h     -- Git hunk operations
<leader>l     -- Location list
<leader>m     -- MCPHub
<leader>o     -- Obsidian operations
<leader>q     -- Quickfix list
<leader>r     -- Rename operations
<leader>s     -- Search operations
<leader>t     -- Toggle operations
<leader>w     -- Workspace operations
```

## 🔧 Editor Configuration

### Editor Options (`options.lua`)

```lua
-- Display
set number                -- Line numbers
set relativenumber        -- Relative line numbers
set signcolumn = "yes:1"  -- Always show sign column

-- Interaction
set mouse = "a"           -- Mouse support enabled
set splitright            -- Split right by default
set splitbelow            -- Split below by default

-- Search
set ignorecase            -- Case-insensitive by default
set smartcase             -- But sensitive if uppercase used
set inccommand = "split"  -- Preview substitutions

-- Undo & History
set undofile              -- Persistent undo
set backup = false        -- Don't create backup files

-- Rendering
set conceallevel = 2      -- Conceal for markdown
set clipboard = "unnamedplus" -- System clipboard

-- Performance
set timeoutlen = 300      -- Leader key timeout
set updatetime = 250      -- Update interval for plugins
```

### Global Keymaps (`keymaps.lua`)

- Mapleader set to `<Space>`
- Insert mode escape: `jk`
- Window navigation: Ctrl+hjkl
- Center viewport on movement
- Smart yank/delete to system clipboard
- Disable recording (Q)

## 🎨 Theming & Colors

### Primary Theme: Tokyo Night - Storm

Vibrant, modern colorscheme with:
- Dark navy background
- Bright cyan, yellow, pink, red accents
- Excellent contrast for readability
- Transparent background support

### Color Customization

Markdown header colors (via render-markdown):
```lua
H1: Red        (#f7768e)
H2: Yellow     (#e0af68)
H3: Green      (#9ece6a)
H4: Purple     (#bb9af7)
H5: Cyan       (#7aa2f7)
H6: Pink       (#ff9e64)
```

### Statusline (Lualine)

Custom colors and layout:
- Mode indicators with color coding
- Git diff summary
- Diagnostics count
- Filename with file type icon
- CodeCompanion activity spinner
- Custom separators
- Progress indicator

## 🤖 AI Integration

### Claude Code Integration (`claude.lua`)

Features:
- Dual-mode support (normal & DeepSeek API)
- Auto-reload buffers when Claude modifies files
- Fixed terminal window dimensions
- Window focus management
- Custom commands for different APIs

Bindings:
```vim
<M-;>    -- Toggle Claude (Anthropic)
<M-'>    -- Toggle Claude (DeepSeek)
<leader>cc -- Claude Code: Launch
```

### CodeCompanion (`codecompanion.lua`)

Multi-adapter support:
- **Anthropic** (Claude 3.5 Sonnet)
- **OpenAI** (GPT-4)
- **Google Gemini** (Gemini 2.0)
- **DeepSeek**

Features:
- Slash commands: `/buffer`, `/fetch`, `/help`, `/image`
- Variables system with buffer watching
- MCP Hub integration
- Chat toggle with `<M-c>`

### GitHub Copilot (`copilot.lua`)

- Auto-suggestion on insert mode
- Ghost text previews
- Tab to accept, Escape to dismiss
- Works alongside blink.cmp

### SuperMaven (`supermaven-nvim`)

Lightweight code completion:
- LSP-like suggestions
- Context-aware completions
- Lightweight alternative to Copilot

## 📝 Markdown & Knowledge Management

### Obsidian Integration (`obsidian.lua`)

Features:
- Workspace support
- Note ID generation (URL-friendly slugs)
- Auto-generated frontmatter with timestamps
- Smart action (context-aware link following/checkbox toggle)
- Tag processing with auto-hashtags
- Daily notes workflow

Example frontmatter:
```yaml
---
id: note-url-slug
title: Note Title
created: 2025-10-23
modified: 2025-10-23
tags: [tag1, tag2]
---
```

### Markdown Rendering (`render-markdown.nvim`)

- Colored headers (H1-H6 distinct colors)
- Code block styling
- Inline code highlighting
- List markers
- Checkbox rendering
- Link rendering
- Quote styling

## 🔧 LSP Configuration

### Setup Process

1. **Auto-detection**: LSP attaches on file open based on filetype
2. **Capabilities**: Enhanced with blink.cmp for better completion
3. **Keymaps**: Buffer-local keymaps on attach
4. **Diagnostics**: Configured with custom icons and virtual text

### Diagnostic Configuration

- Error: `ERROR` (red)
- Warning: `WARN` (yellow)
- Information: `INFO` (blue)
- Hint: `HINT` (green)
- Rounded borders for float windows
- Inline virtual text enabled

### Server Details

#### **Clangd** - C/C++
```bash
brew install llvm
```

#### **Pyright** - Python
```bash
pip install pyright
```

#### **Rust Analyzer** - Rust
```bash
rustup component add rust-analyzer
```

#### **Lua LS** - Lua
- Works with Neovim API
- Snippet support
- Library definitions for kick-start

## 🎯 Formatting & Code Quality

### Formatter Configuration (`conform.nvim`)

Supports 12+ formatters:

| Language | Formatter(s) |
|----------|--------------|
| Lua | stylua |
| JavaScript/TypeScript | prettier, prettierd |
| Markdown | prettier, prettierd |
| Python | autopep8, black |
| Rust | rustfmt |
| Go | gofmt |
| HTML | htmlbeautifier |
| Bash/Shell | beautysh, shellcheck |
| YAML | yamlfix |
| TOML | taplo |
| CSS/SCSS | prettier |
| XML | xmllint |
| JSON | jq |

### Auto-formatting

```vim
<leader>l     -- Format file or visual selection
```

Format on save can be toggled in conform config.

## 🐛 Debugging Features

### DAP Setup

Supports debugging for:
- **Go** (delve)
- **Python** (debugpy)
- **C/C++** (lldb, gdb)
- **Rust** (CodeLLDB)

### DAP UI

Visual interface for:
- Breakpoints with icons
- Variables inspection
- Call stack viewing
- Watches and expressions
- REPL interaction

### Debugging Workflow

```vim
<leader>ds    -- Start debug session
<leader>b     -- Toggle breakpoint
<leader>B     -- Set conditional breakpoint
<leader>di    -- Step into
<leader>do    -- Step over
<leader>du    -- Step out
<leader>dd    -- Toggle DAP UI
```

## 📦 Completion Engine: Blink.cmp

Modern, fast completion using Rust:

**Features:**
- LSP-based suggestions (primary)
- Buffer fallback
- Snippet support (friendly-snippets)
- Per-filetype customization
- Special handling for CodeCompanion

**Keybinds:**
```vim
<C-n>     -- Next suggestion
<C-p>     -- Previous suggestion
<C-y>     -- Accept suggestion
<C-e>     -- Dismiss (in completion)
```

## 🚀 Performance Optimizations

### Lazy Loading

- Plugins load on-demand (event, keys, filetype)
- Only essential plugins load at startup
- Fast startup time (<1 second)

### Treesitter Parsing

- Only active languages are parsed
- Auto-install new languages on open
- Incremental parsing for large files

### LSP Efficiency

- Debounced diagnostic updates
- Efficient inlay hint caching
- Smart reference highlighting

## 🔄 Auto-Commands

### Markdown Header Navigation

Jump between markdown headers with `gj` and `gk` in markdown files.

### Text Yank Highlighting

Brief visual highlight when text is yanked.

### Language-Specific Settings

Auto-detection and configuration per filetype via Treesitter and LSP.

## 🎯 Notable Features

### 1. Advanced AI-Assisted Development
- Claude Code with dual API support (Anthropic + DeepSeek)
- CodeCompanion with 4 LLM providers
- Context-aware suggestions
- MCP server integration

### 2. Knowledge Management
- Obsidian vault integration
- Markdown rendering with syntax highlighting
- Daily notes workflow
- Backlinks and tags support

### 3. Git Workflow Optimization
- Neogit for Magit-style interface
- Gitsigns for inline hunks
- Fugitive for git commands
- Git-worktree for branch management
- Diffview for enhanced diffs

### 4. Session Persistence
- Mini.sessions for auto-save/restore
- Tmux integration awareness
- Cross-session state management

### 5. Multiple File Explorers
- Mini.files (column view - default)
- Oil.nvim (edit-as-buffer)
- Neo-tree (tree view)
- Yazi integration

### 6. Folding Strategy
- UFO with LSP-based folding
- Async folds with promises
- Peek fold without closing
- Open/close all folds

### 7. Terminal Integration
- Snacks terminal with split management
- Auto-close on command completion
- Git root directory detection
- Configurable window sizing

### 8. Notification System
- Noice for command/search UI
- Pretty notifications with animations
- Integration with LSP status
- CodeCompanion request indicators

## 🏗️ Architecture Overview

### Bootstrap Flow

```
init.lua
├─ Load options (editor settings)
├─ Load keymaps (global bindings)
├─ Load autocmds (event handlers)
├─ Initialize Lazy.nvim (plugin manager)
│  ├─ Download/update plugins
│  │
└─ Load custom plugins
   ├─ vim-sleuth (indentation detection)
   ├─ LSP ecosystem
   │  ├─ lspconfig
   │  ├─ mason
   │  └─ blink.cmp
   ├─ Completion
   ├─ UI/Aesthetics
   ├─ Git operations (5 plugins)
   ├─ AI integration (4 plugins)
   ├─ Markdown/Notes
   ├─ File navigation (6 plugins)
   ├─ Mini.nvim modules (10+)
   └─ Debugging & utilities
```

## 🛠️ Customization Guide

### Add a New Plugin

1. Create `lua/custom/plugins/myplug.lua`:
```lua
return {
  'author/myplug.nvim',
  config = function()
    require('myplug').setup({
      -- options
    })
  end,
  keys = {
    { '<leader>mp', '<cmd>MyPlugCommand<cr>', desc = 'My Plugin' }
  }
}
```

2. It will auto-load via `lazy-plugins.lua`

### Modify Keybindings

Edit `lua/keymaps.lua` for global keybindings.
Edit specific plugin config for plugin-specific bindings.

### Change Theme

In `lua/custom/plugins/colorscheme.lua`:
```lua
vim.cmd.colorscheme 'your-theme-name'
```

### Configure LSP Servers

Edit `lua/custom/plugins/lspconfig.lua` to add servers:
```lua
require('lspconfig').your_server.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
```

## 📚 Learning Resources

- **Neovim Docs**: `:help nvim`
- **Lazy.nvim**: https://github.com/folke/lazy.nvim
- **Kickstart**: https://github.com/nvim-lua/kickstart.nvim
- **LSPConfig**: https://github.com/neovim/nvim-lspconfig
- **Treesitter**: https://github.com/nvim-treesitter/nvim-treesitter

## 🐛 Troubleshooting

### Plugins Not Loading

```vim
:checkhealth lazy
:Lazy debug
```

### LSP Not Working

```vim
:checkhealth lsp
:Mason
```

### Performance Issues

```vim
:Lazy profile
:checkhealth startuptime
```

### Plugin Conflicts

Check lazy-lock.json for version conflicts, or reset:
```bash
rm ~/.local/share/nvim/lazy/lazy-lock.json
nvim +Lazy! sync
```

## 🤝 Contributing

Feel free to fork and customize for your needs. Core philosophy:
- Fast startup (<1s)
- Modern Lua configuration
- Practical plugins (no bloat)
- Sensible defaults
- Easy customization

## 📄 License

MIT License - feel free to use and modify for personal or commercial projects.

## 🙏 Acknowledgments

- [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) - Base configuration
- [folke/lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin manager
- The amazing Neovim community for excellent plugins and tools

---

**Last Updated**: January 2026
**Neovim Version**: 0.10+
**Status**: Actively maintained

---

## Author

**cyperx** - [GitHub Profile](https://github.com/cyperx84)

For issues or contributions, visit the [nvim repository](https://github.com/cyperx84/nvim) or [dotfiles repository](https://github.com/cyperx84/dotfiles).
