# Centralized MCP Server Configuration

This directory contains centralized MCP (Model Context Protocol) server configurations shared across multiple AI coding agents.

## Structure

- `servers.json` - Main MCP server definitions
- `agent-configs/` - Agent-specific configuration templates

## Supported Agents

### Claude Code
- **Config location**: `~/.claude.json` (`mcpServers` field)
- **Setup**: Symlinked to `servers.json`
- **Format**: Direct JSON object reference

### Gemini Code Assist / Google AI Studio
- **Config location**: `~/.config/google-ai-studio/mcp-servers.json`
- **Format**: MCP server definition JSON

### Cursor / VSCode Extensions
- **Config location**: `~/.vscode/extensions/mcp-servers.json`
- **Format**: Extension-specific MCP configuration

### Aider
- **Config location**: `~/.aider/mcp-servers.json`
- **Format**: Standard MCP server JSON

### Continue.dev
- **Config location**: `~/.continue/mcp-servers.json`
- **Format**: Standard MCP server JSON

## Current Servers

1. **CopilotKit** - SSE-based AI development tools
2. **sequential-thinking** - Multi-step reasoning
3. **markitdown-mcp** - Document conversion (Python/uv)
4. **mcp-obsidian** - Obsidian note management
5. **playwright** - Browser automation and testing
6. **shadcn** - Component library tools

## Setup Script

Run `./setup-mcp-symlinks.sh` to create symlinks for all supported agents.

## Adding New Servers

1. Edit `servers.json` to add new server configuration
2. Restart agents to pick up changes
3. All agents will automatically use the new servers via symlinks

## Agent-Specific Notes

- **Claude Code**: Uses file path reference in main config
- **Cursor/VSCode**: May require extension restart
- **Aider**: Automatically detects config changes
- **Continue.dev**: Hot-reloads configuration