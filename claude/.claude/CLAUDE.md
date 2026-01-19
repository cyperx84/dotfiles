- dont run tmux kill server while in tmux

## Claude Code Directory Structure

When creating skills/commands for Claude Code, use the correct locations:

- **Slash Commands** (user-invoked with `/command`): `.claude/commands/command-name.md`
- **Agent Skills** (model-invoked based on context): `.claude/skills/skill-name/SKILL.md`

**DO NOT** use `.skills/` or any other custom directory - Claude Code only recognizes `.claude/commands/` and `.claude/skills/`.

Slash command frontmatter format:
```yaml
---
allowed-tools: Read, Write, Edit, Grep, Glob
description: Brief description of what the command does
---
```