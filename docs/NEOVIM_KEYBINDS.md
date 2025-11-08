# Neovim Keybinds Reference

> **📖 Navigation**
> [Core Navigation](#core-navigation) • [File Management](#file-management) • [Git Operations](#git-operations) • [Search & Telescope](#search--telescope) • [Text Editing](#text-editing) • [Buffer Management](#buffer-management) • [Plugin Specific](#plugin-specific)

## Overview

This document covers all Neovim keybinds across the configuration, organized by functional category. The configuration uses `<leader>` (space key) extensively for plugin operations.

**Configuration Sources:**
- `nvim/.config/nvim/lua/keymaps.lua` - Core keymaps
- `nvim/.config/nvim/lua/custom/plugins/*.lua` - Plugin-specific bindings

---

## Core Navigation

### Window Navigation
*Source: `keymaps.lua`*

| Keybind | Action | Description |
|---------|--------|-------------|
| `<C-h>` | `<C-w><C-h>` | Move focus to left window |
| `<C-l>` | `<C-w><C-l>` | Move focus to right window |
| `<C-j>` | `<C-w><C-j>` | Move focus to lower window |
| `<C-k>` | `<C-w><C-k>` | Move focus to upper window |

### Terminal Integration
*Source: `keymaps.lua`*

| Keybind | Mode | Action | Description |
|---------|------|--------|-------------|
| `<Esc><Esc>` | Terminal | `<C-\><C-n>` | Exit terminal mode |

### Basic Operations
*Source: `keymaps.lua`*

| Keybind | Mode | Action | Description |
|---------|------|--------|-------------|
| `<Esc>` | Normal | `:nohlsearch<CR>` | Clear search highlighting |
| `<C-s>` | Normal | `:w<CR>` | Save file (quick save) |
| `jk` | Insert | `<Esc><Esc>` | Exit insert mode |

---

## File Management

### File Managers
*Source: `keymaps.lua`*

| Keybind | Action | Tool | Description |
|---------|--------|------|-------------|
| `<leader>e` | `require('mini.files').open()` | Mini.Files | Toggle mini.files (main) |
| `<C-e>` | `:Oil --float<CR>` | Oil | Open parent directory (floating) |
| `-` | `:Yazi<CR>` | Yazi | Open parent directory with Yazi |
| `<leader>E` | `:Neotree toggle<CR>` | Neotree | Toggle Neotree file explorer |
| `<leader>-` | `:Yazi<CR>` | Yazi | Open parent directory |

**Note:** `<leader>e` toggles mini.files - if already open, it closes; otherwise opens at current file location.

---

## Git Operations

### Neogit Integration
*Source: `keymaps.lua`*

| Keybind | Action | Description |
|---------|--------|-------------|
| `<leader>gg` | `:Neogit kind=floating<CR>` | Open Neogit (floating) |
| `<leader>gG` | `:Neogit kind=split<CR>` | Open Neogit (split) |
| `<leader>gb` | `:Neogit branch kind=auto<CR>` | Branch operations |
| `<leader>gB` | `:Neogit branch_config kind=auto<CR>` | Branch configuration |
| `<leader>gc` | `:Neogit commit kind=auto<CR>` | Commit operations |
| `<leader>gd` | `:Neogit diff kind=auto<CR>` | Diff operations |
| `<leader>gl` | `:Neogit log kind=auto<CR>` | Log operations |
| `<leader>gs` | `:Neogit stash kind=auto<CR>` | Stash operations |
| `<leader>gm` | `:Neogit merge kind=auto<CR>` | Merge operations |
| `<leader>gP` | `:Neogit pull<CR>` | Pull operations |
| `<leader>gp` | `:Neogit push<CR>` | Push operations |

### Git Worktree
*Source: `keymaps.lua`*

| Keybind | Action | Description |
|---------|--------|-------------|
| `<leader>gW` | `telescope.extensions.git_worktree.create_git_worktree()` | Create worktree |
| `<leader>gt` | `telescope.extensions.git_worktree.git_worktrees()` | Switch worktree |

---

## Search & Telescope

### Core Telescope Operations
*Source: `telescope.lua`*

| Keybind | Action | Description |
|---------|--------|-------------|
| `<leader>sh` | `builtin.help_tags` | Search Help |
| `<leader>sk` | `builtin.keymaps` | Search Keymaps |
| `<leader>sf` | `builtin.find_files` | Search Files |
| `<leader>ss` | `builtin.builtin` | Search Select Telescope |
| `<leader>sw` | `builtin.grep_string` | Search current Word |
| `<leader>sg` | `builtin.live_grep` | Search by Grep |
| `<leader>sd` | `builtin.diagnostics` | Search Diagnostics |
| `<leader>sr` | `builtin.resume` | Search Resume |
| `<leader>s.` | `builtin.oldfiles` | Search Recent Files |
| `<leader><leader>` | `builtin.buffers` | Find existing buffers |

### Advanced Search
*Source: `telescope.lua`*

| Keybind | Action | Description |
|---------|--------|-------------|
| `<leader>/` | Buffer fuzzy search | Fuzzy search in current buffer |
| `<leader>s/` | Live grep in open files | Search in open files |
| `<leader>sn` | Neovim config search | Search Neovim configuration |
| `<leader>sl` | `:Telescope notify<CR>` | Search Notify Log |

---

## Text Editing

### Enhanced Editing
*Source: `keymaps.lua`*

| Keybind | Mode | Action | Description |
|---------|------|--------|-------------|
| `Y` | Normal | `y$` | Yank to end of line |
| `==` | Normal | `gg<S-v>G` | Select all text |
| `J` | Normal | `mzJ`z` | Join lines (keep cursor position) |
| `<C-d>` | Normal | `<C-d>zz` | Half page down (centered) |
| `<C-u>` | Normal | `<C-u>zz` | Half page up (centered) |
| `n` | Normal | `nzzzv` | Next search (centered) |
| `N` | Normal | `Nzzzv` | Previous search (centered) |

### Clipboard Operations
*Source: `keymaps.lua`*

| Keybind | Mode | Action | Description |
|---------|------|--------|-------------|
| `<leader>y` | Normal/Visual | `"+y` | Yank to system clipboard |
| `<leader>Y` | Normal | `"+Y` | Yank line to system clipboard |
| `<leader>D` | Normal/Visual | `"_d` | Delete to void register |
| `p` | Visual | `"_dP` | Paste without overwriting register |

---

## Buffer Management

### Buffer Operations
*Source: `keymaps.lua`*

| Keybind | Action | Description |
|---------|--------|-------------|
| `<leader>bq` | `:bd<CR>` | Close buffer |
| `<leader>bw` | `:bp\|bd #<CR>` | Close buffer, retain split |

### Quickfix & Location Lists
*Source: `keymaps.lua`*

| Keybind | Action | Description |
|---------|--------|-------------|
| `<leader>qn` | `:cnext<CR>zz` | Next quickfix item |
| `<leader>qp` | `:cprev<CR>zz` | Previous quickfix item |
| `<leader>ln` | `:lnext<CR>zz` | Next location item |
| `<leader>lp` | `:lprev<CR>zz` | Previous location item |

### Diagnostics
*Source: `keymaps.lua`*

| Keybind | Action | Description |
|---------|--------|-------------|
| `<leader>dq` | `vim.diagnostic.setloclist` | Open diagnostic quickfix list |

---

## Plugin Specific

### Obsidian Integration
*Source: `keymaps.lua`*

| Keybind | Action | Description |
|---------|--------|-------------|
| `<leader>oc` | `require('obsidian').util.toggle_checkbox()` | Toggle checkbox |
| `<leader>ot` | `:ObsidianTags<CR>` | Show tags |
| `<leader>oO` | `:ObsidianOpen<CR>` | Open in Obsidian app |
| `<leader>ob` | `:ObsidianBacklinks<CR>` | Show backlinks |
| `<leader>oe` | `:ObsidianExtractNote<CR>` | Extract note (visual) |
| `<leader>oF` | `:ObsidianFollowLink<CR>` | Follow link |
| `<leader>ol` | `:ObsidianLinks<CR>` | Show links |
| `<leader>on` | `:ObsidianNew<CR>` | Create new note |
| `<leader>or` | `:ObsidianRename<CR>` | Rename note |
| `<leader>os` | `:ObsidianSearch<CR>` | Search Obsidian |
| `<leader>of` | `:ObsidianQuickSwitch<CR>` | Quick switch |
| `<leader>op` | `:ObsidianPasteImg<CR>` | Paste image |
| `<leader>ow` | `:ObsidianWorkspace<CR>` | Switch workspace |

### Code Companion (AI)
*Source: `keymaps.lua`*

| Keybind | Action | Description |
|---------|--------|-------------|
| `<C-M-k>` | `:CodeCompanionChat Toggle<CR>` | Toggle AI chat |
| `<leader>CC` | `:CodeCompanion<CR>` | Open Code Companion |
| `<leader>Cc` | `:CodeCompanionActions<CR>` | Code Companion actions |
| `<leader>Cd` | `:CodeCompanionCMD<CR>` | Code Companion commands |

### MCPHub
*Source: `keymaps.lua`*

| Keybind | Action | Description |
|---------|--------|-------------|
| `<leader>m` | `:MCPHub<CR>` | Open MCPHub |

### UI Toggles
*Source: `keymaps.lua`*

| Keybind | Action | Description |
|---------|--------|-------------|
| `<leader>tm` | `:Markview<CR>` | Toggle Markview |
| `<leader>tt` | `:TransparentToggle<CR>` | Toggle transparency |
| `<leader>td` | `require('mini.diff').toggle()` | Toggle MiniDiff |
| `<leader>z` | `:NoiceDismiss<CR>` | Dismiss Noice message |

### Image Operations
*Source: `keymaps.lua`*

| Keybind | Action | Description |
|---------|--------|-------------|
| `<leader>pi` | `:PasteImage<CR>` | Paste image |

### Disabled Keybinds
*Source: `keymaps.lua`*

| Keybind | Action | Description |
|---------|--------|-------------|
| `Q` | `<nop>` | Disable Ex mode |

---

## Configuration Context

### Which-Key Integration
The configuration uses which-key for contextual help. Leader key combinations show available options dynamically.

### Plugin Integration Points
- **Telescope**: Integrates with git-worktree, notify, and file operations
- **Mini.Files**: Can be toggled and integrates with current file context
- **Oil/Yazi**: Multiple file manager options for different workflows
- **Neogit**: Comprehensive git operations with floating/split modes

### Tmux Integration
Window navigation (`<C-hjkl>`) seamlessly integrates with tmux pane navigation through the vim-tmux-navigator plugin.

---

## Quick Reference

### Most Used Keybinds
```
Files:          <leader>e (mini.files), <C-e> (oil), - (yazi)
Search:         <leader>sf (files), <leader>sg (grep), <leader><leader> (buffers)
Git:            <leader>gg (neogit), <leader>gp (push), <leader>gc (commit)
Navigation:     <C-hjkl> (windows), jk (exit insert)
Editing:        <leader>y (system yank), Y (yank line), == (select all)
```

### Leader Key Groups
- `<leader>g*` - Git operations (neogit, worktree)
- `<leader>s*` - Search operations (telescope)
- `<leader>o*` - Obsidian operations
- `<leader>b*` - Buffer operations
- `<leader>t*` - UI toggles
- `<leader>q*` - Quickfix operations
- `<leader>l*` - Location list operations

---

## Related Documentation

- [Main Keybinds](KEYBINDS.md) - System-wide keybinds and aliases
- [Workflow Guides](WORKFLOW_GUIDES.md) - Cross-tool integration workflows
- [CLAUDE.md](../CLAUDE.md) - Main dotfiles documentation