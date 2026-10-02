---
id: AGENTS
tags:
  - agents-md
---

# AGENTS.md

Guidance for coding agents (Claude Code, Codex, opencode, pi, ...) working with this **macOS + Linux dotfiles monorepo**.
Mac configs live in `mac/`, Linux configs in `linux/`. Stow is run from the platform
subdirectory, never from the repo root.

## 📍 Repo Structure

```
dotfiles/
  mac/      ← stow from here on macOS   (target: ~)
  linux/    ← stow from here on Linux   (target: /home/cyperx, via linux/.stowrc)
  omarchy/  ← stow from here on Omarchy (target: $HOME, via omarchy/.stowrc)
  docs/     ← documentation (shared)
  .claude/  ← repo tooling: agents, commands, skills for working ON these dotfiles
```

Provision a fresh machine with `mac/bootstrap.sh` or `linux/bootstrap.sh`.

## 📍 Critical File Locations (macOS)

```
mac/zsh/.zshrc                                       # Shell: aliases, functions, keybinds
mac/starship/.config/starship/starship.toml         # Shell prompt (active config)
~/.config/nvim/lua/keymaps.lua                       # Neovim keybinds (standalone repo)
mac/aerospace/.config/aerospace/aerospace.toml       # Window manager
mac/borders/.config/borders/bordersrc                # Window borders
mac/ghostty/.config/ghostty/config                   # Terminal
mac/sketchybar/.config/sketchybar/sketchybarrc       # Menu bar
mac/kanata/.config/kanata/kanata.kbd                 # Keyboard remapper (ACTIVE)
mac/herdr/.config/herdr/config.toml                  # Agent multiplexer (PRIMARY): Ctrl+A prefix, mirrors tmux
mac/tmux/.tmux.conf                                  # Tmux: BACKUP multiplexer, not primary
mac/macos/Brewfile, mac/macos/setup.sh               # Machine provisioning
```

## 📍 Critical File Locations (Linux / Omarchy)

```
linux/zsh/.zshrc                                     # Shell
linux/hypr/.config/hypr/                             # Hyprland deltas over Omarchy 4 (Lua)
linux/sesh/, linux/ssh/, linux/dev-tools/, linux/terminals/  # Sessions, SSH, dev tools, terminals
linux/provision-server.sh                            # Server provisioning
linux/kanata/.config/kanata/config.kbd              # Keyboard remapper (Linux)
linux/.stowrc                                        # Targets /home/cyperx
```

## 📍 Critical File Locations (Omarchy)

```
omarchy/kanata/.config/kanata/config.kbd            # Keyboard remapper (port of mac kanata.kbd)
omarchy/kanata/.config/systemd/user/kanata.service  # Runs kanata as a user service
omarchy/kanata/.config/kanata/kanata-regrab         # Restarts kanata when it misses a reconnected keyboard (kanata-regrab.service)
omarchy/kanata/.config/omarchy/bar/modules/kanata.qml  # Bar widget: home row mods on/off (kanata TCP 127.0.0.1:5829)
omarchy/scripts/install-kanata.sh                   # kanata-bin + input/uinput perms + stow + enable + bar widget
omarchy/hypr/.config/hypr/bindings.lua              # Hyprland binds (home-row workspaces, Ctrl+Shift+hjkl focus)
omarchy/hypr/.config/hypr/looknfeel.lua             # Rounding 16, dim inactive windows
omarchy/theme/.config/omarchy/themes/tokyo-night/colors.toml  # Theme overlay: green accent (stowed --no-folding)
omarchy/voxtype/.config/voxtype/config.toml         # Dictation: parakeet engine, hotkey off (Ctrl+Space bind drives it)
omarchy/ghostty/.config/ghostty/config              # Terminal (default via `omarchy install terminal ghostty`)
omarchy/starship/.config/starship.toml              # Prompt (same as linux/dev-tools)
omarchy/bash/.bashrc                                # Bash (Omarchy default shell) + starship machine skull, vv nvim picker
omarchy/bash/.config/bash/personal.sh               # Aliases/fzf/PATH ported from mac/zsh/.zshrc (sourced by .bashrc)
omarchy/herdr/.config/herdr/config.toml             # Herdr: mac alt+letter keys + tmux-style prefix keys
omarchy/yazi/, omarchy/ssh/, omarchy/git/          # Yazi keymap, ~/.ssh/config (hosts in untracked config.local), git config
omarchy/mise/.config/mise/config.toml               # mise: coding harnesses (claude, codex) + runtimes; `mise use -g` writes here
omarchy/scripts/install-apps.sh                     # Apps: omarchy-pkg-add (godot, blender, grok-bot) + `omarchy install ...` when missing (browsers, tailscale, AI apps incl. Hermes desktop, which owns `hermes`)
omarchy/scripts/install-t2-mac.sh                   # T2 MacBook extras over Omarchy's own T2 setup; no-op elsewhere
omarchy/scripts/lib.sh                              # stow_package: moves real files aside to .bak, then stows
omarchy/install.sh                                  # Runs every installer in order (fresh machine or re-apply)
omarchy/scripts/install-*.sh                        # One idempotent installer per component (pkg + stow + services)
omarchy/scripts/herdr-skill.hook                    # Post-update hook: writes `herdr --skill` into each harness's skills dir
omarchy/.stowrc                                     # Targets $HOME
```

