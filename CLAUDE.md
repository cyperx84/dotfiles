---
id: CLAUDE
tags:
  - claude-md
---

# CLAUDE.md

Guidance for Claude Code when working with this **macOS + Linux dotfiles monorepo**.
Mac configs live in `mac/`, Linux configs in `linux/`. Stow is run from the platform
subdirectory, never from the repo root.

## 📍 Repo Structure

```
dotfiles/
  mac/      ← stow from here on macOS   (target: ~)
  linux/    ← stow from here on Linux   (target: /home/cyperx, via linux/.stowrc)
  docs/     ← documentation (shared)
  .claude/  ← repo tooling: agents, commands, skills for working ON these dotfiles
```

Provision a fresh machine with `mac/bootstrap.sh` or `linux/bootstrap.sh`.

## 📍 Critical File Locations (macOS)

```
mac/zsh/.zshrc                                       # Shell: aliases, functions, keybinds
mac/starship/.config/starship/starship.toml         # Shell prompt (active config)
mac/tmux/.tmux.conf                                  # Multiplexer: Ctrl+A prefix
~/.config/nvim/lua/keymaps.lua                       # Neovim keybinds (standalone repo)
mac/aerospace/.config/aerospace/aerospace.toml       # Window manager
mac/borders/.config/borders/bordersrc                # Window borders
mac/ghostty/.config/ghostty/config                   # Terminal
mac/sketchybar/.config/sketchybar/sketchybarrc       # Menu bar
mac/kanata/.config/kanata/kanata.kbd                 # Keyboard remapper (ACTIVE)
mac/herdr/.config/herdr/config.toml                  # AI-agent multiplexer: Ctrl+A prefix, mirrors tmux
mac/macos/Brewfile, mac/macos/setup.sh               # Machine provisioning
```

## 📍 Critical File Locations (Linux / Omarchy)

```
linux/zsh/.zshrc                                     # Shell
linux/hypr/.config/hypr/                             # Hyprland (bindings, monitors, looknfeel)
linux/waybar/                                        # Status bar
linux/walker/                                        # Launcher
linux/kanata/.config/kanata/config.kbd              # Keyboard remapper (Linux)
linux/.stowrc                                        # Targets /home/cyperx
```

## 🎯 User Intent Mapping

| User Query | Reference |
|------------|-----------|
| "Keybinds" / "Shortcuts" | docs/KEYBINDS.md, docs/NEOVIM_KEYBINDS.md |
| "How tools work together" | docs/WORKFLOW_GUIDES.md |
| "Component details" | docs/COMPONENTS.md |
| "Not working" / "Broken" | docs/MAINTENANCE.md |
| "Local LLM" / "MLX" / "Gemma" / "OpenClaw" / "Hermes" | docs/MLX_GEMMA_SETUP.md |
| "Provisioning" / "New Mac" / "Brewfile" | mac/macos/Brewfile, mac/macos/setup.sh, docs/MAINTENANCE.md |
| "Linux" / "Omarchy" / "Hyprland" | linux/, linux/bootstrap.sh |
| "Tailscale" / "SSH" / "tailnet" / "remote access" | moved to vault (`notes/systems/tailscale-ssh.md`) — machine topology, not repo-tied |

## ⚠️ CRITICAL - Do NOT Do These

1. **DO NOT** modify without explicit request:
   - `mac/zsh/.zshrc` `brew()` function — removing `sketchybar --trigger brew_update` breaks menu bar
   - Aerospace keybindings — carefully designed layout
   - Stow directory structure — breaking symlinks breaks the entire setup

2. **DO NOT** create new documentation files unless explicitly requested

3. **DO NOT** change:
   - Kanata config filename (`kanata.kbd` is correct on macOS, NOT `config.kbd`)
   - Tmux prefix (`Ctrl+A` is intentional, not `Ctrl+B`)
   - Aerospace gap sizes (20px inner, 52px top is required for SketchyBar)

