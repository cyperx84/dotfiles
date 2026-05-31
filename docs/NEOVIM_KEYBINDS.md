# Neovim Keybinds Reference

> **📖 Navigation**
> [Core Navigation](#core-navigation) • [File Management](#file-management) • [Git Operations](#git-operations) • [Search & LSP](#search--lsp) • [Text Editing](#text-editing) • [Buffer Management](#buffer-management) • [AI Integrations](#ai-integrations) • [Plugin Specific](#plugin-specific) • [Quick Reference](#quick-reference)

## Overview

This document covers the Neovim keybinds across the configuration, organized by functional category. The setup uses `<leader>` (the space key) extensively for plugin operations, and integrates seamlessly with tmux for pane navigation.

> **Note:** Neovim is a **standalone repository** at [`~/.config/nvim`](https://github.com/cyperx84/nvim) — it is *not* part of the dotfiles repo. All `Source:` paths below point at that repository.

**Configuration Sources:**

- `~/.config/nvim/lua/keymaps.lua` — Core keymaps
- `~/.config/nvim/lua/custom/plugins/*.lua` — Plugin-specific bindings

---

## Core Navigation

### Window & Pane Navigation
*Source: `custom/plugins/tmux.lua`*

`<C-h/j/k/l>` are mapped by **Navigator.nvim** (`numToStr/Navigator.nvim`), which integrates with tmux navigation so the same keys move between Neovim splits *and* tmux panes seamlessly. These work in **normal and terminal** mode and override the `<C-w>` fallbacks defined in `keymaps.lua`.

| Keybind | Mode | Action | Description |
|---------|------|--------|-------------|
| `<C-h>` | Normal/Terminal | `NavigatorLeft` | Move to left split / tmux pane |
| `<C-l>` | Normal/Terminal | `NavigatorRight` | Move to right split / tmux pane |
| `<C-j>` | Normal/Terminal | `NavigatorDown` | Move to lower split / tmux pane |
| `<C-k>` | Normal/Terminal | `NavigatorUp` | Move to upper split / tmux pane |

### Terminal Integration
*Source: `keymaps.lua`*

| Keybind | Mode | Action | Description |
|---------|------|--------|-------------|
| `<Esc><Esc>` | Terminal | `<C-\><C-n>` | Exit terminal mode |
| `<C-q>` | Terminal | `<C-\><C-n>` | Exit terminal mode |

### Basic Operations
*Source: `keymaps.lua`*

| Keybind | Mode | Action | Description |
|---------|------|--------|-------------|
| `<Esc>` | Normal | `<cmd>nohlsearch<CR>` | Clear search highlighting |
| `<C-s>` | Normal | `:w<CR>` | Save file (quick save) |
| `<C-q>` | Normal | `:q<CR>` | Quit current window |
| `jk` | Insert | `<Esc><Esc>` | Exit insert mode |
| `Q` | Normal | `<nop>` | Disabled (no Ex mode) |

### Scrolling
*Source: `custom/plugins/neoscroll.lua`*

Animated scrolling with **smart centering** — the cursor only re-centers (`zz`) when mid-buffer, not at the top or bottom edge (handled by `neoscroll`'s `post_hook`).

| Keybind | Mode | Action | Description |
|---------|------|--------|-------------|
| `<C-d>` | Normal | `neoscroll.ctrl_d` | Half page down (animated, smart center) |
| `<C-u>` | Normal | `neoscroll.ctrl_u` | Half page up (animated, smart center) |
| `<C-f>` | Normal | `neoscroll.ctrl_f` | Full page down (animated) |
| `<C-b>` | Normal | `neoscroll.ctrl_b` | Full page up (animated) |

---

## File Management

### Oil
*Source: `custom/plugins/oil.lua`*

| Keybind | Mode | Action | Description |
|---------|------|--------|-------------|
| `<C-e>` | Normal | `require('oil').toggle_float()` | Toggle Oil float (cursor on current file) |

**Inside an Oil buffer:**

| Keybind | Action | Description |
|---------|--------|-------------|
| `<CR>` / `L` | `actions.select` | Open file / enter directory |
| `<C-s>` | `actions.select` (vertical) | Open in vertical split |
| `<C-h>` | `actions.select` (horizontal) | Open in horizontal split |
| `<C-t>` | `actions.select` (tab) | Open in new tab |
| `<C-p>` | `actions.preview` | Preview file |
| `<C-l>` | `actions.refresh` | Refresh listing |
| `<C-c>` / `<C-e>` / `q` | `actions.close` | Close Oil |
| `H` / `-` | `actions.parent` | Go to parent directory |
| `_` | `actions.open_cwd` | Open current working directory |
| `` ` `` | `actions.cd` | `:cd` to directory |
| `~` | `actions.cd` (tab scope) | `:tcd` to directory |
| `g?` | `actions.show_help` | Show Oil help |

---

## Git Operations

### Neogit
*Source: `custom/plugins/neo-git.lua`*

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
| `<leader>gP` | `:Neogit pull<CR>` | Pull |
| `<leader>gp` | `:Neogit push<CR>` | Push |

### Git Worktree
*Source: `custom/plugins/git-worktree.lua`*

| Keybind | Action | Description |
|---------|--------|-------------|
| `<leader>gwc` | `create_git_worktree()` | Create worktree |
| `<leader>gwl` | `git_worktrees()` | List / switch worktree (`C-d` to delete) |

### Gitsigns
*Source: `custom/plugins/gitsigns.lua`* — buffer-local when attached to a tracked file.

| Keybind | Action | Description |
|---------|--------|-------------|
| `]c` | `nav_hunk 'next'` | Jump to next git change |
| `[c` | `nav_hunk 'prev'` | Jump to previous git change |
| `<leader>tb` | `toggle_current_line_blame` | Toggle git blame line |
| `<leader>tD` | `preview_hunk_inline` | Toggle inline deleted/preview hunk |

---

## Search & LSP

### Telescope
*Source: `custom/plugins/telescope.lua`*

| Keybind | Action | Description |
|---------|--------|-------------|
| `<leader>sh` | `builtin.help_tags` | Search Help |
| `<leader>sk` | `builtin.keymaps` | Search Keymaps |
| `<leader>sf` | `builtin.find_files` | Search Files |
| `<leader>ss` | `builtin.builtin` | Select Telescope picker |
| `<leader>sw` | `builtin.grep_string` | Search current Word |
| `<leader>sg` | `builtin.live_grep` | Search by Grep |
| `<leader>sd` | `builtin.diagnostics` | Search Diagnostics |
| `<leader>sr` | `builtin.resume` | Resume last search |
| `<leader>s.` | `builtin.oldfiles` | Search Recent Files |
| `<leader><leader>` | `builtin.buffers` | Find existing buffers |
| `<leader>/` | `current_buffer_fuzzy_find` | Fuzzy search in current buffer |
| `<leader>s/` | `live_grep` (open files) | Live grep in open files only |
| `<leader>sn` | `find_files` (config dir) | Search Neovim config |

### LSP
*Source: `custom/plugins/lspconfig.lua`* — buffer-local, registered on `LspAttach`.

| Keybind | Mode | Action | Description |
|---------|------|--------|-------------|
| `gd` | Normal | `lsp_definitions` | Goto definition |
| `gr` | Normal | `lsp_references` | Goto references |
| `gI` | Normal | `lsp_implementations` | Goto implementation |
| `gD` | Normal | `vim.lsp.buf.declaration` | Goto declaration |
| `<leader>D` | Normal | `lsp_type_definitions` | Type definition |
| `<leader>so` | Normal | `lsp_document_symbols` | Document symbols |
| `<leader>sW` | Normal | `lsp_dynamic_workspace_symbols` | Workspace symbols |
| `<leader>rn` | Normal | `vim.lsp.buf.rename` | Rename symbol |
| `<leader>ca` | Normal/Visual | `vim.lsp.buf.code_action` | Code action |
| `<leader>th` | Normal | toggle inlay hints | Toggle inlay hints (if supported) |

> **Overload:** `<leader>D` is globally **Delete to void register** (see [Text Editing](#text-editing)), but is **buffer-locally remapped** to *LSP type definition* when an LSP attaches.

### Folds (nvim-ufo)
*Source: `custom/plugins/nvim-ufo.lua`*

| Keybind | Action | Description |
|---------|--------|-------------|
| `zR` | `openAllFolds` | Open all folds |
| `zM` | `closeAllFolds` | Close all folds |
| `zK` | `peekFoldedLinesUnderCursor` | Peek folded lines (falls back to LSP hover) |

---

## Text Editing

### Enhanced Editing
*Source: `keymaps.lua`*

| Keybind | Mode | Action | Description |
|---------|------|--------|-------------|
| `Y` | Normal | `y$` | Yank to end of line |
| `==` | Normal | `gg<S-v>G` | Select all text |
| `J` | Normal | ``mzJ`z`` | Join lines (keep cursor position) |
| `n` | Normal | `n` + smart `zzzv` | Next search (centers only mid-buffer) |
| `N` | Normal | `N` + smart `zzzv` | Previous search (centers only mid-buffer) |

### Clipboard Operations
*Source: `keymaps.lua`*

| Keybind | Mode | Action | Description |
|---------|------|--------|-------------|
| `<leader>y` | Normal/Visual | `"+y` | Yank to system clipboard |
| `<leader>Y` | Normal | `"+Y` | Yank line to system clipboard |
| `<leader>D` | Normal/Visual | `"_d` | Delete to void register (see LSP overload) |
| `p` | Visual | `"_dP` | Paste without overwriting register |

### Formatting (conform.nvim)
*Source: `custom/plugins/conform.lua`*

| Keybind | Mode | Action | Description |
|---------|------|--------|-------------|
| `<leader>l` | Normal/Visual | `conform.format` | Format file or range |

> **Conflict:** `<leader>l` (format) shadows the start of the `[L]ocation List` which-key group (`<leader>ln` / `<leader>lp` below). Pressing `<leader>l` formats immediately rather than waiting for the location-list sub-key.

---

## Buffer Management

### Buffer Operations
*Source: `keymaps.lua` and `custom/plugins/snacks.lua`*

| Keybind | Action | Description | Source |
|---------|--------|-------------|--------|
| `<leader>bq` | `<cmd>bd<CR>` | Close buffer | `keymaps.lua` |
| `<leader>bw` | `:bp\|bd #<CR>` | Close buffer, retain split | `keymaps.lua` |
| `<leader>bd` | `Snacks.bufdelete()` | Delete current buffer | `snacks.lua` |
| `<leader>ba` | `Snacks.bufdelete.all()` | Delete all buffers | `snacks.lua` |
| `<leader>bo` | `Snacks.bufdelete.other()` | Delete other buffers | `snacks.lua` |

### Quickfix & Location Lists
*Source: `keymaps.lua`*

| Keybind | Action | Description |
|---------|--------|-------------|
| `<leader>qn` | `<cmd>cnext<CR>zz` | Next quickfix item |
| `<leader>qp` | `<cmd>cprev<CR>zz` | Previous quickfix item |
| `<leader>ln` | `<cmd>lnext<CR>zz` | Next location item |
| `<leader>lp` | `<cmd>lprev<CR>zz` | Previous location item |

### Diagnostics
*Source: `keymaps.lua`*

| Keybind | Action | Description |
|---------|--------|-------------|
| `<leader>dq` | `vim.diagnostic.setloclist` | Open diagnostic location list |

---

## AI Integrations

### Claude Code
*Source: `custom/plugins/claude.lua`* — `coder/claudecode.nvim`.

| Keybind | Mode | Action | Description |
|---------|------|--------|-------------|
| `<M-;>` | Normal | `<cmd>ClaudeCode<cr>` | Toggle Claude Code |
| `<M-;>` | Terminal | `toggle_claude_no_focus` | Toggle Claude (keep focus) |
| `<leader>cc` | Normal | `<cmd>ClaudeCode<cr>` | Toggle Claude Code |
| `<leader>cf` | Normal | `<cmd>ClaudeCodeFocus<cr>` | Focus Claude window |
| `<leader>cm` | Normal | `<cmd>ClaudeCodeSelectModel<cr>` | Select Claude model |
| `<leader>cr` | Normal | `<cmd>ClaudeCode --resume<cr>` | Resume session |
| `<leader>cC` | Normal | `<cmd>ClaudeCode --continue<cr>` | Continue session |
| `<leader>cb` | Normal | `add_current_buffer` | Add current buffer |
| `<leader>cB` | Normal | `send_all_buffers` | Add all buffers |
| `<leader>cs` | Visual | `<cmd>ClaudeCodeSend<cr>` | Send selection |
| `<leader>cS` | Normal | `<cmd>ClaudeCodeSend<cr>` | Send current line |
| `<leader>ca` | Normal | `<cmd>ClaudeCodeTreeAdd<cr>` | Add file from tree (Oil / mini.files) |
| `<leader>c?` | Normal | `<cmd>help claudecode<cr>` | Claude Code help |
| `<leader>cq` | Normal | `<cmd>ClaudeCode --quit<cr>` | Quit Claude Code |

### OpenCode
*Source: `custom/plugins/opencode.lua`* — `NickvanDyke/opencode.nvim`.

| Keybind | Mode | Action | Description |
|---------|------|--------|-------------|
| `<M-'>` | Normal/Terminal | `require('opencode').toggle()` | Toggle OpenCode |
| `<leader>Oa` | Normal/Visual | `opencode.ask('@this: ')` | Ask OpenCode about context |
| `<leader>Ox` | Normal/Visual | `opencode.select()` | Select / execute action |
| `go` | Normal/Visual | `opencode.operator('@this ')` | Add range to OpenCode (operator) |
| `goo` | Normal | `opencode.operator` (line) | Add current line to OpenCode |

### Supermaven
*Source: `custom/plugins/super-maven.lua`* — AI inline completion.

| Keybind | Mode | Action | Description |
|---------|------|--------|-------------|
| `<C-y>` | Insert | `accept_suggestion` | Accept suggestion |
| `<C-]>` | Insert | `clear_suggestion` | Clear suggestion |
| `<C-j>` | Insert | `accept_word` | Accept next word |

---

## Plugin Specific

### Harpoon
*Source: `custom/plugins/harpoon.lua`* — quick file marks and jumps.

| Keybind | Action | Description |
|---------|--------|-------------|
| `<leader>ha` | `mark.add_file` | Mark current file |
| `<leader>hh` | `ui.toggle_quick_menu` | Toggle Harpoon menu |
| `<leader>1` … `<leader>6` | `ui.nav_file(1..6)` | Jump to harpoon file 1–6 |

### Obsidian
*Source: `custom/plugins/obsidian.lua`* — uses the modern `:Obsidian <subcmd>` syntax. Bindings are buffer-local in the vault.

| Keybind | Mode | Action | Description |
|---------|------|--------|-------------|
| `<leader>oc` | Normal | `util.toggle_checkbox()` | Toggle checkbox |
| `<leader>oc` | Visual | toggle range | Toggle checkboxes in selection |
| `<leader>on` | Normal | `:Obsidian new<CR>` | New note |
| `<leader>oo` | Normal | `:Obsidian open<CR>` | Open in Obsidian app |
| `<leader>of` | Normal | `:Obsidian quick_switch<CR>` | Find / quick switch note |
| `<leader>or` | Normal | rename | Rename note |
| `<leader>oT` | Normal | `:Obsidian new_from_template<CR>` | New note from template |
| `<leader>op` | Normal | `:Obsidian template<CR>` | Insert template |
| `<leader>os` | Normal | `:Obsidian search<CR>` | Search vault |
| `<leader>ob` | Normal | backlinks | Show backlinks |
| `<leader>ol` | Normal | `:Obsidian links<CR>` | Show links |
| `<leader>ot` | Normal | `:Obsidian tags<CR>` | Show tags |
| `<leader>oF` | Normal | `:Obsidian follow_link<CR>` | Follow link |
| `<leader>ox` | Normal | `:Obsidian toc<CR>` | Table of contents |
| `<leader>od` | Normal | `:Obsidian today<CR>` | Today's daily note |
| `<leader>oy` | Normal | `:Obsidian yesterday<CR>` | Yesterday's note |
| `<leader>om` | Normal | `:Obsidian tomorrow<CR>` | Tomorrow's note |
| `<leader>ow` | Normal | `:Obsidian workspace<CR>` | Switch workspace |
| `<leader>oi` | Normal | `:Obsidian paste_img<CR>` | Paste image |
| `<leader>oe` | Visual | `:Obsidian extract_note<CR>` | Extract note |
| `<leader>oL` | Visual | `:Obsidian link<CR>` | Link selection |
| `<leader>oln` | Visual | `:Obsidian link_new<CR>` | Link to new note |
| `<leader>ch` | Normal | `util.toggle_checkbox()` | Toggle checkbox (alias) |

### Sessions (mini.sessions)
*Source: `custom/plugins/mini.lua`*

| Keybind | Action | Description |
|---------|--------|-------------|
| `<leader>Ss` | write (prompt name) | Save session |
| `<leader>Sw` | write current | Save current session |
| `<leader>Sh` | dashboard | Close all + show dashboard |
| `<leader>Sn` | read `notes` | Open Notes session |
| `<leader>Sd` | read `dotfiles` | Open Dotfiles session |
| `<leader>Sc` | read `code` | Open Code session |
| `<leader>Sl` | select read | Load session (picker) |
| `<leader>Sr` | read (prompt name) | Restore session by name |
| `<leader>Sx` | select delete | Delete session (picker) |

### UV (Python)
*Source: `custom/plugins/uv.lua`* — `<leader>u*` shows the uv project menu; `<leader>x*` runs commands.

| Keybind | Description |
|---------|-------------|
| `<leader>u` | uv commands menu (prefix) |
| `<leader>x` | uv commands menu |
| `<leader>xr` | Run current file |
| `<leader>xs` | Run selection |
| `<leader>xf` | Run function |
| `<leader>xe` | Environment management |
| `<leader>xi` | Init uv project |
| `<leader>xa` / `<leader>xd` | Add / remove package |
| `<leader>xc` / `<leader>xC` | Sync / sync all |

### Debugging (nvim-dap)
*Source: `custom/plugins/debug.lua`*

| Keybind | Action | Description |
|---------|--------|-------------|
| `<leader>ds` | `dap.continue()` | Start / continue |
| `<leader>di` | `dap.step_into()` | Step into |
| `<leader>do` | `dap.step_over()` | Step over |
| `<leader>du` | `dap.step_out()` | Step out |
| `<leader>b` | `dap.toggle_breakpoint()` | Toggle breakpoint |
| `<leader>B` | `dap.set_breakpoint(...)` | Conditional breakpoint |
| `<leader>dd` | `dapui.toggle()` | Toggle DAP UI / last result |

### UI Toggles & Misc
*Sources: `keymaps.lua`, `mini.lua`, `transparent.lua`, `noice.lua`, `notify.lua`, `image.lua`, `snacks.lua`*

| Keybind | Action | Description | Source |
|---------|--------|-------------|--------|
| `<leader>tm` | `<cmd>Markview<CR>` | Toggle Markview | `keymaps.lua` |
| `<leader>tt` | transparent toggle | Toggle transparency | `transparent.lua` |
| `<leader>td` | `mini.diff` toggle overlay | Toggle MiniDiff overlay | `mini.lua` |
| `<leader>tz` | `Snacks.zen()` | Toggle Zen mode | `snacks.lua` |
| `<leader>tT` | `Snacks.terminal.toggle()` | Toggle floating terminal | `snacks.lua` |
| `<leader>z` | `<cmd>NoiceDismiss<CR>` | Dismiss Noice message | `noice.lua` |
| `<leader>sl` | `<cmd>Telescope notify<CR>` | Search notification log | `notify.lua` |
| `<leader>pi` | `<cmd>PasteImage<CR>` | Paste image | `image.lua` |

---

## Quick Reference

### Most Used Keybinds

```
Files:        <C-e> (Oil float)
Search:       <leader>sf (files), <leader>sg (grep), <leader><leader> (buffers)
Git:          <leader>gg (Neogit), <leader>gp (push), <leader>gc (commit)
Navigation:   <C-hjkl> (splits + tmux panes), jk (exit insert)
Files (nav):  <leader>1-6 (Harpoon), <leader>ha (mark), <leader>hh (menu)
Editing:      <leader>y (system yank), Y (yank line), <leader>l (format)
AI:           <M-;> (Claude Code), <M-'> (OpenCode), <C-y> (Supermaven accept)
```

### Leader Key Groups

| Prefix | Group |
|--------|-------|
| `<leader>g*` | Git (Neogit, gitsigns); `<leader>gw*` worktree |
| `<leader>s*` | Search (Telescope, LSP symbols) |
| `<leader>o*` | Obsidian |
| `<leader>O*` | OpenCode |
| `<leader>c*` | Claude Code |
| `<leader>h*` + `<leader>1`–`6` | Harpoon |
| `<leader>b*` | Buffers |
| `<leader>t*` | UI toggles |
| `<leader>S*` | Sessions (mini.sessions) |
| `<leader>u*` / `<leader>x*` | uv (Python) |
| `<leader>q*` | Quickfix |
| `<leader>l*` | Location list (note: `<leader>l` alone = format) |
| `<leader>d*` | Diagnostics / debug |

---

## Configuration Context

### Which-Key Integration
The configuration uses which-key (`custom/plugins/which-key.lua`) for contextual help; leader-key prefixes surface available sub-keys after a short delay.

### Tmux Integration
`<C-h/j/k/l>` (Navigator.nvim) move between Neovim splits and tmux panes interchangeably, in both normal and terminal mode. This is integration by design — the same keys are deliberately shared with tmux's non-prefix navigation.

### AI Stack
- **Claude Code** (`<M-;>`, `<leader>c*`) — primary agentic assistant.
- **OpenCode** (`<M-'>`, `<leader>O*`) — alternative assistant.
- **Supermaven** (`<C-y>`/`<C-]>`/`<C-j>`) — inline completion.

---

## Related Documentation

- [Main Keybinds](KEYBINDS.md) — System-wide keybinds and aliases
- [Workflow Guides](WORKFLOW_GUIDES.md) — Cross-tool integration workflows
- [CLAUDE.md](../CLAUDE.md) — Main dotfiles documentation

---

## Author

**cyperx** — [GitHub Profile](https://github.com/cyperx84)

Neovim config lives in its own repository: [github.com/cyperx84/nvim](https://github.com/cyperx84/nvim). For dotfiles issues or contributions, visit the [dotfiles repository](https://github.com/cyperx84/dotfiles).