### Omarchy conventions

- Packages via `omarchy-pkg-add` / `omarchy-pkg-aur-add`; automation via `omarchy-hook-install` (`~/.config/omarchy/hooks/<event>.d/`)
- Never edit `/usr/share/omarchy/`; read it freely. Don't override `EDITOR` (Omarchy sets `omarchy-launch-editor`) or its `n` function
- Neovim: `~/.config/nvim` is `cyperx84/nvim` (pushed from there); stock LazyVim lives at `~/.config/nvim-lazyvim` via `NVIM_APPNAME`. The config follows the Omarchy theme from `colors.toml`, not the LazyVim `neovim.lua`
- Agent skills shipped by a tool (e.g. `herdr --skill`) are generated by installers/hooks, never committed
- Configs stow through `stow_package` (`omarchy/scripts/lib.sh`); bar changes go through `omarchy bar ...`, never a stowed `shell.json` (the bar rewrites it and drops the symlink)

## 🎯 User Intent Mapping

| User Query | Reference |
|------------|-----------|
| "Keybinds" / "Shortcuts" | docs/KEYBINDS.md, docs/NEOVIM_KEYBINDS.md |
| "How tools work together" | docs/WORKFLOW_GUIDES.md |
| "Component details" | docs/COMPONENTS.md |
| "Not working" / "Broken" | docs/MAINTENANCE.md |
| "Local LLM" / "MLX" / "Gemma" / "OpenClaw" / "Hermes" | docs/archive/MLX_GEMMA_SETUP.md |
| "Provisioning" / "New Mac" / "Brewfile" | mac/macos/Brewfile, mac/macos/setup.sh, docs/MAINTENANCE.md |
| "Linux" / "Omarchy" / "Hyprland" | linux/, linux/bootstrap.sh |
| Linux keybinds | docs/OMARCHY_KEYBINDS.md |
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
- **macOS — Terminal stack**: Ghostty → Herdr (agent multiplexer, Ctrl+A, PRIMARY) → Zsh → Starship (prompt); Tmux kept as backup only — don't extend it, extend herdr
- **macOS — Input**: Kanata (ACTIVE, LaunchDaemon) — Karabiner DriverKit pinned to 6.6.0
- **macOS — Automation**: Hammerspoon (ACTIVE) — focus-follows-mouse only, raises the window under the cursor
- **Linux — Window mgmt**: Hyprland + Omarchy 4 (quickshell bar, omarchy-menu launcher; we ship deltas only)
- **Linux — Input**: Kanata (`config.kbd`)
- **Editor (shared)**: Neovim (kickstart.nvim base, standalone repo at `~/.config/nvim`)
- **Provisioning**: `mac/macos/Brewfile` + `mac/macos/setup.sh` mirror this machine onto a fresh Mac (see provision-mac-twin skill); `linux/bootstrap.sh` for Omarchy
- **Agent config**: harnesses are moving to `AGENTS.md`; no separate Claude config repo (`dotclaude` is retired). Agent skills that ship with a tool (e.g. `herdr --skill`) are generated by that tool's install script, not committed

## 🔧 Service Management (macOS)

```bash
killall AeroSpace && open -a AeroSpace                     # Restart Aerospace
killall borders && borders &                               # Restart borders
sketchybar --reload                                        # Reload SketchyBar
sudo launchctl kickstart -k system/com.example.kanata      # Restart Kanata
herdr server reload-config                                 # Reload herdr
tmux source-file ~/.tmux.conf                              # Reload tmux (backup mux)
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

## 📋 Code Style

- Bash: `#!/usr/bin/env bash`
- Lua: kickstart.nvim patterns, modular plugin structure
- Stow: keep directory structure matching target locations (`mac/<component>/.config/tool/`, `linux/<component>/.config/tool/`)
