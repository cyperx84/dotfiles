---
description: Use when the user wants to customize keyboard shortcuts, rebind keys, add chord bindings, or modify ~/.claude/keybindings.json. Examples: "rebind ctrl+s", "add a chord shortcut", "change the submit key", "customize keybindings".
---

# Keybindings Help Skill

Help users customize Claude Code keyboard shortcuts while avoiding conflicts with their environment.

## User Environment

This user runs Claude Code inside NeoVim terminal. Keybindings must be cross-referenced against:
- NeoVim keymaps: `~/.config/nvim/lua/keymaps.lua`
- Plugin keymaps: `~/.config/nvim/lua/custom/plugins/`

## Key Files

- **Current bindings**: `~/.claude/keybindings.json`
- **Backup**: `~/.claude/keybindings.json.backup`
- **Schema**: https://platform.claude.com/docs/schemas/claude-code/keybindings.json
- **Docs**: https://code.claude.com/docs/en/keybindings

## Known NeoVim Conflicts to Avoid

These keys are used by the user's NeoVim setup and should NOT be used in Claude Code:

| Key | NeoVim Usage |
|-----|--------------|
| `Ctrl+S` | Save file (`:w`) |
| `Ctrl+E` | Oil toggle float |
| `Ctrl+T` | Oil open in tab |
| `Ctrl+H/J/K/L` | Window navigation |
| `Ctrl+P` | Oil preview |
| `Ctrl+R` | Shell history search |
| `Ctrl+O` | Yazi open/pick window |
| `Ctrl+V` | Yazi vertical split |
| `Ctrl+G` | NeoVim print file info |
| `Ctrl+Q` | Quit buffer |

## Safe Modifier Combinations

Use these to avoid conflicts:
- `Ctrl+Shift+<key>` - Generally safe
- `Meta+<key>` (Alt/Option) - Safe except `M-j/k/l/u/i/o` (Harpoon)
- `Ctrl+/` - Safe alternative for search

## Current Modified Bindings

| Action | New Binding | Original |
|--------|-------------|----------|
| Toggle Todos | `Ctrl+Shift+T` | `Ctrl+T` |
| Toggle Transcript | `Ctrl+Shift+X` | `Ctrl+O` |
| History Search | `Ctrl+/` | `Ctrl+R` |
| Chat Stash | `Ctrl+Shift+S` | `Ctrl+S` |
| External Editor | `Ctrl+Shift+G` | `Ctrl+G` |
| Toggle Explanation | `Ctrl+Shift+E` | `Ctrl+E` |

## Workflow for Keybinding Changes

1. Always read current `~/.claude/keybindings.json` first
2. Create backup before modifications: `cp keybindings.json keybindings.json.backup`
3. Cross-reference against NeoVim config for conflicts
4. Apply changes to the keybindings.json file
5. Inform user to restart Claude Code for changes to take effect

## Rollback

```bash
cp ~/.claude/keybindings.json.backup ~/.claude/keybindings.json
```
