---
id: CLAUDE
tags:
  - claude-md
---

# CLAUDE.md

Guidance for Claude Code when working with this macOS dotfiles repository.

## 📍 Critical File Locations

```
zsh/.zshrc                                     # Shell: aliases, functions, keybinds
tmux/.tmux.conf                                # Multiplexer: Ctrl+A prefix
~/.config/nvim/lua/keymaps.lua                # Neovim keybinds (standalone repo)
aerospace/.config/aerospace/aerospace.toml    # Window manager
borders/.config/borders/bordersrc             # Window borders
ghostty/.config/ghostty/config               # Terminal
sketchybar/.config/sketchybar/sketchybarrc   # Menu bar
kanata/.config/kanata/kanata.kbd             # Keyboard remapper (ACTIVE)
```

## 🎯 User Intent Mapping

| User Query | Reference |
|------------|-----------|
| "Keybinds" / "Shortcuts" | docs/KEYBINDS.md, docs/NEOVIM_KEYBINDS.md |
| "How tools work together" | docs/WORKFLOW_GUIDES.md |
| "Component details" | docs/COMPONENTS.md |
| "Not working" / "Broken" | docs/MAINTENANCE.md |
| "Statusline" / "Context" | docs/CLAUDE_STATUSLINE.md |
| "Multi-LLM" / "AI workflow" | docs/MULTI_LLM_WORKFLOW.md |

## ⚠️ CRITICAL - Do NOT Do These

1. **DO NOT** modify without explicit request:
   - `zsh/.zshrc` `brew()` function — removing `sketchybar --trigger brew_update` breaks menu bar
   - Aerospace keybindings — carefully designed layout
   - Stow directory structure — breaking symlinks breaks the entire setup

2. **DO NOT** create new documentation files unless explicitly requested

3. **DO NOT** change:
   - Kanata config filename (`kanata.kbd` is correct, NOT `config.kbd`)
   - Tmux prefix (`Ctrl+A` is intentional, not `Ctrl+B`)
   - Aerospace gap sizes (20px inner, 52px top is required for SketchyBar)

4. **ALWAYS** run validation scripts before declaring changes complete

## 🤖 Agent Guidelines

- Read relevant docs before modifying anything
- Test stow changes with `stow -nv <component>` before applying
- After changes restart services in order: Aerospace → borders → sketchybar
- Nvim is a **standalone repo** at `~/.config/nvim` (github.com/cyperx84/nvim) — commit/push directly from there, no dotfiles pointer to update

## 🏗️ Architecture Overview

GNU Stow-managed macOS environment:
- **Window mgmt**: Aerospace (tiling, PRIMARY) → JankyBorders (borders) → SketchyBar (menu bar, 40 plugins)
- **Terminal stack**: Ghostty → Tmux (Ctrl+A prefix, 10+ plugins) → Zsh
- **Editor**: Neovim (kickstart.nvim base, standalone repo at `~/.config/nvim`)
- **Input**: Kanata (ACTIVE, LaunchDaemon) — Karabiner installed but unconfigured

## 🔧 Service Management

```bash
killall AeroSpace && open -a AeroSpace                     # Restart Aerospace
killall borders && borders &                               # Restart borders
sketchybar --reload                                        # Reload SketchyBar
sudo launchctl kickstart -k system/com.example.kanata      # Restart Kanata
tmux source-file ~/.tmux.conf                              # Reload tmux
exec zsh                                                   # Reload shell
~/.config/sketchybar/test_sketchybar.sh                   # Test SketchyBar plugins
```

## 🔑 Key Integration Notes

- **Kanata binary**: MUST use `/opt/homebrew/bin/kanata` (Homebrew symlink) — direct Cellar path breaks TCC Input Monitoring permissions on `brew upgrade`
- **Kanata logs**: `/tmp/kanata.out.log`, `/tmp/kanata.err.log`
- **SketchyBar helper**: C binary at `~/.config/sketchybar/helper/` — recompile with `make clean && make` if system metrics plugins fail
- **Temperature plugin**: Uses `smctemp` TH0x (heatsink) sensor — M4 die sensors (TCMb) read 90°C+ at idle which is normal/misleading
- **MCP/MCPHub**: Config at `mcp/.config/mcp/servers.json`, Neovim access via `<leader>m`
- **Claude slash commands**: `/bridge`, `/eval`, `/verify`, `/prompt-improve` in `claude/.claude/commands/`

## 📋 Code Style

- Bash: `#!/usr/bin/env bash`
- Lua: kickstart.nvim patterns, modular plugin structure
- Stow: keep directory structure matching target locations (`component/.config/tool/`)
