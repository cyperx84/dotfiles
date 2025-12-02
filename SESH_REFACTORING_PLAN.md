# Sesh Scripts Consolidation & Refactoring Plan

## Overview
Consolidate 15 sesh-related scripts from `tmux/.tmux/scripts/` into `sesh/.config/sesh/scripts/`, eliminate 30% code duplication (~1000 lines), and refactor into clean modular architecture.

**Current State**: 15 scripts + scattered across tmux folder + ~3500 lines + 30% duplication
**Target State**: 9 scripts + 4 shared modules + ~2500 lines + centralized in sesh folder

---

## Phase 1: Directory Structure & Consolidation

### 1.1 Create New Directory Structure
**Location**: `sesh/.config/sesh/scripts/`

```
sesh/.config/sesh/
├── sesh.toml                          # Existing config file
├── list_enhanced.conf                 # Existing config file
└── scripts/                           # NEW DIRECTORY
    ├── lib/                           # NEW - Shared modules
    │   ├── sesh_common.sh            # Core utilities (configs, errors, setup)
    │   ├── sesh_colors.sh            # Color palette constants
    │   ├── sesh_icons.sh             # Icon definitions
    │   └── sesh_preview_common.sh    # Preview helper functions
    ├── core/                          # NEW - Core entry points
    │   ├── sesh_switcher.sh          # Main session switcher (updated paths)
    │   ├── sesh_list.sh              # Unified list (replaces 5 scripts)
    │   ├── sesh_preview.sh           # Unified preview (replaces 4 scripts)
    │   ├── sesh_edit.sh              # Session editor (simplified)
    │   └── sesh_clean_selection.sh   # Output sanitizer (simplified)
    └── utils/                         # NEW - Operation scripts
        ├── sesh_create_new.sh        # New session creation (simplified)
        ├── sesh_smart_start.sh       # Smart project detection (keep as-is)
        ├── sesh_kill.sh              # Session termination (simplified)
        └── sesh_session_helper.sh    # General utilities (merged from session_helper.sh)
```

### 1.2 Consolidation Steps
1. Create `sesh/.config/sesh/scripts/` directory structure
2. Move scripts from `tmux/.tmux/scripts/sesh_*.sh` to appropriate sesh folders
3. Update all script references to use new paths
4. Update `sesh.toml` preview_command path
5. Remove old scripts from tmux folder
6. Update tmux.conf keybinding path

---

## Phase 2: Create Shared Modules (Reduce Duplication)

### 2.1 `sesh_common.sh` - Core Utilities Module
**Purpose**: Centralized configuration, error handling, common utilities
**Lines**: ~150
**Replaces/Reduces**: Duplicated configs across 15 scripts

**Contents**:
```bash
# Configuration paths (replaces hardcoded paths in 7+ scripts)
export SESH_CONFIG
export SESH_SCRIPTS_DIR
export TMUXINATOR_CONFIG_DIR
export SESH_DISPLAY_MODE_FILE
export SESH_CACHE_FILE
export SESH_CACHE_TTL

# Error handling (extract from sesh_switcher.sh lines 50-75)
error_handler()
cleanup_handler()
setup_error_handling()

# Utility functions (shared across scripts)
clean_session_name()           # Used by 7 scripts
detect_session_type()          # Used by 5 scripts
is_sesh_toml_session()         # Used by 4 scripts
get_sesh_toml_path()           # Used by 2 scripts
get_active_sessions()          # Used by 4 scripts
```

**Extracted From**:
- sesh_switcher.sh (error handling: 50-75)
- sesh_preview.sh (lines 49-77, 83-127, 129-146)
- sesh_list_enhanced.sh (lines 197-206, 707-710, 757-781)
- sesh_clean_selection.sh (lines 7-50)
- sesh_edit.sh (lines 7-27)
- kill_sesh_session.sh (line 10)

---

### 2.2 `sesh_colors.sh` - Color Palette Module
**Purpose**: Single source of truth for colors
**Lines**: ~40
**Replaces**: Duplicated color definitions in 6 scripts

**Contents**:
```bash
# CyberX Neon color palette
COLOR_NEON_GREEN='\033[38;2;128;255;0m'
COLOR_NEON_CYAN='\033[38;2;0;255;255m'
COLOR_NEON_MAGENTA='\033[38;2;255;0;127m'
COLOR_NEON_YELLOW='\033[38;2;255;255;0m'
COLOR_NEON_RED='\033[38;2;255;0;31m'
# ... (extracted from sesh_list_enhanced.sh lines 80-108)
```

