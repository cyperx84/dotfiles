#!/usr/bin/env bash

# Enhanced Preview Script for Sesh Session Manager
# Provides detailed, contextual previews for different session types

set -euo pipefail

# Strip ANSI color codes from the session name
session_name=$(echo "$1" | sed 's/\x1b\[[0-9;]*m//g')

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to show tmuxinator project preview
show_tmuxinator_preview() {
    local project="$1"
    local config_file="$HOME/.config/tmuxinator/${project}.yml"

    echo -e "${MAGENTA}🎛️  Tmuxinator Project: ${project}${NC}"
    echo -e "${CYAN}📁 Config: ${config_file}${NC}"
    echo ""

    if [[ -f "$config_file" ]]; then
        echo -e "${YELLOW}📄 Project Configuration:${NC}"

        # Extract key information from YAML
        local name=$(grep "^name:" "$config_file" 2>/dev/null | cut -d: -f2- | xargs)
        local root=$(grep "^root:" "$config_file" 2>/dev/null | cut -d: -f2- | xargs)

        [[ -n "$name" ]] && echo -e "  ${GREEN}📝 Name:${NC} $name"
        [[ -n "$root" ]] && echo -e "  ${GREEN}📂 Root:${NC} $root"

        # Show windows configuration
        echo ""
        echo -e "${YELLOW}🪟 Windows:${NC}"
        grep -A1 "^windows:" "$config_file" 2>/dev/null | tail -n +2 | head -5 | while read -r line; do
            if [[ "$line" =~ ^[[:space:]]*-[[:space:]]*([^:]+): ]]; then
                window_name=$(echo "$line" | sed 's/^[[:space:]]*-[[:space:]]*//' | cut -d: -f1)
                echo -e "  ${BLUE}•${NC} $window_name"
            fi
        done

        # Show if project directory exists and has git
        if [[ -n "$root" ]] && [[ -d "$root" ]]; then
            echo ""
            if [[ -d "$root/.git" ]]; then
                echo -e "${GREEN}📊 Git Repository${NC}"
                cd "$root" 2>/dev/null && {
                    local branch=$(git branch --show-current 2>/dev/null || echo "detached")
                    local status=$(git status --porcelain 2>/dev/null | wc -l | xargs)
                    echo -e "  ${BLUE}🌿 Branch:${NC} $branch"
                    [[ "$status" -gt 0 ]] && echo -e "  ${YELLOW}📝 Changes:${NC} $status files"
                }
            fi
        fi
    else
        echo -e "${RED}❌ Configuration file not found${NC}"
    fi
}

