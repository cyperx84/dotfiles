# AGENTS.md - Development Guidelines for Dotfiles Repository

## Build/Lint/Test Commands

### Validation Scripts
- **Sesh validation**: `~/bin/validate_sesh.sh` - Comprehensive config validation and integration testing
- **SketchyBar testing**: `~/.config/sketchybar/test_sketchybar.sh` - Tests all development plugins and dependencies
- **SketchyBar helper**: `cd ~/.config/sketchybar/helper && make clean && make` - Compile helper binary

### Single Test Execution
- **Run specific SketchyBar plugin test**: `~/.config/sketchybar/test_sketchybar.sh <plugin_name>`
- **Test sesh configuration**: `sesh list` (basic syntax check)

## Code Style Guidelines

### Shell Scripts (Bash/Zsh)
- **Error handling**: Use `command -v tool &>/dev/null` to check tool availability
- **Functions**: Use `local` variables, descriptive names, proper return codes
- **Output**: Use color codes for user-facing messages (RED, GREEN, YELLOW, BLUE, NC)
- **Comments**: Clear, descriptive comments explaining complex logic
- **Indentation**: 4 spaces for consistency
- **Quotes**: Double quotes for variables, single quotes for literals

### Lua (Neovim Configuration)
- **Formatting**: 2-space indentation, Unix line endings, column width 160
- **Quotes**: Single quotes preferred (`AutoPreferSingle` in stylua)
- **Parentheses**: No call parentheses (`call_parentheses = "None"`)
- **Structure**: Clear plugin definitions with opts/config separation

### Configuration Files
- **Organization**: Logical grouping with clear section headers
- **Comments**: Explain non-obvious configurations
- **Naming**: Consistent naming conventions (snake_case for variables)
- **Paths**: Use absolute paths or proper variable expansion

### General Practices
- **Security**: Never log or expose secrets/keys
- **Compatibility**: Check tool availability before usage
- **Documentation**: Update comments when modifying complex logic
- **Testing**: Validate changes with appropriate test scripts