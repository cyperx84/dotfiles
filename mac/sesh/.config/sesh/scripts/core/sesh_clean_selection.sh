#!/usr/bin/env bash
################################################################################
# sesh_clean_selection.sh - Output Sanitization for FZF Selections
################################################################################
#
# DESCRIPTION:
#   Cleans fzf selection output by removing ANSI codes, status icons, and
#   metadata suffixes. Preserves session name emoji and expands tilde paths.
#
# USAGE:
#   echo "● 🤖 dotfiles (2w 3p) 🔥" | sesh_clean_selection.sh
#   # Output: 🤖 dotfiles
#
# INPUT:  Selection string from fzf (via stdin)
# OUTPUT: Cleaned session name (preserves emoji in session names)
#
# VERSION: 2.0.0
# LAST MODIFIED: 2025-12-02
################################################################################

# Source common utilities for clean_session_name function
SESH_SCRIPTS_LIB="${SESH_SCRIPTS_LIB:-${HOME}/.config/sesh/scripts/lib}"
# shellcheck source=../lib/sesh_common.sh
source "${SESH_SCRIPTS_LIB}/sesh_common.sh"

# Read selection from stdin
selection=$(cat)

# Use common cleaning function for consistent behavior
selection=$(clean_session_name "$selection")

# Output cleaned selection
echo "$selection"
