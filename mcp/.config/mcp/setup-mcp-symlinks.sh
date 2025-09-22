#!/bin/bash

# Centralized MCP Server Configuration Setup Script
# Creates symlinks from dotfiles MCP config to various AI coding agents

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MCP_CONFIG="$SCRIPT_DIR/servers.json"
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo "🔗 Setting up centralized MCP server configuration..."
echo "📍 Source config: $MCP_CONFIG"
echo

# Check if source config exists
if [[ ! -f "$MCP_CONFIG" ]]; then
    echo -e "${RED}❌ Error: servers.json not found at $MCP_CONFIG${NC}"
    exit 1
fi

# Function to create symlink safely
create_symlink() {
    local target="$1"
    local link_path="$2"
    local agent_name="$3"

    # Create directory if it doesn't exist
    local dir_path="$(dirname "$link_path")"
    if [[ ! -d "$dir_path" ]]; then
        mkdir -p "$dir_path"
        echo -e "${YELLOW}📁 Created directory: $dir_path${NC}"
    fi

    # Remove existing file/symlink
    if [[ -f "$link_path" || -L "$link_path" ]]; then
        echo -e "${YELLOW}🔄 Backing up existing config for $agent_name${NC}"
        mv "$link_path" "${link_path}.backup.$(date +%Y%m%d_%H%M%S)"
    fi

    # Create symlink
    ln -s "$target" "$link_path"
    echo -e "${GREEN}✅ $agent_name: $link_path -> $target${NC}"
}

# Function to update Claude Code config
update_claude_config() {
    local claude_config="$HOME/.claude.json"
    local mcp_config_path="$HOME/.claude-mcp-servers.json"

    if [[ -f "$claude_config" ]]; then
        # Create symlink for Claude Code
        create_symlink "$MCP_CONFIG" "$mcp_config_path" "Claude Code (symlink)"

        # Update claude.json to reference the symlinked file
        if command -v jq &> /dev/null; then
            local temp_file=$(mktemp)
            jq --arg path "$mcp_config_path" '.mcpServers = $path' "$claude_config" > "$temp_file"
            mv "$temp_file" "$claude_config"
            echo -e "${GREEN}✅ Claude Code: Updated .claude.json to reference symlinked config${NC}"
        else
            echo -e "${YELLOW}⚠️  Claude Code: jq not found, manually update mcpServers field in ~/.claude.json${NC}"
        fi
    else
        echo -e "${YELLOW}⚠️  Claude Code: ~/.claude.json not found${NC}"
    fi
}

# Set up Claude Code
echo "🎯 Setting up Claude Code..."
update_claude_config

# Set up other agents
echo
echo "🎯 Setting up other AI coding agents..."

# Cursor/VSCode
create_symlink "$MCP_CONFIG" "$HOME/.cursor/mcp-servers.json" "Cursor"
create_symlink "$MCP_CONFIG" "$HOME/.vscode/mcp-servers.json" "VSCode"

# Continue.dev
create_symlink "$MCP_CONFIG" "$HOME/.continue/mcp-servers.json" "Continue.dev"

# Aider
create_symlink "$MCP_CONFIG" "$HOME/.aider/mcp-servers.json" "Aider"

# Codeium
create_symlink "$MCP_CONFIG" "$HOME/.codeium/mcp-servers.json" "Codeium"

# Supermaven
create_symlink "$MCP_CONFIG" "$HOME/.supermaven/mcp-servers.json" "Supermaven"

# GitHub Copilot CLI (if using MCP)
create_symlink "$MCP_CONFIG" "$HOME/.config/github-copilot/mcp-servers.json" "GitHub Copilot"

# Google AI Studio / Gemini Code Assist
create_symlink "$MCP_CONFIG" "$HOME/.config/google-ai-studio/mcp-servers.json" "Google AI Studio"

# JetBrains IDEs (IntelliJ, PyCharm, etc.)
create_symlink "$MCP_CONFIG" "$HOME/.config/JetBrains/mcp-servers.json" "JetBrains IDEs"

echo
echo -e "${GREEN}🎉 MCP server configuration setup complete!${NC}"
echo
echo "📝 Next steps:"
echo "1. Restart your AI coding agents to pick up the new configuration"
echo "2. Verify MCP servers are loaded in each agent"
echo "3. To add new servers, edit: $MCP_CONFIG"
echo "4. Changes will automatically apply to all agents via symlinks"
echo
echo "🔧 Troubleshooting:"
echo "- If an agent doesn't support MCP, remove its symlink"
echo "- Some agents may require specific config file names or formats"
echo "- Check agent documentation for MCP configuration requirements"