**Extracted From**:
- sesh_list_enhanced.sh (lines 80-108)
- sesh_list_cached.sh (lines 30-34)
- sesh_list_lightweight.sh (lines 12-16)
- sesh_preview.sh (lines 19-28)
- sesh_preview_fast.sh (lines 8-14)
- session_helper.sh (lines 8-15)

---

### 2.3 `sesh_icons.sh` - Icon Definitions Module
**Purpose**: Centralized icon system
**Lines**: ~30
**Replaces**: Icon definitions in 3 scripts

**Contents**:
```bash
# Session status icons
ICON_ATTACHED='●'
ICON_ACTIVE='◉'
ICON_DEAD='◆'
ICON_CUSTOM='✦'
# ... (extracted from sesh_list_enhanced.sh lines 114-149)

# Session type icons
ICON_TMUX='⌨'
ICON_DIRECTORY='📁'
ICON_TMUXINATOR='⚙'
ICON_GIT='🌿'
```

**Extracted From**:
- sesh_list_enhanced.sh (lines 114-149)
- sesh_list_cached.sh (lines 36-38)
- sesh_list_lightweight.sh (lines 18-20)

---

### 2.4 `sesh_preview_common.sh` - Preview Functions Module
**Purpose**: Shared preview rendering functions
**Lines**: ~120
**Replaces**: Duplicated preview logic in 4 scripts

**Contents**:
```bash
# Preview helper functions (extracted from sesh_preview_fast.sh)
show_tmux_session_preview()    # Lines 29-60
show_tmuxinator_preview()      # Lines 62-93
show_directory_preview()       # Lines 134-149
show_no_session_preview()      # Show "No session found" message
human_time()                   # Lines 36-47 from sesh_preview.sh
```

**Extracted From**:
- sesh_preview.sh (lines 36-47, 152-340)
- sesh_preview_fast.sh (lines 29-155)
- session_helper.sh (lines 18-127)

---

## Phase 3: Consolidate Overlapping Scripts

### 3.1 Create Unified `sesh_list.sh`
**Replaces**: 5 scripts
- sesh_list_lightweight.sh (40 lines)
- sesh_list_enhanced.sh (889 lines) - **Keep as primary**
- sesh_list_cached.sh (61 lines)
- sesh_list_wrapper.sh (37 lines)
- sesh_list_icons.sh (26 lines)

**Strategy**: Use sesh_list_enhanced.sh as base, add:
- `--mode` flag for compact vs detailed output
- `--cache` flag for caching support (integrate sesh_list_cached.sh logic)
- `--sort` flag for alphabetical sorting
- Read display mode from `~/.sesh_display_mode`

**Lines**: ~600 (from 889 + simplified with shared modules)
**Changes**:
- Remove ANSI color definitions (source from sesh_colors.sh)
- Remove icon definitions (source from sesh_icons.sh)
- Remove clean_session_name (call from sesh_common.sh)
- Remove active session detection (call from sesh_common.sh)
- Add mode flag handling
- Add cache logic from sesh_list_cached.sh (lines 25-60)

---

### 3.2 Create Unified `sesh_preview.sh`
**Replaces**: 4 scripts
- sesh_preview.sh (366 lines)
- sesh_preview_fast.sh (156 lines) - **Use as base**
- sesh_preview_with_keybinds.sh (16 lines)
- session_helper.sh (138 lines)

**Strategy**: Use sesh_preview_fast.sh as base, add:
- Keybinds header display (from sesh_preview_with_keybinds.sh)
- Helper utility functions (from session_helper.sh)
- Read display mode

**Lines**: ~180 (from 156 + keybinds header + helper functions)
**Changes**:
- Remove color definitions (source from sesh_colors.sh)
- Remove preview helper functions (source from sesh_preview_common.sh)
- Remove human_time function (source from sesh_common.sh)
- Add keybinds header generation (from sesh_preview_with_keybinds.sh line 11)
- Update keybinds header: `⌥n → ⌥c` and add `esc close`
- Add session helper functions (from session_helper.sh)

---

## Phase 4: Simplify Operation Scripts

### 4.1 `sesh_create_new.sh` - Simplified
**Current**: 34 lines
**After**: ~20 lines

**Changes**:
- Remove clean_session_name logic (call from sesh_common.sh)
- Remove tmux has-session check logic (call from sesh_common.sh)
- Keep sesh_smart_start.sh call as-is

---

### 4.2 `sesh_kill.sh` (rename from kill_sesh_session.sh)
**Current**: 23 lines
**After**: ~15 lines

**Changes**:
- Remove clean_session_name logic (call from sesh_common.sh)
- Remove session type detection (call from sesh_common.sh)
- Keep cache invalidation logic

---

