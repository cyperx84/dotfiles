# Workflow Integration Guides

> **🔄 Cross-Tool Workflows**
> This document demonstrates how different tools in the dotfiles ecosystem integrate to create seamless development workflows.

## Table of Contents

- [Session Management Workflow](#session-management-workflow)
- [File Navigation & Editing](#file-navigation--editing)
- [Git Development Workflow](#git-development-workflow)
- [Window Management Workflow](#window-management-workflow)
- [Search & Discovery Workflow](#search--discovery-workflow)
- [Development Project Setup](#development-project-setup)
- [Note-Taking & Documentation](#note-taking--documentation)

---

## Session Management Workflow

### Starting a Development Session

**Goal**: Quick project switching with proper environment setup

```bash
# Method 1: Sesh + FZF (recommended)
sd                          # Fuzzy connect to any session
# or Alt+s from anywhere     # ZSH keybind for session selection

# Method 2: Tmux Session Switcher (from within tmux)
C-a T                       # Advanced session switcher with previews
```

**Integration Points:**
- **Sesh** provides the session definitions
- **Tmux** handles the actual session management
- **FZF** powers the fuzzy selection interface
- **Zsh** provides quick access keybind

### Session Monitoring

```bash
# Quick status check
sesh-dashboard              # Comprehensive session overview
sesh-current               # Current session details
sesh-active                # List active sessions

# Tmux native
C-a T                      # Session switcher with status
```

---

## File Navigation & Editing

### Multi-Level File Access

**Goal**: Efficient file access at different granularities

```bash
# Level 1: Quick directory navigation
fcd                        # Fuzzy directory change with eza preview
C                          # Quick jump to ~/Code/
conf                       # Quick jump to dotfiles

# Level 2: File managers (from terminal)
f                          # Yazi with cd integration
lt                         # Tree view with details

# Level 3: Neovim file management
<leader>e                  # Mini.files (toggle, context-aware)
<C-e>                      # Oil floating (parent directory)
-                          # Yazi from within Neovim
<leader>E                  # Neotree (traditional tree)

# Level 4: Search-based access
<leader>sf                 # Telescope find files
<leader>s.                 # Recent files
<leader><leader>           # Open buffers
```

**Integration Flow:**
1. Use `fcd` or `C` for directory-level navigation
2. Use `f` (Yazi) for file browsing with cd capability
3. Open Neovim and use `<leader>sf` for project-wide file search
4. Use `<leader>e` for quick adjacent file access

### File Editing Workflow

```bash
# Quick edit workflows
fv                         # Fuzzy find + edit in new nvim instance
no                         # Open Obsidian notes
conf                       # Edit dotfiles

# From within Neovim
<leader>sf                 # Find and open files
<leader>-                  # Yazi for file browsing
<C-e>                      # Oil for directory operations
```

---

## Git Development Workflow

### Complete Git Workflow Integration

**Scenario**: Feature development from start to finish

```bash
# 1. Terminal Git Operations (initial setup)
gs                         # Git status
gb                         # List branches
gco -b feature-branch      # Create new branch
gc "Initial commit"        # Quick commit

# 2. Neovim Git Operations (during development)
<leader>gg                 # Open Neogit (main interface)
<leader>gd                 # View diffs
<leader>gs                 # Staging operations
<leader>gc                 # Commit with detailed interface

# 3. Advanced Operations
<leader>gW                 # Create git worktree
<leader>gt                 # Switch between worktrees
<leader>gl                 # View git log
<leader>gP                 # Pull changes
<leader>gp                 # Push changes

# 4. Terminal finalization
gp                         # Quick push
ghl                        # List GitHub repos (if using GitHub CLI)
```

**Tool Responsibilities:**
- **Zsh aliases**: Quick, common operations
- **Neogit**: Complex operations with visual interface
- **Git worktree**: Parallel development workflows
- **GitHub CLI**: Repository management

---

## Window Management Workflow

### Seamless Window & Pane Navigation

**Goal**: Unified navigation across HyprSpace windows and Tmux panes

```bash
# HyprSpace Window Management (system-wide - PRIMARY with Dwindle layout)
Shift+Ctrl+h/j/k/l         # Focus windows
Shift+Ctrl+Alt+h/j/k/l     # Move windows
Ctrl+Alt+Cmd+j/k           # Resize windows (smart, context-aware)
Cmd+j/k/l                  # Switch workspaces 1-3 (homerow)
Ctrl+Shift+1-9             # Switch workspaces 1-9

# Tmux Pane Management (within terminal)
C-a h/j/k/l                # Focus panes
C-a C-h/C-j/C-k/C-l        # Resize panes
C-a s                      # Vertical split
C-a v                      # Horizontal split

# Neovim Window Management (within editor)
<C-h/j/k/l>                # Navigate windows (integrates with tmux)
```

**Integration**: The vim-tmux-navigator plugin allows `<C-h/j/k/l>` to seamlessly navigate between Neovim windows and Tmux panes.

### Layout Management

```bash
# HyprSpace Layouts (PRIMARY - Dwindle Layout)
# Note: Dwindle auto-splits based on window aspect ratio
Shift+Ctrl+e               # Toggle float/tile
Shift+Ctrl+v               # Toggle horizontal/vertical orientation
Shift+Ctrl+t               # Tiles layout
Shift+Ctrl+a               # Accordion layout
Shift+Ctrl+w               # Toggle fullscreen
Shift+Ctrl+r               # Balance windows (flatten workspace tree)
Shift+Alt+Cmd+r            # Enter service mode for advanced operations

# Tmux Layouts
C-a T                      # Session switcher
C-a N                      # New session
```

---

## Search & Discovery Workflow

### Progressive Search Strategy

**Goal**: Find anything efficiently using the right tool for the job

```bash
# Level 1: File System Search
fcd                        # Find directories
fv                         # Find files for editing
ls                         # Enhanced listing (eza)
lt                         # Tree view

# Level 2: Content Search (Neovim)
<leader>sg                 # Live grep across project
<leader>sw                 # Search current word
<leader>s/                 # Search in open files
<leader>sd                 # Search diagnostics

# Level 3: Specialized Search
<leader>sk                 # Search keymaps
<leader>sh                 # Search help
<leader>ss                 # Search telescope pickers
<leader>sl                 # Search notifications

# Level 4: Tool-Specific Search
<leader>of                 # Obsidian quick switch
<leader>os                 # Obsidian search
<leader>ot                 # Obsidian tags
```

**Search Strategy:**
1. Use `fcd`/`fv` for quick file system navigation
2. Use Telescope (`<leader>sg`) for content search within projects
3. Use specialized searches for tool-specific content
4. Use Obsidian search for knowledge management

---

## Development Project Setup

### New Project Workflow

**Scenario**: Setting up a new development project

```bash
# 1. Directory Setup
C                          # Navigate to ~/Code/
mkdir new-project && cd new-project

# 2. Session Creation
sc new-project             # Create/connect to sesh session

# 3. Initial Setup (within session)
git init
ga .                       # Add files
gc "Initial commit"        # Initial commit

# 4. Development Environment
n                          # Open Neovim
<leader>e                  # File explorer
<leader>gg                 # Git interface

# 5. Window Layout (if needed)
C-a v                      # Split for terminal
C-a s                      # Additional splits
C-a T                      # Switch between sessions as needed
```

### Container Development

```bash
# Docker workflow integration
dock                       # Start Docker Desktop
dco up -d                  # Start services
dps                        # Check containers
dx <container> bash        # Interactive shell

# Kubernetes workflow
kc <context>               # Switch context
kns <namespace>            # Set namespace
kg pods                    # Check resources
kl <pod>                   # Follow logs
```

---

## Note-Taking & Documentation

### Obsidian Integration Workflow

**Scenario**: Knowledge management integrated with development

```bash
# Quick note access
no                         # Open Obsidian notes (terminal)

# From within Neovim (in any file)
<leader>on                 # Create new note
<leader>of                 # Quick switch to note
<leader>os                 # Search notes
<leader>ol                 # Show links
<leader>ob                 # Show backlinks

# Note editing workflow
<leader>oc                 # Toggle checkboxes
<leader>op                 # Paste images
<leader>oF                 # Follow links
<leader>oe                 # Extract selected text to new note
```

### Documentation Workflow

```bash
# Creating documentation
<leader>sf                 # Find existing docs
<leader>e                  # Browse with mini.files
<leader>tm                 # Toggle Markview for preview

# Image handling
<leader>pi                 # Paste images
<leader>op                 # Paste images (Obsidian)

# Cross-referencing
<leader>sg                 # Search across all files
<leader>sw                 # Search current word in project
```

---

## Common Workflow Patterns

### The "Context Switch"

When switching between different projects or contexts:

```bash
# 1. Save current state
<leader>bw                 # Close buffers but keep splits (Neovim)
C-a d                      # Detach from current session (Tmux)

# 2. Switch context
sd                         # Select new session/project
# or Alt+s                 # Quick session selector

# 3. Orient in new context
<leader><leader>           # See open buffers
ls                         # Check directory contents
```

### The "Deep Dive"

When you need to thoroughly explore unfamiliar code:

```bash
# 1. Get oriented
<leader>sf                 # Browse file structure
lt                         # See directory tree
<leader>gg                 # Check git status

# 2. Explore codebase
<leader>sg <search-term>   # Search for relevant code
<leader>sw                 # Search current word/symbol
<leader>sd                 # Check diagnostics

# 3. Take notes
<leader>on                 # Create notes about findings
<leader>oe                 # Extract code snippets to notes
```

### The "Quick Fix"

For small, focused changes:

```bash
# 1. Quick access
fv                         # Find and edit file
# or <leader>sf            # Find file from within editor

# 2. Make changes
<leader>gg                 # Git interface for staging
<leader>gc                 # Commit changes

# 3. Quick exit
gc "Quick fix: description" # Terminal git commit
gp                         # Push changes
```

---

## Integration Points Summary

| Workflow Area | Primary Tools | Integration Method |
|---------------|---------------|-------------------|
| Session Management | Sesh + Tmux + FZF | Shared session names, FZF selection |
| File Navigation | Eza + Yazi + Telescope | Consistent preview, similar interfaces |
| Git Operations | Zsh aliases + Neogit | Quick terminal ops, detailed GUI ops |
| Window Management | HyprSpace + JankyBorders + Tmux + Neovim | Unified navigation keybinds, dwindle layout |
| Search | FZF + Telescope + ripgrep | Consistent fuzzy finding paradigm |
| Note-Taking | Obsidian + Telescope | Cross-search capabilities |

The key to these workflows is that each tool handles what it does best, while maintaining consistent interfaces (especially FZF-based selection) across the ecosystem.