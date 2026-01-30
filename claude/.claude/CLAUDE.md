# User Preferences & Environment

## Environment Context
- User runs Claude Code inside NeoVim terminal (Neo VM)
- Keybindings have been modified to avoid conflicts with NeoVim
- Dotfiles are symlinked from `~/dotfiles/claude/.claude/`

## Critical Rules
- Don't run `tmux kill-server` while in tmux
- When modifying keybindings, always create a `.backup` file first for easy rollback
- Cross-reference any keybinding changes against NeoVim config at `~/.config/nvim/`

## Claude Code Directory Structure

When creating skills/commands for Claude Code, use the correct locations:

- **Slash Commands** (user-invoked with `/command`): `.claude/commands/command-name.md`
- **Agent Skills** (model-invoked based on context): `.claude/skills/skill-name/SKILL.md`

**DO NOT** use `.skills/` or any other custom directory - Claude Code only recognizes `.claude/commands/` and `.claude/skills/`.

Slash command frontmatter format:
```yaml
---
allowed-tools: Read, Write, Edit, Grep, Glob
description: Brief description of what the command does
---
```

## NeoVim Keybinding Conflicts

Claude Code keybindings have been modified to avoid conflicts with user's NeoVim setup. See `~/.claude/keybindings.json` for current bindings.

### Modified Bindings (NeoVim-Safe)

| Action | Binding | Avoided Conflict |
|--------|---------|------------------|
| Toggle Todos | `Ctrl+Shift+T` | Oil `<C-t>` |
| Toggle Transcript | `Ctrl+Shift+X` | Yazi `<c-o>` |
| History Search | `Ctrl+/` | Shell `<C-r>` |
| Chat Stash | `Ctrl+Shift+S` | NeoVim `:w` |
| External Editor | `Ctrl+Shift+G` | NeoVim file info |
| Toggle Explanation | `Ctrl+Shift+E` | Oil toggle |

### NeoVim Plugins with Keybindings
User has these plugins with keybindings that may conflict:
- **Navigator/tmux**: `<C-h/j/k/l>` for window navigation (normal + terminal mode)
- **Oil**: `<C-s>`, `<C-t>`, `<C-e>`, `<C-p>`, `<C-h>`, `<C-l>`
- **Yazi**: `<c-v>`, `<c-s>`, `<c-g>`, `<c-o>`, `<c-q>`
- **Harpoon**: `<M-j/k/l/u/i/o>` for file navigation
- **Telescope**: `<leader>s*` for search functions

### Rollback Instructions
```bash
cp ~/.claude/keybindings.json.backup ~/.claude/keybindings.json
```

## NeoVim Config Location
- Main config: `~/.config/nvim/init.lua`
- Keymaps: `~/.config/nvim/lua/keymaps.lua`
- Plugin configs: `~/.config/nvim/lua/custom/plugins/`

## User Preferences
- Prefers vim-style navigation (`j/k` keys)
- Uses leader key (Space) for most operations
- Has transparent backgrounds enabled in NeoVim
- Uses Harpoon for quick file switching
