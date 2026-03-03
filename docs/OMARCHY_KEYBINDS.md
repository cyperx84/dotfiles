# Omarchy Keybinds Reference

> **Source**: [basecamp/omarchy](https://github.com/basecamp/omarchy) (Hyprland on Arch Linux, by DHH)
> **Version**: Latest from `default/hypr/bindings/tiling-v2.conf` + `utilities.conf`
> **Purpose**: Reference for comparing with local Aerospace config

---

## App Launcher Comparison

| App Category | Omarchy (Hyprland) | Cyperx (Aerospace) | Notes |
|-------------|-------------------|---------------------|-------|
| **Terminal** | `Super+Return` | `Ctrl+Space` | Omarchy: also opens in cwd |
| **Terminal (tmux)** | `Super+Alt+Return` | `Cmd+Ctrl+t` | Cyperx: attaches existing session |
| **Neovim** | `Super+Shift+N` | `Cmd+Ctrl+Shift+n` | Cyperx: tmux session with nvim |
| **Browser** | `Super+Shift+Return` / `Super+Shift+B` | `Cmd+Ctrl+b` | Cyperx: Zen, Omarchy: Chromium |
| **Browser (private)** | `Super+Shift+Alt+B` | - | |
| **Browser (Chrome)** | - | `Cmd+Ctrl+g` | Cyperx-only |
| **YouTube** | - | `Cmd+Ctrl+y` | Cyperx: opens URL in Zen |
| **Perplexity** | - | `Cmd+Ctrl+p` | Cyperx: opens URL in Zen |
| **File manager** | `Super+Shift+F` | - | Omarchy: Nautilus |
| **File manager (cwd)** | `Super+Shift+Alt+F` | - | |
| **AI assistant** | `Super+Shift+A` | `Cmd+Ctrl+c` | Omarchy: ChatGPT, Cyperx: Claude |
| **Obsidian** | `Super+Shift+O` | `Cmd+Ctrl+o` | Both have it |
| **Notes (sesh)** | - | `Cmd+Ctrl+n` | Cyperx: sesh session for notes |
| **Music** | `Super+Shift+M` | - | Omarchy: Spotify |
| **Messages** | `Super+Shift+G` | `Cmd+Ctrl+m` | Omarchy: Signal, Cyperx: Messages.app |
| **WhatsApp** | `Super+Shift+Alt+G` | - | |
| **Google Messenger** | `Super+Shift+Ctrl+G` | - | |
| **Docker** | `Super+Shift+D` | - | Omarchy: LazyDocker in terminal |
| **Password manager** | `Super+Shift+/` | - | Omarchy: 1Password |
| **Calendar** | `Super+Shift+C` | - | |
| **Email** | `Super+Shift+E` | - | |
| **X (Twitter)** | `Super+Shift+X` | - | |
| **Ableton** | - | `Cmd+Ctrl+a` | Cyperx-only |
| **DaVinci Resolve** | - | `Cmd+Ctrl+d` | Cyperx-only |
| **Antigravity** | - | `Cmd+Ctrl+u` | Cyperx-only |
| **iPhone Mirroring** | - | `Cmd+Ctrl+i` | Cyperx-only |
| **Sidecar (iPad)** | - | `Cmd+Ctrl+s` | Cyperx-only |
| **App launcher** | `Super+Space` | - | Omarchy: Walker fuzzy launcher |

### Modifier Pattern Comparison

| Pattern | Omarchy | Cyperx |
|---------|---------|--------|
| **Base modifier** | `Super+Shift+<letter>` | `Cmd+Ctrl+<letter>` |
| **Terminal** | `Super+Return` | `Ctrl+Space` |
| **Variants** | adds `Alt` or `Ctrl` | adds `Shift` |
| **URL shortcuts** | - | `Cmd+Ctrl+<letter>` opens specific URLs |

> **Key observation**: Omarchy uses `Super+Shift+Letter` for all app launches. Cyperx uses `Cmd+Ctrl+Letter`. The patterns are very similar — just different modifier combos. Omarchy has more messaging/social apps preconfigured; Cyperx has more creative/production apps (Ableton, DaVinci, iPad).

---

## Window Management Comparison

### Window Focus

| Action | Omarchy (Hyprland) | Cyperx (Aerospace) | Notes |
|--------|-------------------|---------------------|-------|
| Focus left | `Super + Left` | `Shift+Ctrl+h` | Omarchy uses arrows, Cyperx uses vim hjkl |
| Focus down | `Super + Down` | `Shift+Ctrl+j` | |
| Focus up | `Super + Up` | `Shift+Ctrl+k` | |
| Focus right | `Super + Right` | `Shift+Ctrl+l` | |

### Window Swap/Move

| Action | Omarchy (Hyprland) | Cyperx (Aerospace) | Notes |
|--------|-------------------|---------------------|-------|
| Swap left | `Super+Shift+Left` | `Shift+Ctrl+Alt+h` | |
| Swap down | `Super+Shift+Down` | `Shift+Ctrl+Alt+j` | |
| Swap up | `Super+Shift+Up` | `Shift+Ctrl+Alt+k` | |
| Swap right | `Super+Shift+Right` | `Shift+Ctrl+Alt+l` | |

### Window Resize

| Action | Omarchy (Hyprland) | Cyperx (Aerospace) | Notes |
|--------|-------------------|---------------------|-------|
| Grow left / shrink right | `Super + -` | - | Omarchy: directional resize |
| Grow right / shrink left | `Super + =` | - | Omarchy: directional resize |
| Grow down | `Super+Shift + =` | - | |
| Grow up | `Super+Shift + -` | - | |
| Smart resize smaller | - | `Ctrl+Alt+Cmd+j` | Cyperx: context-aware resize |
| Smart resize larger | - | `Ctrl+Alt+Cmd+k` | Cyperx: context-aware resize |

### Layout & Floating

| Action | Omarchy (Hyprland) | Cyperx (Aerospace) | Notes |
|--------|-------------------|---------------------|-------|
| Toggle float/tile | `Super+T` | `Shift+Ctrl+e` / `Shift+Alt+t` | Cyperx has two binds |
| Fullscreen | `Super+F` | `Shift+Ctrl+w` | |
| Full width only | `Super+Alt+F` | - | Omarchy: maximizes width only |
| Tiled fullscreen | `Super+Ctrl+F` | - | |
| Close window | `Super+W` | *(native Cmd+W)* | |
| Close all windows | `Ctrl+Alt+Del` | - | |
| Toggle split orient | `Super+J` | `Shift+Ctrl+v` | |
| Tiles layout | - | `Shift+Ctrl+t` | Aerospace-specific |
| Accordion layout | - | `Shift+Ctrl+a` | Aerospace-specific |
| Balance/flatten | - | `Shift+Ctrl+r` | Aerospace: flatten-workspace-tree |
| Pop out (sticky float) | `Super+O` | - | Omarchy: float + pin to all WS |
| Pseudo tile | `Super+P` | - | Hyprland dwindle-specific |

### Workspace Navigation

| Action | Omarchy (Hyprland) | Cyperx (Aerospace) | Notes |
|--------|-------------------|---------------------|-------|
| Workspace 1 | `Super+1` | `Cmd+j` / `Ctrl+Shift+1` | Cyperx: homerow + number |
| Workspace 2 | `Super+2` | `Cmd+k` / `Ctrl+Shift+2` | |
| Workspace 3 | `Super+3` | `Cmd+l` / `Ctrl+Shift+3` | |
| Workspace 4 | `Super+4` | `Cmd+u` / `Ctrl+Shift+4` | |
| Workspace 5 | `Super+5` | `Cmd+i` / `Ctrl+Shift+5` | |
| Workspace 6 | `Super+6` | `Cmd+o` / `Ctrl+Shift+6` | |
| Workspace 7-9 | `Super+7/8/9` | `Ctrl+Shift+7/8/9` | Cyperx: no homerow for 7-9 |
| Next workspace | `Super+Tab` | `Shift+Ctrl+n` | |
| Prev workspace | `Super+Shift+Tab` | `Shift+Ctrl+p` | |
| Previous (last) WS | `Super+Ctrl+Tab` | - | Omarchy: jump back to former |
| Scroll workspaces | `Super+Mouse Scroll` | - | |

### Move Window to Workspace

| Action | Omarchy (Hyprland) | Cyperx (Aerospace) | Notes |
|--------|-------------------|---------------------|-------|
| Move to WS 1 | `Super+Shift+1` | `Shift+Alt+j` / `Shift+Alt+1` | Cyperx: homerow + number |
| Move to WS 2 | `Super+Shift+2` | `Shift+Alt+k` / `Shift+Alt+2` | |
| Move to WS 3 | `Super+Shift+3` | `Shift+Alt+l` / `Shift+Alt+3` | |
| Move to WS 4 | `Super+Shift+4` | `Shift+Alt+u` / `Shift+Alt+4` | |
| Move to WS 5 | `Super+Shift+5` | `Shift+Alt+i` / `Shift+Alt+5` | |
| Move to WS 6 | `Super+Shift+6` | `Shift+Alt+o` / `Shift+Alt+6` | |
| Move to WS 7-9 | `Super+Shift+7/8/9` | `Shift+Alt+7/8/9` | |
| Move silent to WS | `Super+Shift+Alt+1-9` | - | Omarchy: move without following |
| Move to next WS | - | `Shift+Alt+n` | Cyperx only |
| Move to prev WS | - | `Shift+Alt+p` | Cyperx only |

### Multi-Monitor

| Action | Omarchy (Hyprland) | Cyperx (Aerospace) | Notes |
|--------|-------------------|---------------------|-------|
| Move WS to left monitor | `Super+Shift+Alt+Left` | - | Omarchy: moves whole workspace |
| Move WS to right monitor | `Super+Shift+Alt+Right` | - | |
| Move window to prev monitor | - | `Shift+Alt+s` | Cyperx: moves single window |
| Move window to next monitor | - | `Shift+Alt+g` | |

### Window Grouping (Omarchy only)

| Action | Omarchy (Hyprland) | Cyperx (Aerospace) | Notes |
|--------|-------------------|---------------------|-------|
| Toggle grouping | `Super+G` | - | Hyprland tabbed groups |
| Move out of group | `Super+Alt+G` | - | |
| Move into group (dir) | `Super+Alt+Arrows` | - | |
| Cycle group windows | `Super+Alt+Tab` | - | |
| Group window by number | `Super+Alt+1-4` | - | |
| Navigate group left/right | `Super+Ctrl+Left/Right` | - | |

### Window Joining (Cyperx only)

| Action | Omarchy (Hyprland) | Cyperx (Aerospace) | Notes |
|--------|-------------------|---------------------|-------|
| Join with left | - | `Cmd+Alt+Shift+h` | Aerospace-specific |
| Join with down | - | `Cmd+Alt+Shift+j` | |
| Join with up | - | `Cmd+Alt+Shift+k` | |
| Join with right | - | `Cmd+Alt+Shift+l` | |

### Scratchpad

| Action | Omarchy (Hyprland) | Cyperx (Aerospace) | Notes |
|--------|-------------------|---------------------|-------|
| Toggle scratchpad | `Super+S` | - | Hyprland special workspace |
| Send to scratchpad | `Super+Alt+S` | - | |

### Window Cycling

| Action | Omarchy (Hyprland) | Cyperx (Aerospace) | Notes |
|--------|-------------------|---------------------|-------|
| Cycle next window | `Alt+Tab` | - | Traditional alt-tab |
| Cycle prev window | `Alt+Shift+Tab` | - | |

### Mouse Operations

| Action | Omarchy (Hyprland) | Cyperx (Aerospace) | Notes |
|--------|-------------------|---------------------|-------|
| Move window (drag) | `Super+LMB drag` | - | |
| Resize window (drag) | `Super+RMB drag` | - | |

---

## Omarchy Full Keybinds (Non-Window-Management)

### App Launchers

| Keybind | Action |
|---------|--------|
| `Super+Space` | Application launcher |
| `Super+Return` | Terminal |
| `Super+Shift+Return` | Browser |
| `Super+Shift+Alt+B` | Browser (private) |
| `Super+Shift+F` | File manager |
| `Super+Shift+Alt+F` | File manager (cwd) |
| `Super+Shift+N` | Neovim editor |
| `Super+Shift+M` | Music (Spotify) |
| `Super+Shift+D` | Docker (LazyDocker) |
| `Super+Shift+O` | Obsidian |
| `Super+Shift+A` | AI (ChatGPT) |
| `Super+Shift+G` | Messenger (Signal) |
| `Super+Shift+Alt+G` | Messenger (WhatsApp) |
| `Super+Shift+Ctrl+G` | Messenger (Google) |
| `Super+Shift+C` | Calendar |
| `Super+Shift+E` | Email |
| `Super+Shift+X` | X |
| `Super+Shift+/` | Password manager (1Password) |

### System Controls

| Keybind | Action |
|---------|--------|
| `Super+Alt+Space` | Omarchy control menu |
| `Super+Escape` | System menu (lock/suspend/restart) |
| `Super+Ctrl+L` | Lock computer |
| `Super+Ctrl+A` | Audio controls |
| `Super+Ctrl+B` | Bluetooth controls |
| `Super+Ctrl+W` | Wifi controls |
| `Super+Ctrl+S` | Share menu (LocalSend) |
| `Super+Ctrl+T` | Activity (btop) |
| `Super+Ctrl+X` | Toggle dictation |
| `Super+K` | Show all keybindings |

### Clipboard

| Keybind | Action |
|---------|--------|
| `Super+C` | Copy |
| `Super+X` | Cut (not in terminal) |
| `Super+V` | Paste |
| `Super+Ctrl+V` | Clipboard manager |

### Screenshots & Capture

| Keybind | Action |
|---------|--------|
| `Print Screen` | Screenshot (region) |
| `Shift+Print Screen` | Screenshot (window) |
| `Ctrl+Print Screen` | Screenshot (monitor) |
| `Alt+Print Screen` | Screen record (region) |
| `Ctrl+Alt+Print Screen` | Screen record (monitor) |
| `Super+Print Screen` | Color picker |
| `Alt+Shift+L` | Copy current URL |

### Notifications

| Keybind | Action |
|---------|--------|
| `Super+,` | Dismiss latest notification |
| `Super+Shift+,` | Dismiss all notifications |
| `Super+Ctrl+,` | Toggle silencing |
| `Super+Alt+,` | Invoke last notification |
| `Super+Shift+Alt+,` | Restore last notification |

### Appearance

| Keybind | Action |
|---------|--------|
| `Super+Ctrl+Shift+Space` | Theme picker |
| `Super+Ctrl+Space` | Cycle backgrounds |
| `Super+Backspace` | Toggle window transparency |
| `Super+Shift+Backspace` | Toggle workspace gaps |
| `Super+Shift+Space` | Toggle top bar |
| `Super+Ctrl+Backspace` | Cycle monitor scaling |

### Toggles

| Keybind | Action |
|---------|--------|
| `Super+Ctrl+I` | Toggle idle/sleep prevention |
| `Super+Ctrl+N` | Toggle nightlight |
| `Super+Mute` | Switch audio output |

### Zoom

| Keybind | Action |
|---------|--------|
| `Super+Ctrl+Z` | Zoom in |
| `Super+Ctrl+Alt+Z` | Reset zoom |

### Quick Emojis (`CapsLock M + key`)

| Key | Emoji |
|-----|-------|
| `S` | Smile |
| `C` | Cry |
| `L` | Love |
| `H` | Heart |
| `Y` | Thumbs up |
| `N` | Thumbs down |
| `F` | Middle finger |
| `K` | Kiss |
| `P` | Pray |
| `M` | Money |
| `X` | Celebrate |
| `T` | Toast |
| `O` | OK |
| `G` | Wave |

### Tmux (Prefix: `Ctrl+Space`)

| Keybind | Action |
|---------|--------|
| `Prefix + v` | Split vertical |
| `Prefix + h` | Split horizontal |
| `Prefix + x` | Kill pane |
| `Prefix + z` | Toggle pane zoom |
| `Prefix + c` | New window |
| `Prefix + k` | Kill window |
| `Prefix + r` | Rename window |
| `Prefix + C` | New session |
| `Prefix + K` | Kill session |
| `Prefix + R` | Rename session |
| `Prefix + N` | Next session |
| `Prefix + P` | Previous session |
| `Prefix + s` | List sessions |
| `Prefix + d` | Detach |
| `Prefix + q` | Reload config |
| `Alt+1-9` | Go to window |
| `Ctrl+Alt+Arrows` | Move between panes |
| `Ctrl+Alt+Shift+Arrows` | Resize panes |

### Ghostty Terminal

| Keybind | Action |
|---------|--------|
| `Ctrl+Shift+E` | New split below |
| `Ctrl+Shift+O` | New split beside |
| `Ctrl+Alt+Arrows` | Move between splits |
| `Super+Ctrl+Shift+Arrows` | Resize split (10) |
| `Super+Ctrl+Shift+Alt+Arrows` | Resize split (100) |
| `Ctrl+Shift+T` | New tab |
| `Ctrl+Shift+Arrows` | Move between tabs |
| `Shift+PgUp/PgDn` | Scroll history |

---

## Key Design Differences

### Modifier Philosophy
| Aspect | Omarchy | Cyperx |
|--------|---------|--------|
| Primary modifier | `Super` (single key) | Multi-key combos (`Shift+Ctrl`, etc.) |
| Direction keys | Arrow keys | vim hjkl |
| Workspace access | `Super+Number` (direct) | `Cmd+homerow` + `Ctrl+Shift+Number` |
| Tmux prefix | `Ctrl+Space` | `Ctrl+A` |

### Omarchy Has / Cyperx Doesn't
- Window grouping (tabbed containers)
- Scratchpad workspace
- Alt+Tab window cycling
- Mouse drag move/resize
- Pop-out sticky floating
- Silent workspace moves (move window without following)
- Former workspace jump (`Super+Ctrl+Tab`)
- Close all windows
- Directional resize (4 directions)

### Cyperx Has / Omarchy Doesn't
- Join-with operations (tree manipulation)
- Tiles vs Accordion layout switching
- Flatten workspace tree (balance)
- Service mode (multi-step operations)
- Smart context-aware resize
- Homerow workspace navigation (`Cmd+j/k/l/u/i/o`)
- Move window to next/prev workspace (wrap-around)

---

## Sources

- [Omarchy GitHub Repository](https://github.com/basecamp/omarchy)
- [The Omarchy Manual - Hotkeys](https://learn.omacom.io/2/the-omarchy-manual/53/hotkeys)
- [Omarchy 3.x Cheat Sheet](https://gist.github.com/iagooar/e161ac5a2564b82a25a209076a38a503)
