---
id: AGENTS
tags:
  - agents-md
---

# AGENTS.md

Guidance for coding agents (Claude Code, Codex, opencode, pi, ...) working with this **macOS + Omarchy dotfiles monorepo**.
Mac configs live in `mac/`, Omarchy (the daily-driver Linux desktop) configs in
`omarchy/`. Stow is run from the platform subdirectory, never from the repo root.

## 📍 Repo Structure

```
dotfiles/
  mac/      ← stow from here on macOS   (target: ~)
  omarchy/  ← stow from here on Omarchy (target: $HOME, via omarchy/.stowrc)
  docs/     ← documentation (shared)
  tests/    ← test scripts (bootstrap-nvim-provision.sh)
  README.md ← the long-form repo tour
  .claude/  ← repo tooling: agents + commands for working ON these dotfiles
```

`omarchy/` is ported from `mac/` (kanata, herdr, zsh→bash aliases). The old `linux/`
layer is gone (2026-10-17); its hypr binds live on in `omarchy/hypr`.

Provision a fresh Mac with `mac/bootstrap.sh`; on Omarchy run the idempotent
`omarchy/install.sh`, which runs `omarchy/scripts/install-*.sh` in order.

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

## 📍 Critical File Locations (Omarchy)

```
omarchy/kanata/.config/kanata/config.kbd            # Keyboard remapper (port of mac kanata.kbd)
omarchy/kanata/.config/systemd/user/kanata.service  # Runs kanata as a user service (+ kanata-regrab.service)
omarchy/kanata/.config/kanata/kanata-regrab         # Restarts kanata when it misses a reconnected keyboard (kanata-regrab.service)
omarchy/kanata/.config/omarchy/bar/modules/kanata.qml  # Bar widget: home row mods on/off (kanata TCP 127.0.0.1:5829)
omarchy/scripts/install-kanata.sh                   # kanata-bin + input/uinput perms + stow + enable + bar widget
omarchy/hypr/.config/hypr/bindings.lua              # Hyprland binds (home-row workspaces, Ctrl+Shift+hjkl focus)
omarchy/hypr/.config/hypr/looknfeel.lua             # Rounding 16, dim inactive windows
omarchy/theme/.config/omarchy/themes/tokyo-night/colors.toml  # Theme overlay: green accent (absolute symlink, see install-look.sh)
omarchy/theme/.config/omarchy/themed/ghostty-accent.conf.tpl  # Ghostty cursor = theme accent, loaded after Omarchy's ghostty.conf
omarchy/voxtype/.config/voxtype/config.toml         # Dictation: parakeet engine, hotkey off (Ctrl+Space bind drives it)
omarchy/ghostty/.config/ghostty/config              # Terminal (+ shaders/), default via `omarchy install terminal ghostty`
omarchy/starship/.config/starship.toml              # Prompt
omarchy/bash/.bashrc                                # Bash (Omarchy default shell) + starship machine skull, vv nvim picker
omarchy/bash/.config/bash/personal.sh               # Aliases/fzf/PATH ported from mac/zsh/.zshrc (sourced by .bashrc)
omarchy/herdr/.config/herdr/config.toml             # Herdr: mac alt+letter keys + tmux-style prefix keys
omarchy/yazi/, omarchy/ssh/, omarchy/git/          # Yazi keymap, ~/.ssh/config (hosts in untracked config.local), git config
omarchy/mise/.config/mise/config.toml               # mise: coding harnesses (claude, codex) + runtimes; `mise use -g` writes here
omarchy/scripts/install-apps.sh                     # Apps: omarchy-pkg-add (godot, blender, grok-bot, xorg-server-xvfb) + `omarchy install ...` when missing (browsers, tailscale, AI apps incl. Hermes desktop, which owns `hermes`)
omarchy/scripts/install-plugins.sh                  # Omarchy bar plugins: local dev links or GitHub installs + enablement
omarchy/scripts/install-t2-mac.sh                   # T2 MacBook extras over Omarchy's own T2 setup; no-op elsewhere
omarchy/t2-audio/.config/pipewire/pipewire.conf.d/90-t2-speakers.conf  # "Speakers" filter-chain: L/R on tweeters, mono bass on left woofer (right woofer dead under Linux)
omarchy/t2-audio/.local/bin/t2-speakers-tune       # Local web panel: live crossover/levels/polarity for that sink, test signals, saves into the conf
omarchy/t2-prochot/                                 # Root timer clearing BD PROCHOT (SMC pins CPU at 800 MHz); installed into /etc by install-t2-mac.sh
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
| "Omarchy" / "Hyprland" / "Linux" | omarchy/, omarchy/install.sh |
| Omarchy vs Aerospace keybinds | docs/OMARCHY_KEYBINDS.md |
| "herdr fork" / "client.focus" / "sesh-bro jump to another machine" | docs/HERDR_FORK.md |
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

4. **DO NOT** `brew unpin kanata` — it is pinned on purpose. herdr is no longer pinned (stock Homebrew build since 2026-10-16); if the fork is ever switched back in, re-pin it with `brew pin herdr` so `brew upgrade` cannot relink `/opt/homebrew/bin/herdr` away from it. Check whose binary is linked with `mac/scripts/herdr-build.sh status`; `switch` / `revert` move between the fork and Homebrew's (see docs/HERDR_FORK.md)

5. **ALWAYS** run validation before declaring changes complete:
   - macOS: `mac/scripts/test_dotfiles.sh` (full suite) and `~/.config/sketchybar/test_sketchybar.sh` (menu bar plugins)
   - Omarchy: no suite — `stow -nv <component>` from `omarchy/`, `kanata --cfg <file> --check` for kanata, `bash -n` for installers

## 🤖 Agent Guidelines

- Read relevant docs before modifying anything
- Test stow changes before applying, from the correct platform subdir:
  - macOS: `cd ~/dotfiles/mac && stow -nv <component>`
  - Omarchy: `cd ~/dotfiles/omarchy && stow -nv <component>`
- After changes restart services in order: Aerospace → borders → sketchybar
- Nvim is a **standalone repo** at `~/.config/nvim` (github.com/cyperx84/nvim) — commit/push directly from there, no dotfiles pointer to update

## 🏗️ Architecture Overview

GNU Stow-managed monorepo (macOS + Omarchy):
- **macOS — Window mgmt**: Aerospace (tiling, PRIMARY) → JankyBorders (borders) → SketchyBar (menu bar, Lua config + shell plugins)
- **macOS — Terminal stack**: Ghostty → Herdr (agent multiplexer, Ctrl+A, PRIMARY) → Zsh → Starship (prompt); Tmux kept as backup only — don't extend it, extend herdr
- **macOS — Input**: Kanata (ACTIVE, LaunchDaemon) — Karabiner DriverKit pinned to 6.6.0 in `mac/kanata/.config/kanata/install_kanata_macos.sh:25` (kanata 1.11.x speaks the v6 VirtualHID socket protocol)
- **macOS — Automation**: Hammerspoon (ACTIVE) — focus-follows-mouse, the alt+e herdr summon, and hiding SketchyBar while WoW is frontmost
- **Omarchy — Terminal stack**: Ghostty → Herdr (same keys as mac, `omarchy/herdr`) → Bash (Omarchy default) → Starship; input via Kanata user service
- **Editor (shared)**: Neovim (kickstart.nvim base, standalone repo at `~/.config/nvim`)
- **Provisioning**: `mac/macos/Brewfile` + `mac/macos/setup.sh` mirror this machine onto a fresh Mac (see provision-mac-twin skill); `omarchy/install.sh` for Omarchy
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

## 🔧 Service Management (Omarchy)

```bash
hyprctl reload                                             # Reload Hyprland (Lua config)
systemctl --user restart kanata kanata-regrab              # Restart Kanata
herdr server reload-config                                 # Reload herdr
exec bash                                                  # Reload shell
```

## 🔑 Key Integration Notes

- **Kanata binary**: MUST use `/opt/homebrew/bin/kanata` (Homebrew symlink) — direct Cellar path breaks TCC permissions on `brew upgrade`. kanata needs **two** TCC grants for that path — **Input Monitoring** *and* **Accessibility** — and a binary upgrade drops both, surfacing them one at a time (see docs/MAINTENANCE.md → "Kanata Stops Working After `brew upgrade`")
- **Kanata logs**: `/tmp/kanata.out.log`, `/tmp/kanata.err.log`
- **SketchyBar helper**: C binary at `~/.config/sketchybar/helper/` — recompile with `make clean && make` if system metrics plugins fail
- **Temperature plugin**: Uses `smctemp` TH0x (heatsink) sensor — M4 die sensors (TCMb) read 90°C+ at idle which is normal/misleading
- **herdr is Homebrew's stock build (reverted from the local fork 2026-10-16)**: `/opt/homebrew/bin/herdr` links to `../Cellar/herdr/<version>/bin/herdr`. The fork (`~/github/herdr` branch `feat/client-focus`, never pushed, built to `~/.local/share/herdr-build/herdr`) is kept but not in use; its three commits are what let the sesh-bro picker jump to another machine, so that jump does not work on stock. `mac/scripts/herdr-build.sh status|switch|revert` moves between the fork and Homebrew's and says which is linked; `switch`/`revert` stop every running herdr session, so run them from a terminal outside herdr. On stock, the formula is unpinned and `[update] version_check` is true; switching back to the fork means `brew pin herdr` and `version_check = false`. `mac/macos/Brewfile:274` lists `brew "herdr"`. Full story in docs/HERDR_FORK.md
- **Hammerspoon** (`mac/hammerspoon/.hammerspoon/init.lua`) does three things:
  - *Focus-follows-mouse* — polls every 50ms via the Accessibility API, with explicit guards so it does NOT steal focus from dialogs/sheets/System Settings or the emoji picker
  - *alt+e herdr summon* (`init.lua:180`+) — switches to the Aerospace workspace holding the herdr Ghostty window, then posts the alt+e chord at the app to toggle the sesh-bro picker. Depends on `mac/scripts/herdr-picker.sh`, `/opt/homebrew/bin/aerospace`, `/opt/homebrew/bin/herdr`, and the `keys.command` alt+e binding in `mac/herdr/.config/herdr/config.toml` — rebind there and this must follow
  - *WoW bar hide* — an app watcher sets `sketchybar --bar hidden=on` while WoW (process `Wow`) is frontmost
  - Needs Accessibility permission; touch carefully — it interacts with Aerospace focus

## 📋 Code Style

- Bash: `#!/usr/bin/env bash`
- Lua: kickstart.nvim patterns, modular plugin structure
- Stow: keep directory structure matching target locations (`mac/<component>/.config/tool/`, `omarchy/<component>/<path under $HOME>`)
