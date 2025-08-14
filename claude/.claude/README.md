# Claude Workspace Repository

A modular, well-organized repository for managing Claude Code workspaces, subagents, and development workflows.

## 📁 Repository Structure

```
claude-workspace/
├── README.md                    # This file
├── .gitignore                  # Git ignore patterns for sensitive/cache files
├── config/                     # Configuration management
│   ├── settings.json           # Main Claude Code settings
│   ├── settings.local.json     # Local environment overrides
│   └── README.md              # Configuration documentation
├── agents/                     # Agent management system
│   ├── subagents/             # Custom subagent definitions
│   ├── templates/             # Reusable agent templates
│   └── README.md              # Agent system documentation
├── projects/                   # Project conversation management
│   ├── active/                # Current active project sessions
│   ├── archived/              # Completed/archived conversations
│   └── README.md              # Project organization guide
├── tools/                      # Custom tools and utilities
│   ├── scripts/               # Automation and utility scripts
│   └── README.md              # Tools documentation
├── docs/                       # Comprehensive documentation
│   ├── setup.md               # Initial setup instructions
│   ├── workflows.md           # Common workflows and patterns
│   ├── customization.md       # Customization and extension guide
│   └── troubleshooting.md     # Common issues and solutions
└── data/                       # Data management
    ├── todos/                 # Todo lists and task management
    ├── cache/                 # Temporary files and cache
    └── snapshots/             # Shell session snapshots
```

## 🚀 Quick Start

1. **Clone or Initialize**
   ```bash
   git clone <this-repository>
   # or initialize in existing .claude directory
   cd ~/.claude && git init
   ```

2. **Configure Settings**
   ```bash
   cp config/settings.json.example config/settings.json
   # Edit settings as needed
   ```

3. **Set Up Your Environment**
   ```bash
   # Link to your Claude Code installation
   # See docs/setup.md for detailed instructions
   ```

## 🧩 Core Features

### **Modular Configuration**
- Environment-specific settings with `settings.local.json` override
- Organized configuration files in dedicated `config/` directory
- Version-controlled base settings with local customizations

### **Agent Management System**
- Custom subagent definitions for specialized tasks
- Reusable templates for common agent patterns
- Centralized documentation for agent capabilities

### **Project Organization**
- Clean separation of active vs archived conversations
- Project-specific conversation history preservation
- Easy project lifecycle management

### **Development Tools**
- Custom automation scripts
- Utility tools for common tasks
- Extensible toolchain architecture

### **Comprehensive Documentation**
- Setup and configuration guides
- Workflow documentation with examples
- Troubleshooting and best practices

## 📊 Data Management

### **Conversation History**
- Project conversations stored in JSON Lines format
- Organized by project path for easy navigation
- Full conversation context preservation

### **Task Management**
- Todo lists tracked per session and agent
- JSON format for easy parsing and automation
- Historical task completion tracking

### **Session Management**
- Shell session snapshots for context preservation
- Cached data for performance optimization
- Temporary file management with automatic cleanup

## 🔧 Customization

### **Adding Custom Agents**
```bash
# Create new agent template
cp agents/templates/base-agent.json agents/subagents/my-agent.json
# Edit agent definition
# See agents/README.md for detailed instructions
```

### **Custom Tools**
```bash
# Add custom scripts
touch tools/scripts/my-script.sh
chmod +x tools/scripts/my-script.sh
# Document in tools/README.md
```

### **Configuration Override**
```bash
# Create local settings override
echo '{"myCustomSetting": "value"}' > config/settings.local.json
```

## 🛠️ Common Workflows

### **Starting New Project**
1. Navigate to project directory
2. Initialize with `claude code`
3. Conversations automatically saved to `projects/active/`

### **Managing Agents**
1. Define agent in `agents/subagents/`
2. Use with Task tool in conversations
3. Templates available in `agents/templates/`

### **Archiving Projects**
```bash
# Move completed projects to archive
mv projects/active/my-project projects/archived/
```

## 📋 Best Practices

### **Security**
- Never commit sensitive data (API keys, tokens)
- Use `settings.local.json` for environment-specific secrets
- Review `.gitignore` patterns regularly

### **Organization**
- Use descriptive names for custom agents
- Document custom tools and workflows
- Archive completed projects regularly

### **Maintenance**
- Clean up cache files periodically
- Review and update agent templates
- Keep documentation current

## 🤝 Contributing

### **Adding New Features**
1. Document the feature in appropriate `docs/` file
2. Add templates or examples if applicable
3. Update this README with usage instructions

### **Sharing Agents**
1. Create well-documented agent templates
2. Include usage examples and documentation
3. Follow naming conventions in `agents/templates/`

## 🔍 Troubleshooting

Common issues and solutions can be found in `docs/troubleshooting.md`.

For specific problems:
1. Check configuration in `config/`
2. Review logs and error messages
3. Consult project-specific documentation
4. Check GitHub issues and community resources

## 📝 License

This workspace configuration is designed for personal use. Adapt and modify as needed for your development workflow.

## 🔗 Related Resources

- [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code)
- [MCP (Model Context Protocol)](https://modelcontextprotocol.io/)
- [Claude Code GitHub](https://github.com/anthropics/claude-code)

---

**Last Updated:** $(date)  
**Version:** 1.0.0