### 4.3 `sesh_edit.sh` - Simplified
**Current**: 29 lines
**After**: ~15 lines

**Changes**:
- Remove session type detection (call from sesh_common.sh)
- Keep tmux and nvim integration

---

### 4.4 `sesh_clean_selection.sh` - Simplified
**Current**: 52 lines
**After**: ~30 lines

**Changes**:
- Remove ANSI code removal (call from sesh_common.sh)
- Remove icon removal (call from sesh_common.sh)
- Keep metadata stripping logic

---

### 4.5 `sesh_smart_start.sh` - Keep As-Is
**Current**: 114 lines
**Action**: No changes, move to utils/ folder

---

### 4.6 `sesh_session_helper.sh` (merge from session_helper.sh)
**Current**: 138 lines (session_helper.sh)
**After**: ~80 lines

**Changes**:
- Remove preview functions (moved to sesh_preview_common.sh)
- Keep utility functions (list-sessions, kill-session, etc.)
- Merge into new utils/sesh_session_helper.sh

---

## Phase 5: Update Entry Points

### 5.1 Update `sesh_switcher.sh`
**Changes**:
- Line 130: Update SESH_SCRIPTS_DIR to point to sesh folder
  ```bash
  # OLD: readonly TMUX_SCRIPTS_DIR="${TMUX_SCRIPTS_DIR:-${HOME}/.tmux/scripts}"
  # NEW: readonly SESH_SCRIPTS_DIR="${SESH_SCRIPTS_DIR:-${HOME}/.config/sesh/scripts}"
  ```
- Lines 133-139: Update all script references
  ```bash
  # OLD: "${TMUX_SCRIPTS_DIR}/sesh_list_lightweight.sh"
  # NEW: "${SESH_SCRIPTS_DIR}/core/sesh_list.sh --mode=lightweight"
  ```
- Add source for sesh_common.sh at top (after shebang)
- Update all paths to use sesh folder

---

### 5.2 Update `sesh.toml`
**Changes**:
- Line 64: Update preview_command path
  ```toml
  # OLD: preview_command = "~/.tmux/scripts/sesh_preview.sh {}"
  # NEW: preview_command = "~/.config/sesh/scripts/core/sesh_preview.sh {}"
  ```

---

### 5.3 Update `tmux.conf`
**Changes**:
- Line 97: Update keybinding path
  ```bash
  # OLD: bind-key "e" run-shell "~/.tmux/scripts/sesh_switcher.sh"
  # NEW: bind-key "e" run-shell "~/.config/sesh/scripts/core/sesh_switcher.sh"
  ```

---

## Phase 6: Fix Keybinds Header Issue

### 6.1 Update Keybinds Display
**File**: sesh_preview.sh (new unified preview)
**Line**: ~11 (in keybinds header generation)

**Current**:
```bash
echo "  Keybinds: ⌥n new | ⌥k kill | ^b all | ^t tmux-only | ^/ zoxide | ^r $MODE_LABEL | ^s sort | ^d/u preview"
```

**Updated**:
```bash
echo "  Keybinds: ⌥c new | ⌥k kill | ^b all | ^t tmux-only | ^/ zoxide | ^r $MODE_LABEL | ^s sort | ^d/u preview | esc close"
```

**Changes**:
- `⌥n` → `⌥c` (matches actual Alt+C keybind)
- Add `esc close` (documents Esc keybind)

---

## Phase 7: Stow Integration

### 7.1 Verify Stow Symlinks
**Symlinks Created**:
```
~/.config/sesh/scripts/lib/ → ~/dotfiles/sesh/.config/sesh/scripts/lib/
~/.config/sesh/scripts/core/ → ~/dotfiles/sesh/.config/sesh/scripts/core/
~/.config/sesh/scripts/utils/ → ~/dotfiles/sesh/.config/sesh/scripts/utils/
```

**Restow**: `stow -R sesh` (after moving files)

---

## Implementation Task Breakdown

### Task Group 1: Shared Modules (Sub-Agent: Code Writer)
1. Create `sesh_common.sh` with 8 shared functions
2. Create `sesh_colors.sh` with color palette
3. Create `sesh_icons.sh` with icon definitions
4. Create `sesh_preview_common.sh` with preview functions
5. **Dependencies**: Read all source scripts for extraction

### Task Group 2: Consolidate List Scripts (Sub-Agent: Code Writer)
1. Create unified `sesh_list.sh` from sesh_list_enhanced.sh
2. Add `--mode`, `--cache`, `--sort` flags
3. Remove duplicated logic, source from shared modules
4. Test all modes: compact, detailed, sorted, cached
5. **Dependencies**: Shared modules from Task Group 1