4. **ALWAYS** run validation before declaring changes complete: `mac/scripts/test_dotfiles.sh` (full suite) and `~/.config/sketchybar/test_sketchybar.sh` (menu bar plugins)

## 🤖 Agent Guidelines

- Read relevant docs before modifying anything
- Test stow changes before applying, from the correct platform subdir:
  - macOS: `cd ~/dotfiles/mac && stow -nv <component>`
  - Linux: `cd ~/dotfiles/linux && stow -nv <component>`
- After changes restart services in order: Aerospace → borders → sketchybar
- Nvim is a **standalone repo** at `~/.config/nvim` (github.com/cyperx84/nvim) — commit/push directly from there, no dotfiles pointer to update

## 🏗️ Architecture Overview

GNU Stow-managed monorepo (macOS + Linux):
- **macOS — Window mgmt**: Aerospace (tiling, PRIMARY) → JankyBorders (borders) → SketchyBar (menu bar, 40 plugins)
- **macOS — Terminal stack**: Ghostty → Tmux (Ctrl+A prefix, 10+ plugins) → Zsh → Starship (prompt)
- **macOS — Input**: Kanata (ACTIVE, LaunchDaemon) — Karabiner DriverKit pinned to 6.6.0
- **macOS — Automation**: Hammerspoon (ACTIVE) — focus-follows-mouse only, raises the window under the cursor
- **Linux — Window mgmt**: Hyprland → Waybar → Walker (Omarchy layer)
- **Linux — Input**: Kanata (`config.kbd`)
- **Editor (shared)**: Neovim (kickstart.nvim base, standalone repo at `~/.config/nvim`)
- **Provisioning**: `mac/macos/Brewfile` + `mac/macos/setup.sh` mirror this machine onto a fresh Mac (see provision-mac-twin skill); `linux/bootstrap.sh` for Omarchy
- **Claude config**: lives in its own repo (`dotclaude`), NOT in this dotfiles repo

## 🔧 Service Management (macOS)

```bash
killall AeroSpace && open -a AeroSpace                     # Restart Aerospace
killall borders && borders &                               # Restart borders
sketchybar --reload                                        # Reload SketchyBar
sudo launchctl kickstart -k system/com.example.kanata      # Restart Kanata
tmux source-file ~/.tmux.conf                              # Reload tmux
hs -c "hs.reload()" || killall Hammerspoon                 # Reload Hammerspoon
exec zsh                                                   # Reload shell
~/.config/sketchybar/test_sketchybar.sh                   # Test SketchyBar plugins
```

## 🔑 Key Integration Notes

- **Kanata binary**: MUST use `/opt/homebrew/bin/kanata` (Homebrew symlink) — direct Cellar path breaks TCC permissions on `brew upgrade`. kanata needs **two** TCC grants for that path — **Input Monitoring** *and* **Accessibility** — and a binary upgrade drops both, surfacing them one at a time (see docs/MAINTENANCE.md → "Kanata Stops Working After `brew upgrade`")
- **Kanata logs**: `/tmp/kanata.out.log`, `/tmp/kanata.err.log`
- **SketchyBar helper**: C binary at `~/.config/sketchybar/helper/` — recompile with `make clean && make` if system metrics plugins fail
- **Temperature plugin**: Uses `smctemp` TH0x (heatsink) sensor — M4 die sensors (TCMb) read 90°C+ at idle which is normal/misleading
- **Hammerspoon**: single-purpose focus-follows-mouse (`mac/hammerspoon/.hammerspoon/init.lua`) — polls every 50ms via the Accessibility API, with explicit guards so it does NOT steal focus from dialogs/sheets/System Settings or the emoji picker. Needs Accessibility permission; touch carefully — it interacts with Aerospace focus
- **Claude config**: moved out of this repo into its own `dotclaude` repo — there is no `claude/` package here anymore

## 📋 Code Style

- Bash: `#!/usr/bin/env bash`
- Lua: kickstart.nvim patterns, modular plugin structure
- Stow: keep directory structure matching target locations (`mac/<component>/.config/tool/`, `linux/<component>/.config/tool/`)
