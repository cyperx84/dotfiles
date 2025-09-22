# Dotfiles Keybinds & Aliases Reference

> **📖 Quick Navigation**
> [Window Management](#window-management) • [Session Workflow](#session-workflow) • [File Operations](#file-operations) • [Git Workflow](#git-workflow) • [Development Tools](#development-tools) • [Search & Navigation](#search--navigation) • [System Integration](#system-integration)

## Table of Contents

- [Window Management](#window-management) - Window focus, movement, resizing across Yabai/Tmux
- [Session Workflow](#session-workflow) - Tmux sessions, Sesh, Tmuxinator integration
- [File Operations](#file-operations) - File managers, directory navigation, listing
- [Git Workflow](#git-workflow) - Git aliases and operations
- [Development Tools](#development-tools) - Docker, Kubernetes, Python, Claude
- [Search & Navigation](#search--navigation) - FZF, Telescope, Zoxide integration
- [System Integration](#system-integration) - Hardware remapping, clipboard, system controls

---

## Window Management

### Yabai Window Operations (SKHD)
*Source: `skhd/.config/skhd/skhdrc`*

| Keybind | Action | Description |
|---------|---------|-------------|
| `Shift+Ctrl+h/j/k/l` | Focus window | Move focus to west/south/north/east |
| `Shift+Ctrl+Alt+h/j/k/l` | Move window | Warp window to west/south/north/east |
| `Ctrl+Alt+Cmd+h/j/k/l` | Resize window | Resize window in direction |
| `Ctrl+1/2/3/4/5` | Focus space | Switch to desktop space |
| `Shift+Alt+1/2/3/4/5` | Move to space | Move window to space |
| `Alt+t` | Toggle float | Float/unfloat window and center |
| `Alt+p` | Picture-in-picture | Toggle sticky + PiP mode |
| `Ctrl+Cmd+w` | Fullscreen | Toggle zoom-fullscreen |
| `Ctrl+Cmd+r` | Balance | Balance window sizes |
| `Shift+Alt+s/g` | Move display | Move window to left/right display |

### Tmux Pane & Window Navigation
*Source: `tmux/.tmux.conf`*

| Keybind | Action | Description |
|---------|---------|-------------|
| `C-a` | Prefix | Tmux prefix key |
| `C-a h/j/k/l` | Focus pane | Select pane in direction |
| `C-a C-h/C-j/C-k/C-l` | Resize pane | Resize pane (repeatable) |
| `C-a c` | New window | Create new window in current path |
| `C-a s` | Vertical split | Split window vertically |
| `C-a v` | Horizontal split | Split window horizontally |
| `C-a r` | Reload config | Reload tmux configuration |
| `C-a b` | Toggle status | Toggle status bar visibility |
| `C-a x` | Kill pane | Close pane without confirmation |

---

## Session Workflow

### Tmux Session Management
*Source: `tmux/.tmux.conf`*

| Keybind | Action | Description |
|---------|---------|-------------|
| `C-a T` | Session switcher | FZF-powered session switcher with sesh |
| `C-a L` | Last session | Switch to last session via sesh |
| `C-a 9` | Root session | Connect to session at current directory |
| `C-a N` | New session | Create new named session |
| `C-a R` | Rename session | Rename current session |
| `C-a X` | Kill session | Kill current session with confirmation |
| `C-a M` | Tmuxinator | Launch tmuxinator project with FZF |

### Sesh Aliases
*Source: `sesh/.config/sesh/scripts/sesh_aliases.sh`*

| Alias | Command | Description |
|-------|---------|-------------|
| `sl` | `sesh list -t -c` | List sessions (compact) |
| `slj` | `sesh list -t -c -J` | List sessions as JSON |
| `sc` | `sesh connect` | Connect to session |
| `sd` | `sesh connect $(sesh list \| fzf)` | Fuzzy connect to session |
| `sesh-active` | `tmux list-sessions` | Show active sessions |
| `sesh-windows` | `tmux list-windows` | Show windows in current session |
| `sesh-panes` | `tmux list-panes -a` | Show all panes |
| `sesh-tmux` | `tmuxinator list` | List tmuxinator sessions |
| `sesh-start` | `tmuxinator start` | Start tmuxinator session |
| `sesh-kill` | `tmux kill-session -t` | Kill specific session |
| `sesh-kill-all` | `tmux kill-server` | Kill all sessions |

### Sesh Functions
*Source: `sesh/.config/sesh/scripts/sesh_aliases.sh`*

| Function | Description |
|----------|-------------|
| `sesh-info [session]` | Get detailed session information |
| `sesh-current` | Show current session details and path |
| `sesh-dashboard` | Comprehensive session status dashboard |

### Zsh Session Integration
*Source: `zsh/.zshrc`*

| Keybind | Action | Description |
|---------|---------|-------------|
| `Alt+s` / `\es` | Sesh sessions | FZF session selector with immediate connect |

---

## File Operations

### File Managers & Navigation
*Source: `zsh/.zshrc`, Neovim configs*

| Alias/Function | Tool | Description |
|----------------|------|-------------|
| `ls` | `eza -l --icons --git -a` | Enhanced file listing |
| `ll` | `eza --color=always --long --git --icons=always` | Detailed file listing |
| `lt` | `eza --tree --level=2 --long --icons --git` | Tree view with details |
| `ltree` | `eza --tree --level=2 --icons --git` | Simple tree view |
| `l` | `eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions` | Clean file listing |

### Directory Navigation
*Source: `zsh/.zshrc`*

| Alias/Function | Description |
|----------------|-------------|
| `..` | `cd ..` |
| `...` | `cd ../..` |
| `....` | `cd ../../..` |
| `.....` | `cd ../../../..` |
| `......` | `cd ../../../../..` |
| `C` | `cd ~/Code/` |
| `conf` | `cd $HOME/dotfiles && nvim` |
| `no` | Open Obsidian notes in nvim |

### FZF Navigation Functions
*Source: `zsh/.zshrc`*

| Function | Description |
|----------|-------------|
| `fcd()` | Fuzzy directory navigation with eza preview |
| `f()` | Yazi file manager with cd integration |
| `fv()` | Fuzzy file selection for nvim editing |

### Sesh File Integration
*Source: `sesh/.config/sesh/scripts/sesh_aliases.sh`*

| Alias | Description |
|-------|-------------|
| `sesh-files` | Open yazi file manager |
| `sesh-tree` | Enhanced directory tree with eza |

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
| `ga` | `git add -p` | Interactive add |
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

### Python & Development
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
| `cld` | `/Users/cyperx/.claude/local/claude --dangerously-skip-permissions` | Claude CLI (unsafe mode) |
| `claude` | `/Users/cyperx/.claude/local/claude` | Claude CLI (safe mode) |

### HTTP & Networking
*Source: `zsh/.zshrc`*

| Alias | Command | Description |
|-------|---------|-------------|
| `http` | `xh` | Modern HTTP client |
| `nm` | `nmap -sC -sV -oN nmap` | Nmap with scripts |

---

## Search & Navigation

### FZF Configuration
*Source: `zsh/.zshrc`*

| Environment Variable | Value | Description |
|---------------------|-------|-------------|
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

### Hardware Remapping - Karabiner Elements
*Source: `karabiner/.config/karabiner/karabiner.json`*

| From | To | Description |
|------|-----|-------------|
| `Caps Lock` | `Left Control` | Caps as Control |
| `Right Command` | `Backspace` | Right Cmd as Backspace |
| `Right Shift` | `Backspace` | Right Shift as Backspace |

### Hardware Remapping - Kanata (Alternative)
*Source: `kanata/.config/kanata/kanata.kbd`*

| Key | Tap | Hold | Description |
|-----|-----|------|-------------|
| `a` | `a` | `Left Meta` | Home row modifier |
| `s` | `s` | `Left Alt` | Home row modifier |
| `d` | `d` | `Left Shift` | Home row modifier |
| `f` | `f` | `Left Control` | Home row modifier |
| `j` | `j` | `Right Control` | Home row modifier |
| `k` | `k` | `Right Shift` | Home row modifier |
| `l` | `l` | `Right Alt` | Home row modifier |
| `;` | `;` | `Right Meta` | Home row modifier |

### Zsh Keybinds
*Source: `zsh/.zshrc`*

| Keybind | Action | Description |
|---------|---------|-------------|
| `^e` | `autosuggest-execute` | Execute suggestion |
| `^w` | `autosuggest-accept` | Accept suggestion |
| `^u` | `autosuggest-toggle` | Toggle suggestions |
| `^f` | `vi-forward-word` | Forward word |
| `^p` | `down-line-or-search` | Down/search |
| `jk` | `vi-cmd-mode` | Enter vi command mode |

### SketchyBar Integration
*Source: `zsh/.zshrc`*

| Function | Trigger | Description |
|----------|---------|-------------|
| `brew()` | Various brew commands | Notify SketchyBar on package changes |

---

## Related Documentation

- [Neovim Keybinds](NEOVIM_KEYBINDS.md) - Comprehensive Neovim mappings
- [Workflow Guides](WORKFLOW_GUIDES.md) - Cross-tool integration workflows
- [CLAUDE.md](../CLAUDE.md) - Main dotfiles documentation

---

## Quick Reference Card

### Most Used Keybinds
```
Window Management:    Shift+Ctrl+hjkl (focus), Ctrl+1-5 (spaces)
Sessions:            Alt+s (sesh), C-a T (tmux switcher)
Files:               fcd (fuzzy cd), f (yazi), C-e (oil)
Git:                 gs (status), gc "msg" (commit), gp (push)
Development:         ta (tmux), n (nvim), dps (docker ps)
```

### Integration Points
- **SKHD + Tmux**: Window management spans both tools
- **Sesh + Tmux**: Session management with enhanced workflow
- **FZF + Multiple**: Fuzzy finding across file, session, git operations
- **Eza + Navigation**: Enhanced listings in file operations