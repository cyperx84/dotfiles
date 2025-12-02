#!/usr/bin/env bash
################################################################################
# sesh_preview.sh - Unified Session Preview Script
################################################################################
#
# DESCRIPTION:
#   Consolidated preview script combining functionality from:
#   - sesh_preview_fast.sh (optimized performance base)
#   - sesh_preview.sh (additional functionality)
#   - sesh_preview_with_keybinds.sh (keybinds header)
#   - session_helper.sh (utility functions)
#
# FEATURES:
#   - Fast preview generation with minimal tmux calls
#   - Keybinds header display at top
#   - Display mode support (compact/detailed) via toggle
#   - Support for all session types: tmux, tmuxinator, sesh_custom, directory
#   - Clean session name parsing with icon/metadata removal
#   - Directory previews with eza/ls fallback
#
# USAGE:
#   sesh_preview.sh <session_name>
#
# DISPLAY MODE:
#   Determined by ~/.sesh_display_mode file (set via Ctrl+R toggle in FZF)
#
# VERSION: 3.0.0 (Unified Edition)
# LAST MODIFIED: 2025-12-02
#
################################################################################

# ============================================================================
# INITIALIZATION - Source shared libraries
# ============================================================================

# Determine script library path
SESH_SCRIPTS_LIB="${SESH_SCRIPTS_LIB:-${HOME}/.config/sesh/scripts/lib}"

# Source common utilities (configuration, session detection, time formatting)
# Provides: clean_session_name(), detect_session_type(), human_time(), etc.
# shellcheck source=../lib/sesh_common.sh
source "${SESH_SCRIPTS_LIB}/sesh_common.sh"

# Source preview functions (session-specific preview generators)
# Provides: show_tmux_session_preview(), show_tmuxinator_preview(), etc.
# shellcheck source=../lib/sesh_preview_common.sh
source "${SESH_SCRIPTS_LIB}/sesh_preview_common.sh"

# ============================================================================
# DISPLAY MODE DETECTION
# ============================================================================

# Determine display mode from state file (for toggle functionality)
if [ -f "$HOME/.sesh_display_mode" ]; then
    DISPLAY_MODE=$(cat "$HOME/.sesh_display_mode")
else
    DISPLAY_MODE="${SESH_DISPLAY_MODE:-compact}"
fi

# Mode label for keybinds header
MODE_LABEL=$([ "$DISPLAY_MODE" = "detailed" ] && echo "📂 detailed" || echo "📋 compact")

# ============================================================================
# KEYBINDS HEADER
# ============================================================================

# Display keybinds at top of preview
# CRITICAL FIX: Changed ⌥n → ⌥c (Alt+C is actual new session key)
# ADDED: "esc close" (missing from previous version)
echo "  Keybinds: ⌥c new | ⌥k kill | ^b all | ^t tmux-only | ^/ zoxide | ^r $MODE_LABEL | ^s sort | ^d/u preview | esc close"
echo ""

# ============================================================================
# SESSION INPUT PROCESSING
# ============================================================================

SESSION_INPUT="$1"

# Clean session name using shared function from sesh_common.sh
# Removes: ANSI codes, icons, emoji prefixes, metadata (2w 3p), git info
SESSION_CLEAN=$(clean_session_name "$SESSION_INPUT")

# ============================================================================
# SESSION TYPE DETECTION AND PREVIEW DISPATCH
# ============================================================================

# Detect session type using shared function from sesh_common.sh
# Returns: "tmux", "tmuxinator", "sesh_custom", "directory", or "unknown"
SESSION_TYPE=$(detect_session_type "$SESSION_CLEAN")

# Dispatch to appropriate preview function (from sesh_preview_common.sh)
case "$SESSION_TYPE" in
    "tmux")
        # Active tmux session - show windows, panes, activity, pane content
        show_tmux_session_preview "$SESSION_CLEAN"
        ;;
    "tmuxinator")
        # Tmuxinator project - show config details, root path, directory preview
        show_tmuxinator_preview "$SESSION_CLEAN"
        ;;
    "sesh_custom")
        # Sesh.toml custom session - show path, status, directory preview
        show_sesh_custom_preview "$SESSION_CLEAN"
        ;;
    "directory")
        # Plain directory - show path, will-create info, directory listing
        show_directory_preview "$SESSION_CLEAN"
        ;;
    *)
        # Unknown/invalid session
        show_no_session_preview "$SESSION_CLEAN"
        ;;
esac

# ============================================================================
# PERFORMANCE OPTIMIZATIONS
# ============================================================================
#
# This unified script maintains performance characteristics from sesh_preview_fast.sh:
#
# 1. Minimal tmux calls:
#    - Single display-message call for multiple session properties
#    - Batched queries where possible
#    - No redundant has-session checks
#
# 2. Fast session name cleaning:
#    - Prefer perl over sed for ANSI code removal (faster on macOS)
#    - Single-pass regex operations
#    - Early returns for unknown types
#
# 3. Efficient directory previews:
#    - Limit output to 8 lines (head -8)
#    - Use eza when available (faster, colored output)
#    - Fallback to plain ls
#
# 4. Reduced pane capture:
#    - Only capture 10 lines of history (-S -10)
#    - Display only 8 lines (tail -8)
#    - Skip empty panes early
#
# 5. Shared library loading:
#    - Colors/icons loaded once via sesh_common.sh
#    - Preview functions defined once in sesh_preview_common.sh
#    - No code duplication
#
# ============================================================================