### Task Group 3: Consolidate Preview Scripts (Sub-Agent: Code Writer)
1. Create unified `sesh_preview.sh` from sesh_preview_fast.sh
2. Add keybinds header (with corrected Alt+C, add Esc)
3. Merge helper functions from session_helper.sh
4. Remove duplicated logic, source from shared modules
5. Test preview display, keybinds header
6. **Dependencies**: Shared modules from Task Group 1

### Task Group 4: Simplify Operation Scripts (Sub-Agent: Code Writer)
1. Simplify `sesh_create_new.sh` (call shared functions)
2. Simplify `sesh_kill.sh` (call shared functions)
3. Simplify `sesh_edit.sh` (call shared functions)
4. Simplify `sesh_clean_selection.sh` (call shared functions)
5. Rename kill_sesh_session.sh → sesh_kill.sh
6. Keep `sesh_smart_start.sh` as-is
7. Create `sesh_session_helper.sh` (merge from session_helper.sh)
8. **Dependencies**: Shared modules from Task Group 1

### Task Group 5: Update Entry Points (Sub-Agent: Code Updater)
1. Update `sesh_switcher.sh` - path references
2. Update `sesh.toml` - preview_command path
3. Update `tmux.conf` - keybinding path
4. Source sesh_common.sh in all scripts
5. **Dependencies**: All previous groups

### Task Group 6: Directory Migration (Sub-Agent: File Organizer)
1. Create directory structure in sesh folder
2. Move all scripts to appropriate locations
3. Delete old scripts from tmux folder
4. Run `stow -R sesh`
5. Verify all symlinks created correctly
6. **Dependencies**: All scripts refactored in previous groups

### Task Group 7: Validation & Testing (Sub-Agent: QA Tester)
1. Test sesh switcher (Prefix+e)
2. Test all keybinds (Alt+C, Alt+K, Ctrl+T, Ctrl+B, Ctrl+/, Ctrl+R, Ctrl+S, Esc)
3. Test session creation, killing, editing
4. Test preview display with keybinds header
5. Test all list modes (compact, detailed, sorted)
6. Verify no broken symlinks
7. Check sesh.toml reads correct paths
8. **Dependencies**: All groups complete

### Task Group 8: Cleanup (Sub-Agent: Maintenance)
1. Remove old sesh_*.sh files from tmux folder
2. Remove session_helper.sh
3. Remove all old *.sh scripts from tmux/.tmux/scripts/
4. Verify git status shows correct file moves
5. Create git commit with changes
6. **Dependencies**: All validation passes

---

## Rollback Strategy

If anything breaks, these steps will rollback:

```bash
# Restore from git
git checkout HEAD -- sesh/ tmux/ dotfiles.conf

# Restore old symlinks
stow sesh

# Verify restore
stow -n sesh  # dry-run to verify
```

---

## Expected Outcomes

### Code Metrics
- **Lines of Code**: 3500 → 2500 (30% reduction)
- **Scripts**: 15 → 9 core scripts
- **Shared Modules**: 4 new files (~340 lines)
- **Duplication**: Eliminated in 7 major areas
- **Configuration**: Centralized paths (1 location vs 15)

### Quality Improvements
- **Maintainability**: 30% easier to update common functions
- **Consistency**: Single implementation of each function
- **Performance**: No change (reusing optimized implementations)
- **Clarity**: Shared modules document expected behavior
- **Testing**: Easier to test shared functions in isolation

### Organization
- **Structure**: Clear separation: lib/ (shared), core/ (entry), utils/ (operations)
- **Naming**: Consistent naming conventions across scripts
- **Sourcing**: All scripts source sesh_common.sh for configuration
- **Dependencies**: Clear dependency graph, no circular dependencies

---

## Execution Order

1. **Phase 1**: Create directory structure (manual)
2. **Task Group 1**: Create shared modules (parallel)
3. **Task Groups 2-4**: Consolidate scripts (sequential, depends on 1)
4. **Task Group 5**: Update entry points (depends on 1-4)
5. **Task Group 6**: Directory migration (depends on all)
6. **Task Group 7**: Validation (depends on 6)
7. **Task Group 8**: Cleanup (depends on 7)

---

## Critical Notes

- **Stow Integration**: No manual symlinking needed - `stow -R sesh` handles it
- **Backwards Compatibility**: tmux.conf and sesh.toml paths updated - users won't notice
- **Error Handling**: Use extraction from sesh_switcher.sh as model for all scripts
- **Testing**: Each script validated before moving to next phase
- **Git**: All moves tracked via git (git mv preferred over cp + rm)
