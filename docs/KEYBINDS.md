# Dotfiles Keybinds & Aliases Reference

> **Quick Navigation**
> [Why No Conflicts](#why-no-conflicts) • [Window Management](#window-management) • [Session Workflow](#session-workflow) • [File Operations](#file-operations) • [Git Workflow](#git-workflow) • [Development Tools](#development-tools) • [Search & Navigation](#search--navigation) • [System Integration](#system-integration)

A single source of truth for every keybinding and alias in this macOS setup, verified line-by-line against the live config files. Bindings are grouped by the tool that owns them — keyboard hardware (Kanata), window manager (Aerospace), multiplexer (Tmux), terminal (Ghostty), and shell (Zsh). Start with [Why No Conflicts](#why-no-conflicts) to understand how the layers stay out of each other's way; jump to any section below for the full reference.

## Table of Contents

- [Why No Conflicts](#why-no-conflicts) - How the keyboard / WM / tmux / nvim layers share the modifier space
- [Window Management](#window-management) - Window focus, movement, resizing (Aerospace + Tmux)
- [Session Workflow](#session-workflow) - Tmux sessions, Sesh integration, Ghostty
- [File Operations](#file-operations) - File managers, directory navigation, listing
- [Git Workflow](#git-workflow) - Git aliases and operations
- [Development Tools](#development-tools) - Docker, Kubernetes, Python, Claude
- [Search & Navigation](#search--navigation) - FZF, Zoxide integration
- [System Integration](#system-integration) - Hardware remapping, shell keybinds

---

## Why No Conflicts

These tools stack on top of each other — a keystroke passes through Kanata, then macOS/Aerospace, then Ghostty, then Tmux, before Neovim ever sees it. Conflicts are avoided by giving each tool its own slice of the modifier space.

| Layer | Owner | Owns | Notes |
|-------|-------|------|-------|
| Hardware (produces modifiers) | **Kanata** | Caps→Esc/Ctrl, home-row mods, Tab→Hyper, Space-hold→Symbols, RCmd-hold→Numbers | Kanata **generates** the Ctrl/Alt/Cmd/Shift keycodes the other tools consume. It can't collide with them by design. |
| Global window manager | **Aerospace** | `Cmd+letter`, `Cmd+Shift+letter`, `Shift+Ctrl+*`, `Ctrl+Alt+*`, `Cmd+Alt+Shift+*`, `Shift+Alt+*`, `Ctrl+Shift+1-9` | Heavy multi-modifier chords are reserved for global window ops + app launchers. |
| Multiplexer (prefix) | **Tmux** | `C-a` then key | Gated behind the `Ctrl-A` prefix, so prefix bindings never collide with bare chords. |
| Multiplexer (non-prefix) | **Tmux** | bare `Alt+letter` | `M-1..M-6`, `M-j/k/l/u/i/o`, `M-s/v/c/x/w/r/q`, `M-Tab`, `M-\`, `M-Space`, `M-p`. Harpoon **vacated** this space (it uses `<leader>` keys), so tmux owns `Alt+letter` cleanly. |
| Editor punctuation | **Neovim** | `Alt+punctuation` | `<M-;>` ClaudeCode toggle, `<M-'>` OpenCode toggle. Tmux leaves `Alt+punctuation` free. |
| Editor leader | **Neovim** | `<leader>` (Space) prefix | All nvim-internal: Telescope, Neogit, Harpoon, ClaudeCode, Obsidian, sessions. See [Neovim Keybinds](NEOVIM_KEYBINDS.md). |
| Shared integration channel | **Tmux + Neovim** | bare `Ctrl+h/j/k/l` | Deliberately shared via `vim-tmux-navigator` — one chord routed across tmux panes **and** nvim splits. The one intentional overlap. |
| Shell prompt (readline) | **Zsh** | `Ctrl+letter` at prompt | `^f`, `^u`, `^p`, `jk`. Only active at the zsh prompt; mutually exclusive with nvim's same-named chords (which fire inside a buffer). |
| Terminal host | **Ghostty** | minimal | Keeps a tiny footprint: `Ctrl+Enter` quick terminal, `Cmd+Shift+S` secure input. Deliberately **unbinds** `Ctrl+L` and `Cmd+Shift+P` so they pass through to inner tools. |

> **Known shadow:** Ghostty's `Cmd+Shift+S` (`toggle_secure_input`, `config:44`) is shadowed by Aerospace's global `cmd-shift-s` (`sidecar-ipad.sh`, `aerospace.toml:139`). Aerospace wins because it intercepts globally before Ghostty sees the chord. The Ghostty bind is effectively dead.

---

## Window Management

### Aerospace Window Operations (PRIMARY)
*Source: `aerospace/.config/aerospace/aerospace.toml`*

**Window Focus & Movement:**
| Keybind | Action | Description |
|---------|---------|-------------|
| `Shift+Ctrl+h/j/k/l` | Focus window | Move focus left/down/up/right |
| `Shift+Ctrl+Alt+h/j/k/l` | Move window | Move window left/down/up/right |
| `Ctrl+Alt+h/j/k/l` | Move window | Move right/up/down/left (deliberately inverted) |
| `Cmd+Alt+Shift+h/j/k/l` | Join window | Join with left/down/up/right (main mode) |

**Layout Management:**
| Keybind | Action | Description |
|---------|---------|-------------|
| `Shift+Ctrl+e` | Toggle float/tile | Toggle between floating and tiling |
| `Shift+Ctrl+v` | Toggle orientation | Toggle horizontal/vertical layout |
| `Shift+Ctrl+t` | Tiles layout | Switch to tiles layout |
| `Shift+Ctrl+a` | Accordion layout | Switch to accordion layout |
| `Shift+Alt+t` | Float toggle | Toggle floating/tiling layout |
| `Shift+Ctrl+q` | Float toggle | Toggle floating/tiling layout (same as `Shift+Alt+t`) |
| `Shift+Ctrl+w` | Fullscreen | Toggle fullscreen mode |
| `Shift+Ctrl+r` | Balance | Flatten workspace tree (reset layout) |

**Window Resizing:**
| Keybind | Action | Description |
|---------|---------|-------------|
| `Ctrl+Alt+Cmd+j` | Resize smaller | Make window smaller (smart, context-aware) |
| `Ctrl+Alt+Cmd+k` | Resize larger | Make window larger (smart, context-aware) |

**Workspace Navigation:**
| Keybind | Action | Description |
|---------|---------|-------------|
| `Cmd+j/k/l/u/i/o` | Focus workspace | Switch to workspace 1/2/3/4/5/6 (homerow) |
| `Ctrl+Shift+1-9` | Focus workspace 1-9 | Switch to workspace by number |
| `Shift+Ctrl+n/p` | Next/prev workspace | Navigate to next/previous workspace |

**Move Window to Workspace:**
| Keybind | Action | Description |
|---------|---------|-------------|
| `Shift+Alt+j/k/l/u/i/o` | Move to workspace | Move window to workspace 1/2/3/4/5/6 (homerow) |
| `Shift+Alt+1-9` | Move to workspace | Move window to workspace by number |
| `Shift+Alt+n/p` | Move next/prev | Move window to next/previous workspace (wrap-around) |

**Display Management:**
| Keybind | Action | Description |
|---------|---------|-------------|
| `Shift+Alt+s/g` | Move display | Move window to previous/next monitor (wrap-around) |

**App Launchers:**
| Keybind | Launches | Description |
|---------|----------|-------------|
| `Cmd+Enter` | Ghostty | Open a Ghostty terminal |
| `Cmd+Ctrl+t` | Ghostty + tmux | Open Ghostty and `tmux attach` |
| `Cmd+Ctrl+Shift+n` | Ghostty + tmux + nvim | New `Neovim` tmux session running nvim |
| `Cmd+Ctrl+Shift+s` | Ghostty + sesh picker | Fuzzy session picker (`sesh-picker.sh`) |
| `Cmd+Ctrl+n` | Ghostty + sesh | Connect to the `notes` sesh session |
| `Cmd+Shift+b` | Zen | Open Zen browser |
| `Cmd+Shift+y` | Zen → YouTube | Open YouTube in Zen |
| `Cmd+Shift+g` | Chrome | Open Google Chrome in background |
| `Cmd+Shift+c` | Codex | Open Codex |
| `Cmd+Shift+k` | Claude | Open Claude |
| `Cmd+Shift+u` | Antigravity | Open Antigravity |
| `Cmd+Shift+j` | Discord | Open Discord |
| `Cmd+Shift+i` | iPhone Mirroring | Open iPhone Mirroring |
| `Cmd+Shift+m` | Messages | Open Messages |
| `Cmd+Shift+s` | Sidecar | Run `~/dotfiles/scripts/sidecar-ipad.sh` |
| `Cmd+Shift+o` | Obsidian | Open Obsidian |

**Service Mode** (`Shift+Alt+Cmd+r` to enter):
| Keybind | Action | Description |
|---------|---------|-------------|
| `Esc` | Reload & exit | Reload config and return to main mode |
| `r` | Reset layout | Flatten workspace tree and exit |
| `f` | Toggle float | Toggle floating/tiling and exit |
| `Backspace` | Close others | Close all windows except current and exit |
| `Shift+Ctrl+Alt+h/j/k/l` | Join pane | Join with left/down/up/right and exit |

### Tmux Pane & Window Navigation
*Source: `tmux/.tmux.conf`*

| Keybind | Action | Description |
|---------|---------|-------------|
| `C-a` | Prefix | Tmux prefix key (remapped from `C-b`) |
| `C-a h/j/k/l` | Focus pane | Select pane left/down/up/right |
| `C-a C-h/C-j/C-k/C-l` | Resize pane | Resize pane left/down/up/right (repeatable) |
| `C-a r` | Reload config | Reload `~/.tmux.conf` |
| `C-a b` | Toggle status | Toggle status bar visibility |
| `C-a s` | Vertical split | Split window vertically (keeps current path) |
| `C-a v` | Horizontal split | Split window horizontally (keeps current path) |
| `C-a x` | Kill pane | Close pane without confirmation |
| `C-a p` | Floating pane | Toggle floax floating terminal |

### Tmux Prefix-Free Alt Bindings (work anywhere in tmux)
*Source: `tmux/.tmux.conf`*

| Keybind | Action | Description |
|---------|---------|-------------|
| `M-1` through `M-6` | Select window | Direct window selection (windows 1-6) |
| `M-j/k/l/u/i/o` | Select window | Homerow window selection (windows 1-6) |
| `M-s` | Vertical split | Split window vertically (keeps current path) |
| `M-v` | Horizontal split | Split window horizontally (keeps current path) |
| `M-c` | New window | Create new window (keeps current path) |
| `M-x` | Kill window | Close current window |
| `M-w` | Zoom pane | Toggle pane zoom |
| `M-r` | Break pane | Break pane to new window |
| `M-q` | Detach | Detach from tmux |
| `M-Tab` | Last window | Switch to last window |
| `M-\` | Copy mode | Enter copy mode (`M-[` removed — conflicted with TUI escape sequences) |
| `M-Space` | Sesh switcher | FZF-powered session switcher (`sesh_switcher.sh`) |
| `M-p` | Last session | Switch to last session via `sesh last` |

> **Shared with Neovim:** bare `Ctrl+h/j/k/l` is routed by `vim-tmux-navigator` across tmux panes and nvim splits — intentional integration, not a duplicate binding.

---

## Session Workflow

### Tmux Session Management
*Source: `tmux/.tmux.conf`*

| Keybind | Action | Description |
|---------|---------|-------------|
| `M-Space` | Session switcher | FZF-powered session switcher (`sesh_switcher.sh`) |
| `M-p` | Last session | Switch to last session via `sesh last` |
| `C-a N` | New session | Create new named session (prompts for name) |
| `C-a R` | Rename session | Rename current session |
| `C-a X` | Kill session | Kill current session (with confirmation) |
| `C-a I` | Session info | Show session name / window count / current path |
| `C-a D` | Detach | Detach current client |

### Sesh Aliases
*Source: `zsh/.zshrc`*

| Alias / Function | Command | Description |
|------------------|---------|-------------|
| `sl` | `sesh list -t -c -d` | List sessions (compact, deduplicated) |
| `sc` | shell function → `TMUX= sesh connect "$(sesh list \| fzf)"` | Fuzzy connect to a session (a function, not an alias) |

### Ghostty Terminal Operations
*Source: `ghostty/.config/ghostty/config`*

| Keybind | Action | Description |
|---------|---------|-------------|
| `Ctrl+Enter` | Quick terminal | Toggle the global quick terminal (`global:` scope) |
| `Cmd+Shift+S` | Secure input | Toggle secure input mode (**shadowed** by Aerospace `cmd-shift-s`) |
| `Ctrl+L` | *(unbound)* | Default clear-screen disabled — passes through to inner tools |
| `Cmd+Shift+P` | *(unbound)* | Default command palette disabled — passes through to inner tools |

---

## File Operations

### File Managers & Listing
*Source: `zsh/.zshrc`*

| Alias / Function | Tool | Description |
|------------------|------|-------------|
| `ls` | `eza -l --icons --git -a` | Enhanced file listing |
| `ll` | `eza --color=always --long --git --icons=always` | Detailed file listing |
| `lt` | `eza --tree --level=2 --long --icons --git` | Tree view with details |
| `ltree` | `eza --tree --level=2 --icons --git` | Simple tree view |
| `l` | `eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions` | Clean file listing |

### Directory Navigation
*Source: `zsh/.zshrc`*

| Alias / Function | Description |
|------------------|-------------|
| `..` | `cd ..` |
| `...` | `cd ../..` |
| `....` | `cd ../../..` |
| `.....` | `cd ../../../..` |
| `......` | `cd ../../../../..` |
| `C` | `cd ~/Code/` |
| `conf` | `cd $HOME/dotfiles && nvim` |

### FZF Navigation Functions
*Source: `zsh/.zshrc`*

| Function | Description |
|----------|-------------|
| `fcd()` | Fuzzy directory navigation with eza preview |
| `f()` | Yazi file manager with cd integration |
| `fv()` | Fuzzy file selection for nvim editing |

---

## Git Workflow

### Git Aliases
*Source: `zsh/.zshrc`*

| Alias | Command | Description |
|-------|---------|-------------|
| `gc` | `git commit -m` | Quick commit with message |
| `gca` | `git commit -a -m` | Commit all changes with message |
| `gp` | `git push origin HEAD` | Push current branch |
| `gpu` | `git pull origin` | Pull from origin |
| `gs` | `git status` | Git status |
| `glog` | `git log --graph --topo-order --pretty=...` | Enhanced git log |
| `gdiff` | `git diff` | Git diff |
| `gco` | `git checkout` | Checkout branch/commit |
| `gb` | `git branch` | List branches |
| `gba` | `git branch -a` | List all branches |
| `gadd` | `git add` | Add files |
| `ga` | `git add -p` | Interactive add (patch mode) |
| `gcoall` | `git checkout -- .` | Discard all changes |
| `gr` | `git remote` | Remote operations |
| `gre` | `git reset` | Reset operations |

### GitHub CLI
*Source: `zsh/.zshrc`*

| Alias | Command | Description |
|-------|---------|-------------|
| `ghl` | `gh repo list` | List GitHub repositories |

---

## Development Tools

### Docker Operations
*Source: `zsh/.zshrc`*

| Alias | Command | Description |
|-------|---------|-------------|
| `dock` | `open -a docker && while ! docker info...` | Start Docker Desktop |
| `dkill` | `killall "Docker Desktop" && sleep 1 && dock` | Restart Docker |
| `dco` | `docker compose` | Docker Compose |
| `dps` | `docker ps` | List running containers |
| `dpa` | `docker ps -a` | List all containers |
| `dl` | `docker ps -l -q` | Latest container ID |
| `dx` | `docker exec -it` | Interactive container exec |

### Kubernetes
*Source: `zsh/.zshrc`*

| Alias | Command | Description |
|-------|---------|-------------|
| `k` | `kubectl` | Kubectl shorthand |
| `ka` | `kubectl apply -f` | Apply configuration |
| `kg` | `kubectl get` | Get resources |
| `kd` | `kubectl describe` | Describe resources |
| `kdel` | `kubectl delete` | Delete resources |
| `kgpo` | `kubectl get pod` | Get pods |
| `kgd` | `kubectl get deployments` | Get deployments |
| `kc` | `kubectx` | Switch context |
| `kns` | `kubens` | Switch namespace |
| `kl` | `kubectl logs -f` | Follow logs |
| `ke` | `kubectl exec -it` | Interactive pod exec |
| `kcns` | `kubectl config set-context --current --namespace` | Set namespace |

### Python & Editor
*Source: `zsh/.zshrc`*

| Alias | Tool | Description |
|-------|------|-------------|
| `n` | `NVIM_APPNAME="nvim" nvim` | Default Neovim |
| `vim` | `nvim` | Neovim alias |
| `cl` | `clear` | Clear terminal |
| `ta` | `tmux attach -d` | Attach to tmux |

### Claude Integration
*Source: `zsh/.zshrc`*

| Alias | Command | Description |
|-------|---------|-------------|
| `cc` | `claude --dangerously-skip-permissions` | Claude CLI (unsafe mode) |

### HTTP & Networking
*Source: `zsh/.zshrc`*

| Alias | Command | Description |
|-------|---------|-------------|
| `http` | `xh` | Modern HTTP client |
| `nm` | `nmap -sC -sV -oN nmap` | Nmap with scripts |

### Quality of Life & Utilities
*Source: `zsh/.zshrc`*

| Alias | Command | Description |
|-------|---------|-------------|
| `kr` | `sudo launchctl kickstart -k system/com.example.kanata` | Restart Kanata |
| `vv` | FZF Neovim config selector | Switch between nvim configs |
| `ao` / `ai` / `as` | `audio-output` / `audio-input` / status | FZF audio device switching |
| `speakers` / `monitor` / `mod-out` | `SwitchAudioSource` shortcuts | Quick audio output switches |
| `scarlett-in` / `mod-in` | `SwitchAudioSource` shortcuts | Quick audio input switches |
| `conf` | `cd $HOME/dotfiles && nvim` | Open dotfiles config |
| `note` / `notes` | Open Obsidian notes in nvim | Quick note access |

---

## Search & Navigation

### FZF Configuration
*Source: `zsh/.zshrc`*

| Environment Variable | Value | Description |
|----------------------|-------|-------------|
| `FZF_DEFAULT_COMMAND` | `fd --type f --hidden --follow` | Use fd for file finding |
| `FZF_ALT_C_OPTS` | `--preview 'eza --tree --color=always --icons --level=3 {} \| head -200'` | Directory preview |
| `FZF_CTRL_T_OPTS` | `--preview 'bat -n --color=always --line-range :500 {}'` | File preview |

### Zoxide Integration
*Source: `zsh/.zshrc`*

| Tool | Description |
|------|-------------|
| `z` | Smart directory jumping (zoxide) |

---

## System Integration

### Hardware Remapping - Kanata (Active)
*Source: `kanata/.config/kanata/kanata.kbd`*

Kanata is the hardware layer: it **produces** the modifier keycodes (Ctrl/Alt/Cmd/Shift) and layer switches that every other tool consumes. Tap a key for its letter, hold it for its modifier or layer.

**Base layer — tap / hold remaps:**
| Key | Tap | Hold | Description |
|-----|-----|------|-------------|
| `Caps Lock` | `Escape` | `Left Control` | Caps as Esc/Ctrl (great for Vim) |
| `a` | `a` | `Left Meta` (Cmd) | Home-row modifier |
| `s` | `s` | `Left Alt` | Home-row modifier |
| `d` | `d` | `Left Shift` | Home-row modifier |
| `f` | `f` | `Left Control` | Home-row modifier |
| `j` | `j` | `Right Control` | Home-row modifier |
| `k` | `k` | `Right Shift` | Home-row modifier |
| `l` | `l` | `Right Alt` | Home-row modifier |
| `;` | `;` | `Right Meta` (Cmd) | Home-row modifier (sends RCmd keycode, not the layer toggle) |
| `Tab` | `Tab` | `Hyper` | Hyper = Cmd+Alt+Shift+Ctrl |
| `Space` | `Space` | `Symbols Layer` | Hold for programming symbols (`!@#$ {}[]` etc.) |
| `Fn` | `Fn` | `Function Layer` | Hold for F1-F12 |
| `Right Cmd` | `Right Cmd` | `Numbers Layer` | Hold for numpad / arrows (HRM toggle is RCmd-hold + `Tab`) |
| `Right Shift` | `Backspace` | — | Plain remap — Right Shift always emits Backspace |
| `'` | `'` | — | Plain apostrophe (no hold, no layer) |
| `/` | `/` | — | Plain forward slash (no hold) |

**Layer toggles:**
| Gesture | Action | Description |
|---------|--------|-------------|
| `RCmd-hold` then `Tab` | Toggle HRM off | Switch to vanilla layer (home-row mods disabled) |
| `Fn-hold` then `F1` | Toggle base↔vanilla | Toggle home-row mods on/off from the Function layer |

**Symbols layer** (hold `Space`):
| Held keys | Output |
|-----------|--------|
| `q w e r t y u i o p` | `! @ # $ % ^ & * ( )` |
| `a s d f g` | `{ } [ ] .` |
| `h j k l ;` | `: = _ - \|` |
| `z x c v b` | `< > " ' \`` |
| `n m , .` | `~ \ + ?` |

**Numbers layer** (hold `Right Cmd`):
| Held keys | Output |
|-----------|--------|
| `q w e r t y u i o p` | `1 2 3 4 5 6 7 8 9 +` (the `q`/Tab slot is the HRM toggle) |
| `a s d f` | `← ↓ ↑ →` (WASD-style arrows) |
| `h j k l ;` | `0 4 5 6 -` (numpad) |
| `c v` / `n m , . /` | `. +` / `, 1 2 3 /` |

### Hardware Remapping - Karabiner Elements (Unconfigured)
*Source: `karabiner/.config/karabiner/karabiner.json`*

Karabiner-Elements is installed but has no active remappings (`simple_modifications` is empty). Kanata is the primary keyboard remapper.

### Zsh Keybinds (readline)
*Source: `zsh/.zshrc`*

| Keybind | Action | Description |
|---------|--------|-------------|
| `^f` | `vi-forward-word` | Forward one word |
| `^u` | `up-line-or-search` | Up / search history |
| `^p` | `down-line-or-search` | Down / search history |
| `jk` | `vi-cmd-mode` | Enter vi command mode |

### SketchyBar Integration
*Source: `zsh/.zshrc`*

| Function | Trigger | Description |
|----------|---------|-------------|
| `brew()` | Various brew commands | Notify SketchyBar on package changes |

---

## Related Documentation

- [Neovim Keybinds](NEOVIM_KEYBINDS.md) - Comprehensive Neovim mappings (standalone repo at `~/.config/nvim`)
- [Workflow Guides](WORKFLOW_GUIDES.md) - Cross-tool integration workflows
- [CLAUDE.md](../CLAUDE.md) - Main dotfiles documentation

---

## Quick Reference Card

### Most Used Keybinds
```
Window Management:    Cmd+j/k/l/u/i/o (workspaces 1-6), Shift+Ctrl+hjkl (focus)
Sessions:             M-Space (sesh switcher), M-p (last session), sc (fuzzy connect)
Files:                fcd (fuzzy cd), f (yazi), fv (fuzzy nvim)
Git:                  gs (status), gc "msg" (commit), gp (push)
Development:          ta (tmux), n (nvim), dps (docker ps)
Audio:                ao (output), ai (input), as (status)
```

### Integration Points
- **Aerospace + Tmux**: Global window management (Aerospace) and in-terminal pane/session management (Tmux) on separate modifier namespaces.
- **Sesh + Tmux**: `M-Space` switcher and `M-p` last-session, backed by the `sl`/`sc` shell helpers.
- **FZF + Multiple**: Fuzzy finding across files, sessions, and directories.
- **vim-tmux-navigator**: `Ctrl+h/j/k/l` unifies tmux pane and Neovim split navigation.

---

## Author

**cyperx** - [GitHub Profile](https://github.com/cyperx84)

For issues or contributions, visit the [dotfiles repository](https://github.com/cyperx84/dotfiles).
