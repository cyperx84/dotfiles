# Neovim Configuration

```lua
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

A modern, AI-powered Neovim configuration built on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) with extensive customizations for AI-assisted development, Obsidian note-taking, and seamless git workflows.

## 📊 Stats at a Glance

- **42 plugins** managed by lazy.nvim
- **70+ custom keybindings** with mnemonic grouping
- **4 AI assistants** (CodeCompanion, Claude Code, Copilot, Supermaven)
- **4 LSP servers** with 13+ formatters
- **2 file explorers** (Oil.nvim, Yazi)
- **40+ language parsers** via Treesitter
- **Deep Obsidian integration** with iCloud sync

## 🚀 Quick Start

### Prerequisites

```bash
# Required
brew install neovim git ripgrep fd fzf

# Optional but recommended
brew install yazi               # TUI file manager
brew install --cask ghostty     # Terminal (native integration)
brew install imagemagick        # Markdown image rendering
```

### Installation

```bash
# Using GNU Stow (from dotfiles repo)
cd ~/dotfiles
stow nvim

# Or manual installation
git clone <your-repo> ~/.config/nvim

# Launch Neovim - plugins auto-install
nvim
```

On first launch:
1. lazy.nvim installs automatically
2. All plugins install (2-3 minutes)
3. Treesitter parsers auto-install on file open
4. LSP servers suggested via Mason (`:MasonInstall lua-language-server`)

## ⌨️ Essential Keybindings

| Key | Action | Context |
|-----|--------|---------|
| `Space` | Leader key | All modes |
| `-` | Open Yazi file manager | Normal |
| `Ctrl+e` | Toggle Oil explorer | Normal |
| `Alt+;` | Toggle Claude Code | Normal |
| `Alt+c` | Toggle CodeCompanion chat | Normal |
| `<leader>sf` | Search files (Telescope) | Normal |
| `<leader>sg` | Live grep | Normal |
| `<leader>gg` | Open Neogit | Normal |

See [full keybindings](#core-keybindings) below.

## 🎯 Key Features

### AI-Powered Development

**Multiple AI Providers:**
- **CodeCompanion** - Chat interface with DeepSeek (default), Anthropic, OpenAI, Gemini
- **Claude Code** - Official Claude integration with multi-model support
- **Copilot** - Inline suggestions
- **MCPHub** - Model Context Protocol integration

**Keybindings:**
- `Alt+c` - CodeCompanion chat
- `Alt+;` - Claude Code toggle
- `<leader>Cb` - Add buffer to AI chat
- `<leader>cs` - Send visual selection to AI

### File Navigation

**Dual File Explorers:**
- **Oil.nvim** (`Ctrl+e`) - Edit filesystem like a buffer
- **Yazi** (`-`) - TUI file manager with grep integration
- **Telescope** (`<leader>s*`) - Fuzzy finder for files/grep/buffers
- **Harpoon** (`Alt+e`) - Quick file bookmarks

### Git Workflows

**Full-Featured Git Integration:**
- **Neogit** (`<leader>gg`) - Comprehensive git UI
- **Gitsigns** (`]c`/`[c`) - Inline change indicators
- **Git Worktrees** (`<leader>gW`) - Multi-worktree management
- **Vim Fugitive** - Classic git commands

### Obsidian Note-Taking

**Deep Integration:**
- Wiki-style links with backlinks
- Daily notes in `_inbox/` folder
- iCloud sync with auto-reload
- Live markdown rendering with colored headers
- Image paste and inline rendering

**Keybindings:**
- `<leader>on` - New note
- `<leader>of` - Find note
- `<leader>od` - Today's daily note
- `<leader>oc` - Toggle checkbox

## 📚 Core Keybindings

### Leader Key: `Space`

All leader-based keybindings use Space. Which-key.nvim provides instant visual guidance.

### Navigation

| Key | Action |
|-----|--------|
| `Ctrl+h/j/k/l` | Navigate splits/tmux panes |
| `Ctrl+d/u` | Scroll half-page (centered) |
| `n/N` | Next/prev search (centered) |
| `Esc` | Clear search highlight |
| `]c` / `[c` | Next/prev git hunk |

### File Explorers

| Key | Action |
|-----|--------|
| `Ctrl+e` | Toggle Oil float (at file) |
| `Ctrl+Alt+e` | Toggle Oil float (at cwd) |
| `-` | Open Yazi (at parent) |
| `<leader>ew` | Open Yazi (at cwd) |

**Oil Navigation:**
- `l` / `Enter` - Open file/directory
- `h` / `-` - Parent directory
- `g.` - Toggle hidden files
- `=` - Apply changes
- `q` - Close

**Yazi Navigation:**
- `Ctrl+v/x/t` - Open in split/horizontal/tab
- `Ctrl+s` - Grep in directory
- `Ctrl+y` - Copy relative path

### LSP & Code Actions

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>l` | Format file/range |
| `<leader>th` | Toggle inlay hints |
| `[d` / `]d` | Prev/next diagnostic |

### Search (Telescope)

| Key | Action |
|-----|--------|
| `<leader>sf` | Search files |
| `<leader>sg` | Live grep |
| `<leader>sw` | Search current word |
| `<leader>sh` | Search help tags |
| `<leader>ss` | Select Telescope picker |
| `<leader>sr` | Resume last search |
| `<leader><leader>` | Find buffers |

### Git Commands

| Key | Action |
|-----|--------|
| `<leader>gg` | Open Neogit |
| `<leader>gb` | Branches |
| `<leader>gc` | Commit |
| `<leader>gd` | Diff |
| `<leader>gl` | Log |
| `<leader>gW` | Create worktree |
| `<leader>gt` | Switch worktree |
| `<leader>tb` | Toggle blame line |

### AI Assistance

| Key | Action |
|-----|--------|
| `Alt+c` | Toggle CodeCompanion |
| `<leader>Cc` | CodeCompanion actions |
| `<leader>Cb` | Add buffer to chat |
| `Alt+;` | Claude Code toggle |
| `<leader>cb` | Add buffer to Claude |
| `<leader>cs` | Send selection (visual) |

### Sessions

| Key | Action |
|-----|--------|
| `<leader>Ss` | Save session |
| `<leader>Sl` | Load session |
| `<leader>Sn` | Open "notes" session |
| `<leader>Sd` | Open "dotfiles" session |

## 🔧 Plugin Categories

### LSP & Language Support (5 plugins)

**nvim-lspconfig** - Language servers
- Configured: clangd, pyright, rust_analyzer, lua_ls
- Auto-completion, diagnostics, go-to-definition
- Fidget.nvim shows LSP loading status

**Blink.cmp** - Completion engine (Rust-based)
- Sources: LSP, path, snippets, buffer
- Fast, minimal UI with auto-documentation

**conform.nvim** - Formatting
- Lua (stylua), JS/TS (prettier), Python (black)
- Rust (rustfmt), Go (gofmt), YAML, TOML, Shell
- Keymap: `<leader>l` (1000ms timeout)

**nvim-treesitter** - Syntax highlighting
- 40+ language parsers
- Smart indentation, text objects

### AI Assistance (6 plugins)

**CodeCompanion.nvim** - Primary AI interface
- Providers: DeepSeek (default), Anthropic, OpenAI, Gemini
- Slash commands: /buffer, /fetch, /image
- MCPHub integration for tools/resources
- Chat position: Left split (60 cols × 50 lines)

**Claude Code** - Official Claude integration
- Multi-model: Normal, MiniMax, DeepSeek, GLM
- Terminal: Right split, 35% width
- Auto-reload buffers on external changes
- Git root detection for CWD

**Copilot.lua** - Inline suggestions
- `Ctrl+Alt+l` - Accept suggestion
- `Alt+]` / `Alt+[` - Next/prev
- Auto-trigger (75ms debounce)
- Disabled for: YAML, Markdown, help, git commits

**MCPHub.nvim** - MCP integration
- Port: 37373
- Config: `~/.config/mcphub/servers.json`
- Variables from resources, slash commands from prompts

### File Explorers (4 plugins)

**Oil.nvim** - Primary explorer
- Edit filesystem like a buffer
- Delete to trash, LSP file operations
- Float mode with rounded borders

**Yazi.nvim** - TUI file manager
- Full-featured terminal file browser
- Grep and replace in directories
- Quickfix integration, multi-tab support

**Telescope.nvim** - Fuzzy finder
- Extensions: fzf-native, ui-select, git-worktree
- Flexible layout (auto-switches at 100 cols)
- Ignores: .git, node_modules, .obsidian

### Git Integration (3 plugins)

**Neogit** - Primary git UI
- Comprehensive staging/committing
- Branch management, diffview integration
- Float and split modes

**gitsigns.nvim** - Inline indicators
- Change indicators (+/~/-), hunk staging
- Line blame, navigation: `]c`/`[c`

**git-worktree.nvim** - Worktree management
- Telescope picker for worktrees
- Create: `<leader>gW`, Switch: `<leader>gt`

### UI/Theme (7 plugins)

**TokyoNight** - Base colorscheme
- Variant: unokai (active)
- Custom purple borders (#ff00ff)
- Transparent background support

**Lualine.nvim** - Status line
- Custom spinner for CodeCompanion
- LSP client count, branch/diff/diagnostics
- Mode-based colors

**Snacks.nvim** - Dashboard & utilities
- Dashboard with session shortcuts
- Zen mode with diagnostic hiding
- Buffer delete, terminal toggle

**Transparent.nvim** - Background transparency
- Global transparency enabled
- Special handling for float windows

**Noice.nvim** - Command line UI
- Message routing/filtering
- LSP docs with borders

### Markdown/Notes (3 plugins)

**Obsidian.nvim** - Note-taking
- 2 workspaces (notes, snowboarding)
- iCloud sync with auto-reload
- Wiki links, daily notes, frontmatter
- Telescope integration

**render-markdown.nvim** - Live rendering
- Colored headings (H1-H6)
- Code blocks with dark background
- Conceallevel: 2 (hides markup)

**markdown-preview.nvim** - Browser preview
- Command: `:MarkdownPreview`

### Navigation (2 plugins)

**Harpoon** - File bookmarks
- Mark: `Ctrl+Alt+m`, Menu: `Alt+e`
- Quick jump: `Alt+j/k/l/u/i/o` (files 1-6)

**Navigator.nvim** - Window navigation
- `Ctrl+h/j/k/l` unified with Tmux
- Seamless split/pane switching

### Editing (3 plugins)

**Mini.nvim suite** - Multiple utilities
- AI (n_lines=500), Surround, Sessions
- Text objects: `va)`, `ci'`, `saiw)`

**Autopairs.nvim** - Auto-close
- Brackets, quotes, parens
- Integrates with blink.cmp

**Indent-blankline.nvim** - Visual guides
- Indentation markers

## 🏗️ Configuration Structure

```
nvim/.config/nvim/
├── init.lua                              # Entry point (10 lines)
├── lazy-lock.json                        # Plugin version lock
├── README.md                             # This file
└── lua/
    ├── options.lua                       # Core Neovim settings
    ├── keymaps.lua                       # Global keybindings (217 lines)
    ├── autocmds.lua                      # Autocommands
    ├── lazy-bootstrap.lua                # lazy.nvim setup
    ├── lazy-plugins.lua                  # Plugin loader
    └── custom/
        └── plugins/                      # 42 plugin configs
            ├── ai/                       # AI assistants
            │   ├── codecompanion.lua
            │   ├── claude.lua
            │   ├── copilot.lua
            │   ├── super-maven.lua
            │   ├── mcphub.lua
            │   └── claude-FZF-history.lua
            ├── completion/               # Completion
            │   └── cmp.lua               # blink.cmp
            ├── editor/                   # Editing tools
            │   ├── autopairs.lua
            │   ├── harpoon.lua
            │   ├── mini.lua
            │   ├── navigator.lua
            │   └── todo-comments.lua
            ├── file-explorer/            # File navigation
            │   ├── oil.lua
            │   ├── yazi.lua
            │   └── mini-files.lua
            ├── git/                      # Git integration
            │   ├── neogit.lua
            │   ├── gitsigns.lua
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
            │   └── telescope.lua
            └── ui/                       # Appearance
                ├── tokyonight.lua
                ├── lualine.lua
                ├── transparent.lua
                ├── snacks.lua
                └── noice.lua
```

## 🎨 Customization

### Adding a Plugin

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
opts = {
  style = 'night',  -- or 'storm', 'day', 'moon'
}
```

### Adding LSP Server

Edit `lua/custom/plugins/lsp/lspconfig.lua`:
```lua
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
vim.keymap.set('n', '<leader>x', '<cmd>YourCommand<cr>',
  { desc = 'Your description' })
```

### Disabling Plugins

Add `enabled = false` to plugin spec:
```lua
return {
  'plugin/name',
  enabled = false,
}
```

## 🐛 Troubleshooting

### LSP Not Starting

```vim
:Mason          " Check if server installed
:LspInfo        " Check LSP status
:LspRestart     " Restart LSP
:lua vim.cmd('e ' .. vim.lsp.get_log_path())  " Check logs
```

### Plugins Not Loading

```vim
:Lazy           " Check status
:Lazy sync      " Update plugins
:Lazy clear     " Clear cache
:Lazy log       " Check errors
```

### Telescope Errors

**Issue:** `rg: command not found`
```bash
brew install ripgrep
```

### Oil.nvim Errors

**Issue:** Trash not working
```bash
brew install trash
which trash
```

### CodeCompanion API Errors

**Issue:** Authentication failed
```bash
# Check API keys
pass apis/DEEP_SEEK_API_KEY
pass apis/ANTHROPIC_API_KEY
pass apis/OPENAI_API_KEY
pass apis/GEMINI_API_KEY

# Test API
curl -H "Authorization: Bearer $(pass apis/ANTHROPIC_API_KEY)" \
  https://api.anthropic.com/v1/messages
```

### Performance Issues

**Issue:** Slow startup
```bash
nvim --startuptime startup.log
# Check which plugins load on startup
```

**Issue:** Large files
```vim
:TSDisable highlight  " Disable treesitter
```

### Health Check

```vim
:checkhealth
:checkhealth telescope
:checkhealth treesitter
:checkhealth lspconfig
```

## 🌟 Unique Features

1. **Multi-LLM Support** - DeepSeek + Anthropic + OpenAI + Gemini via CodeCompanion
2. **Purple Aesthetic** - Custom magenta borders (#ff00ff) across all UI elements
3. **Transparent Everything** - Global background transparency with float handling
4. **Tmux Integration** - Unified window navigation with Navigator.nvim
5. **Obsidian + iCloud** - Two vaults with auto-sync and reload
6. **MCPHub Integration** - Full MCP server support with auto-approval
7. **Dual File Explorers** - Oil (buffer-style) + Yazi (terminal) for different workflows
8. **Session Persistence** - Quick-open templates for common contexts
9. **AI-First Design** - Heavy use of `<leader>C*` for AI commands
10. **Auto-Reload External Changes** - Claude Code edits trigger buffer reload

## 📖 Documentation

### Built on
- [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) - Foundation
- [lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin manager
- [Tokyo Night](https://github.com/folke/tokyonight.nvim) - Colorscheme

### Plugin Docs
- [CodeCompanion](https://github.com/olimorris/codecompanion.nvim)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [Obsidian.nvim](https://github.com/epwalsh/obsidian.nvim)
- [Neogit](https://github.com/NeogitOrg/neogit)

### Community
- [r/neovim](https://reddit.com/r/neovim)
- [Neovim Discourse](https://neovim.discourse.group/)

---

**Philosophy:** This configuration balances power-user features with thoughtful defaults. It provides multiple workflows (Oil vs Yazi, Telescope vs Harpoon) so you can choose what fits your style. The AI integrations make this a modern AI-assisted development environment while maintaining traditional Vim efficiency.

**Maintained by:** cyperx
**Last Updated:** 2025-12-05
