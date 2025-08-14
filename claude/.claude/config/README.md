# Configuration Management

This directory contains all Claude Code configuration files and settings.

## 📁 Files

### `settings.json`
Main Claude Code configuration file containing:
- **statusLine**: Custom status line configuration with model display
- **Global settings**: Core Claude Code behavior settings
- **Default values**: Base configuration that applies to all environments

### `settings.local.json`
Environment-specific overrides that take precedence over `settings.json`:
- **Local customizations**: Machine-specific settings
- **Sensitive configurations**: API keys, tokens (never commit to git)
- **Development overrides**: Settings for local development

## 🔧 Configuration Priority

Settings are loaded in this order (later entries override earlier ones):
1. `settings.json` - Base configuration
2. `settings.local.json` - Local overrides

## 🎨 Current Status Line Configuration

The current status line configuration displays:
- **Claude icon** (󰯈) in green
- **Directory name** with custom icons for common directories:
  - `notes` → 󰠮
  - `Code` → 󰨞
  - `dotfiles` → 󰒔
  - `agents` → 󱙝
  - `Documents` → 󱔗
  - `Downloads` → 󰇚
  - `Music` → 󰎆
  - `Pictures` → 󰋩
  - `.config` → 󰒓
  - `github` → 󰊤
- **Model name** in cyan

## 🛠️ Customization Examples

### Adding New Status Line Icons
Edit the `settings.json` statusLine command to include new directory mappings:
```bash
sed 's/^dotfiles$/󰒔/g' | sed 's/^my-project$/󰎯/g'
```

### Override Status Line Locally
Create or modify `settings.local.json`:
```json
{
  "statusLine": {
    "type": "simple",
    "template": "My Custom Status: {model}"
  }
}
```

### Disable MCP Servers Globally
In `settings.local.json`:
```json
{
  "enableAllProjectMcpServers": false
}
```

## 🔒 Security Best Practices

### ✅ DO:
- Use `settings.local.json` for sensitive data
- Keep `settings.json` as the base template
- Document configuration changes
- Use environment variables for secrets when possible

### ❌ DON'T:
- Commit API keys or tokens in `settings.json`
- Store passwords in configuration files
- Override security settings without understanding implications

## 🔧 Common Configuration Patterns

### Development Environment
```json
{
  "enableAllProjectMcpServers": true,
  "debugMode": true,
  "logLevel": "verbose"
}
```

### Production Environment
```json
{
  "enableAllProjectMcpServers": false,
  "logLevel": "error",
  "cacheEnabled": true
}
```

### Custom Tools Integration
```json
{
  "tools": {
    "customScripts": "tools/scripts",
    "agentTemplates": "agents/templates"
  }
}
```

## 🔄 Migration Notes

The configuration files were moved from the root directory to provide:
- **Better organization**: All config files in one location
- **Version control**: Easier to track configuration changes
- **Modularity**: Clear separation of concerns
- **Documentation**: Centralized configuration documentation

## 🚨 Troubleshooting

### Configuration Not Loading
1. Check file permissions: `chmod 644 config/*.json`
2. Validate JSON syntax: `jq . config/settings.json`
3. Verify file locations match Claude Code expectations

### Status Line Not Updating
1. Check command syntax in `settings.json`
2. Verify shell commands execute properly
3. Test jq parsing: `echo '{}' | jq -r '.test'`

### Local Overrides Not Working
1. Ensure `settings.local.json` exists
2. Check JSON syntax and structure
3. Verify override key paths match base settings

## 📖 Related Documentation

- [Main README](../README.md) - Overall repository structure
- [docs/setup.md](../docs/setup.md) - Initial setup guide
- [docs/customization.md](../docs/customization.md) - Advanced customization