# Function to show sesh session preview
show_sesh_session_preview() {
    local session="$1"

    # Check if it's an active tmux session
    if tmux has-session -t "$session" 2>/dev/null; then
        echo -e "${GREEN}✅ Active Session: $session${NC}"
        local windows=$(tmux list-windows -t "$session" 2>/dev/null | wc -l)
        local current_path=$(tmux display-message -p -t "$session" '#{pane_current_path}' 2>/dev/null || echo "Unknown")

        echo -e "${CYAN}📊 Windows: $windows${NC}"
        echo -e "${CYAN}📂 Path: $current_path${NC}"
        echo ""

        # Show window list
        echo -e "${YELLOW}🪟 Windows:${NC}"
        tmux list-windows -t "$session" 2>/dev/null | head -5 | while read -r line; do
            local window_info=$(echo "$line" | cut -d' ' -f2-)
            echo -e "  ${BLUE}•${NC} $window_info"
        done

        # Show git info if in a git repository
        if [[ -d "$current_path/.git" ]]; then
            echo ""
            echo -e "${GREEN}📊 Git Repository${NC}"
            cd "$current_path" 2>/dev/null && {
                local branch=$(git branch --show-current 2>/dev/null || echo "detached")
                local status=$(git status --porcelain 2>/dev/null | wc -l | xargs)
                echo -e "  ${BLUE}🌿 Branch:${NC} $branch"
                [[ "$status" -gt 0 ]] && echo -e "  ${YELLOW}📝 Changes:${NC} $status files"
            }
        fi
    else
        echo -e "${YELLOW}💤 Inactive Session: $session${NC}"
        echo -e "${CYAN}📋 Available in sesh config${NC}"

        # Try to get session info from sesh config
        if command -v sesh >/dev/null 2>&1; then
            # Check if it's a configured session with a path
            local session_path=""
            if [[ "$session" =~ ^🗒️ ]]; then
                session_path="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/notes"
            elif [[ "$session" =~ ^📥 ]]; then
                session_path="$HOME/Downloads"
            elif [[ "$session" =~ ^⚙️.*Dotfiles ]]; then
                session_path="$HOME/dotfiles"
            elif [[ "$session" =~ ^🤖 ]]; then
                session_path="$HOME/Code/agents"
            fi

            if [[ -n "$session_path" ]] && [[ -d "$session_path" ]]; then
                echo ""
                echo -e "${BLUE}📂 Session Path: $session_path${NC}"

                # Show directory contents
                echo -e "${YELLOW}📁 Contents:${NC}"
                ls -la "$session_path" 2>/dev/null | head -6 | tail -5 | while read -r line; do
                    echo "  $line"
                done

                # Show git info if it's a git repository
                if [[ -d "$session_path/.git" ]]; then
                    echo ""
                    echo -e "${GREEN}📊 Git Repository${NC}"
                    cd "$session_path" 2>/dev/null && {
                        local branch=$(git branch --show-current 2>/dev/null || echo "detached")
                        local status=$(git status --porcelain 2>/dev/null | wc -l | xargs)
                        echo -e "  ${BLUE}🌿 Branch:${NC} $branch"
                        [[ "$status" -gt 0 ]] && echo -e "  ${YELLOW}📝 Changes:${NC} $status files"
                    }
                fi
            fi
        fi
    fi
}

# Function to show directory preview
show_directory_preview() {
    local dir_path="$1"

    # Expand tilde
    dir_path="${dir_path/#\~/$HOME}"

    if [[ -d "$dir_path" ]]; then
        echo -e "${BLUE}📁 Directory: $dir_path${NC}"
        echo ""

        # Show directory contents
        echo -e "${YELLOW}📂 Contents:${NC}"
        ls -la "$dir_path" 2>/dev/null | head -8 | tail -7 | while read -r line; do
            echo "  $line"
        done

        # Show git info if it's a git repository
        if [[ -d "$dir_path/.git" ]]; then
            echo ""
            echo -e "${GREEN}📊 Git Repository${NC}"
            cd "$dir_path" 2>/dev/null && {
                local branch=$(git branch --show-current 2>/dev/null || echo "detached")
                local status=$(git status --porcelain 2>/dev/null | wc -l | xargs)
                local commits=$(git rev-list --count HEAD 2>/dev/null || echo "0")
                echo -e "  ${BLUE}🌿 Branch:${NC} $branch"
                echo -e "  ${BLUE}📊 Commits:${NC} $commits"
                [[ "$status" -gt 0 ]] && echo -e "  ${YELLOW}📝 Changes:${NC} $status files"

                # Show recent commits
                echo ""
                echo -e "${YELLOW}🔄 Recent Commits:${NC}"
                git log --oneline -3 2>/dev/null | while read -r line; do
                    echo "  ${BLUE}•${NC} $line"
                done
            }
        fi

        # Show if it contains common project files
        echo ""
        echo -e "${YELLOW}🔍 Project Files:${NC}"
        for file in package.json Cargo.toml pyproject.toml Makefile README.md; do
            if [[ -f "$dir_path/$file" ]]; then
                echo -e "  ${GREEN}✓${NC} $file"
            fi
        done
    else
        echo -e "${RED}❌ Directory not found: $dir_path${NC}"
    fi
}

# Main logic
if tmuxinator list 2>/dev/null | tail -n +2 | tr -s ' ' '\n' | grep -q "^${session_name}$"; then
    # It's a tmuxinator project
    show_tmuxinator_preview "$session_name"
elif [[ "$session_name" =~ ^~ ]] || [[ "$session_name" =~ ^/ ]]; then
    # It's a directory path
    show_directory_preview "$session_name"
else
    # It's a sesh session
    show_sesh_session_preview "$session_name"
fi