---
id: CLAUDE_STATUSLINE
tags: [claude, statusline, ui, documentation]
---

# 📊 Claude Code Enhanced Statusline Guide

A comprehensive guide to reading and interpreting Claude Code's enhanced statusline, featuring real-time context tracking, cost monitoring, and comprehensive session information.

## 🎯 Overview

The enhanced Claude Code statusline provides at-a-glance information about your current session, including context usage, model selection, costs, and system status. This guide will teach you how to read every component and use this information effectively.

## 📐 Statusline Layout

```
󰯈 │ 󰠧/dotfiles │ 󰊢 main │ 󰭺 S4 │ 󰔟 10m │ 󰘫 36k/200k(18%) 󰙅21k 󰒋5:5.4k 󰤃3:3.6k 󰈔3.6k 󰍨1.8k │ 󰷗$0.22 │ />
```

### Component Breakdown

| Icon | Component | Purpose | Color | Location |
|------|-----------|---------|--------|----------|
| 󰯈 | OS Indicator | System identification | Green | Left |
| 󰠧 | Directory Path | Current working directory | Orange | Left |
| 󰊢 | Git Branch | Version control status | Aqua | Left |
| 󰭺 | Model Info | Active AI model | Blue | Center-Left |
| 󰔟 | Session Time | Duration of current session | White | Center-Left |
| 󰘫 | Context Usage | Overall context statistics | Color-coded | Center |
| 󰙅 | System Tools | Built-in tool token usage | Blue | Center |
| 󰒋 | MCP Tools | External tool integrations | Aqua | Center |
| 󰤃 | Custom Agents | AI agent configurations | Purple | Center |
| 󰈔 | Memory Files | Context file usage | Orange | Center |
| 󰍨 | Messages | Conversation token count | White | Center |
| 󰷗 | Session Cost | Accumulated spending | Yellow | Right |
| /> | Prompt | Command input indicator | Orange | Right |

## 🔍 Reading Each Component

### 1. OS Indicator (󰯈)
- **Purpose**: Shows your operating system
- **Colors**: Green (normal operation)
- **Examples**:
  - `󰯈` - macOS
  - `󰌽` - Linux
  - `󰍲` - Windows

### 2. Directory Path (󰠧)
- **Purpose**: Shows current working directory with smart truncation
- **Color**: Orange (#FF4501)
- **Behavior**:
  - Full path when short
  - Truncated with ".." when long
  - Updates automatically with `cd` commands
- **Examples**:
  - `󰠧/Users/username/project` - Full path
  - `󰠧../project/subfolder` - Truncated path

### 3. Git Branch (󰊢)
- **Purpose**: Shows current git branch and repository status
- **Color**: Aqua (#4cbb17)
- **Status Indicators**:
  - Clean branch: `󰊢 main`
  - Dirty branch: `󰊢 main*` (with asterisk)
  - Detached HEAD: `󰊢 <commit-hash>`
- **Examples**:
  - `󰊢 main` - Clean main branch
  - `󰊢 feature-branch*` - Modified feature branch
  - `󰊢 <not a git repo>` - No git repository

### 4. Model Information (󰭺)
- **Purpose**: Shows the active Claude model
- **Color**: Blue (#0400FF)
- **Model Codes**:
  - `S4` - Claude Sonnet 4 (latest)
  - `Sonnet` - Claude Sonnet 3.5
  - `Haiku` - Claude Haiku (fast)
  - `Opus` - Claude Opus (powerful)
- **Examples**:
  - `󰭺 S4` - Using Sonnet 4
  - `󰭺 Haiku` - Using Haiku model

### 5. Session Time (󰔟)
- **Purpose**: Shows how long the current session has been active
- **Color**: White (#fbf1c7)
- **Format**: Intelligent time formatting
- **Examples**:
  - `󰔟 45s` - 45 seconds
  - `󰔟 10m` - 10 minutes
  - `󰔟 2h` - 2 hours
  - `󰔟 1d` - 1 day

## 🎨 Enhanced Context Section

The enhanced context section is the heart of the new statusline, providing detailed breakdown of your token usage:

```
󰘫 36k/200k(18%) 󰙅21k 󰒋5:5.4k 󰤃3:3.6k 󰈔3.6k 󰍨1.8k
```

### Overall Context Usage (󰘫)
- **Format**: `current/limit(percentage)`
- **Purpose**: Shows total context usage across all sources
- **Color Coding**:
  - 🟢 **Green**: < 60% usage (safe)
  - 🟡 **Yellow**: 60-79% usage (warning)
  - 🔴 **Red**: 80%+ usage (critical)
- **Examples**:
  - `󰘫 36k/200k(18%)` - 18% usage, plenty of room
  - `󰘫 120k/200k(60%)` - 60% usage, approaching limit
  - `󰘫 180k/200k(90%)` - 90% usage, critical level

### System Tools (󰙅)
- **Purpose**: Tokens used by built-in Claude Code tools
- **Color**: Blue (#0400FF)
- **Includes**: Bash, Read, Edit, Write, Grep, etc.
- **Example**: `󰙅21k` - 21,000 tokens from system tools

### MCP Tools (󰒋)
- **Purpose**: External tool integrations via MCP protocol
- **Color**: Aqua (#4cbb17)
- **Format**: `count:tokens`
- **Includes**: Browser automation, specialized APIs, custom integrations
- **Example**: `󰒋5:5.4k` - 5 MCP tools using 5,400 tokens

### Custom Agents (󰤃)
- **Purpose**: AI agent configurations and context
- **Color**: Purple (#b16286)
- **Format**: `count:tokens`
- **Includes**: Specialized agent instructions, custom behaviors
- **Example**: `󰤃3:3.6k` - 3 agents using 3,600 tokens

### Memory Files (󰈔)
- **Purpose**: Context files and documentation loaded into memory
- **Color**: Orange (#FF4501)
- **Includes**: Project documentation, configuration files, references
- **Example**: `󰈔3.6k` - 3,600 tokens from memory files

### Messages (󰍨)
- **Purpose**: Conversation history and message content
- **Color**: White (#fbf1c7)
- **Includes**: Your messages and Claude's responses
- **Example**: `󰍨1.8k` - 1,800 tokens from conversation

## 💰 Cost Tracking (󰷗)

### Session Cost Display
- **Purpose**: Real-time cost tracking based on actual token usage
- **Color**: Yellow (#FF7200)
- **Calculation**: Based on model pricing and token consumption
- **Updates**: Real-time with each interaction
- **Examples**:
  - `󰷗$0.22` - 22 cents spent this session
  - `󰷗$1.45` - $1.45 spent this session
  - `󰷗$0.00` - No cost yet (free tier or new session)

### Cost Calculation Details
The cost calculation includes:
- **Input tokens**: Text you send to Claude
- **Output tokens**: Claude's responses
- **Tool usage**: System and MCP tool executions
- **Model multipliers**: Different pricing for different models

## 🎨 Color Scheme Reference

Based on **Gruvbox Dark Neon** theme:

| Color | Hex Code | Usage | Visual Cue |
|-------|----------|-------|------------|
| **Green** | #00FF00 | OS icon, healthy context | Safe/Good |
| **Orange** | #FF4501 | Directory, prompt, memory | Active/File-related |
| **Blue** | #0400FF | Model, system tools | Core system |
| **Aqua** | #4cbb17 | Git, MCP tools | External integrations |
| **Yellow** | #FF7200 | Cost, warnings | Money/Attention |
| **Purple** | #b16286 | Custom agents | Specialized AI |
| **Red** | #cc241d | Critical warnings | Danger/Limit |
| **White** | #fbf1c7 | Time, messages | Neutral info |

## 🔄 Real-Time Updates

The statusline updates automatically when:
- **Directory changes**: Via `cd` commands
- **Git operations**: Branch switches, commits, status changes
- **Context usage**: New files loaded, tools used, messages sent
- **Model changes**: Switching between Claude models
- **Cost accumulation**: Each API call updates the cost
- **Time progression**: Session timer updates continuously

## 📋 Reading Examples

### Example 1: Light Usage Session
```
󰯈 │ 󰠧~/project │ 󰊢 main │ 󰭺 Haiku │ 󰔟 5m │ 󰘫 12k/200k(6%) 󰙅8k 󰒋2:1.5k 󰤃1:800 󰈔1.2k 󰍨500 │ 󰷗$0.03 │ />
```

**Interpretation**:
- macOS system, in ~/project directory
- Clean main branch
- Using fast Haiku model
- 5 minutes into session
- Very low context usage (6% - green)
- Minimal cost (3 cents)
- Light tool usage across the board

### Example 2: Heavy Development Session
```
󰯈 │ 󰠧../complex-app │ 󰊢 feature* │ 󰭺 S4 │ 󰔟 2h │ 󰘫 145k/200k(72%) 󰙅45k 󰒋8:25k 󰤃5:18k 󰈔35k 󰍨22k │ 󰷗$2.45 │ />
```

**Interpretation**:
- Long session (2 hours) on complex project
- Modified feature branch (dirty state)
- Using powerful Sonnet 4 model
- High context usage (72% - yellow warning)
- Significant cost accumulation ($2.45)
- Heavy usage of all tool categories
- Many memory files and long conversation

### Example 3: Critical Context Warning
```
󰯈 │ 󰠧/large-repo │ 󰊢 main │ 󰭺 S4 │ 󰔟 45m │ 󰘫 185k/200k(92%) 󰙅55k 󰒋12:40k 󰤃8:28k 󰈔45k 󰍨17k │ 󰷗$3.80 │ />
```

**Interpretation**:
- Approaching context limit (92% - red critical)
- High cost due to extensive usage
- Need to consider context cleanup
- Many tools and agents active
- Large memory footprint

## ⚠️ Warning Indicators

### Context Usage Warnings
- **60-79%** (Yellow): Consider cleaning up unused context
- **80%+** (Red): Urgent - context limit approaching
- **95%+** (Flashing Red): Critical - may lose context soon

### Cost Monitoring
- **Green**: Under $1.00
- **Yellow**: $1.00 - $5.00
- **Orange**: $5.00 - $10.00
- **Red**: Over $10.00

### Time Warnings
- Sessions over 4 hours may indicate need for breaks
- Extended sessions can accumulate significant costs

## 🛠️ Troubleshooting

### Common Issues

#### Statusline Not Updating
**Problem**: Components show stale information
**Solutions**:
1. Check if Claude Code is running properly
2. Verify shell integration is active
3. Restart Claude Code session if needed

#### Incorrect Directory Display
**Problem**: Directory path doesn't match current location
**Solutions**:
1. Ensure you're using absolute paths
2. Check if shell integration is properly configured
3. Manually refresh with `pwd` command

#### Context Percentage Seems Wrong
**Problem**: Context usage doesn't match expectations
**Solutions**:
1. Use `/context` command for detailed breakdown
2. Check if large files are loaded in memory
3. Consider clearing unused context with `/clear`

#### Cost Tracking Issues
**Problem**: Cost display seems inaccurate
**Solutions**:
1. Verify model pricing is up to date
2. Check if all tool usage is being tracked
3. Compare with actual Claude usage dashboard

### Missing Components
If certain components don't appear:
- **Git info**: Ensure you're in a git repository
- **MCP tools**: Check if MCP integrations are enabled
- **Agents**: Verify custom agents are loaded
- **Memory files**: Confirm context files are active

## 🎯 Best Practices

### Context Management
1. **Monitor the percentage**: Keep below 70% for optimal performance
2. **Clear unused context**: Remove old files and conversations when possible
3. **Use appropriate models**: Haiku for simple tasks, Sonnet 4 for complex work

### Cost Optimization
1. **Choose the right model**: Don't use Sonnet 4 for simple questions
2. **Monitor session length**: Long sessions accumulate more cost
3. **Manage context efficiently**: Reduce unnecessary tool usage

### Workflow Efficiency
1. **Watch git status**: Keep branches clean for easier tracking
2. **Use session time**: Take breaks during long sessions
3. **Monitor tool usage**: Understand which tools consume most tokens

## 📚 Related Documentation

For more information about the components shown in the statusline:

- **[Components Guide](COMPONENTS.md)**: Detailed tool documentation
- **[Keybinds Reference](KEYBINDS.md)**: Keyboard shortcuts for all tools
- **[Workflow Guides](WORKFLOW_GUIDES.md)**: How tools work together
- **[Maintenance Guide](MAINTENANCE.md)**: Troubleshooting and system health

## 🔗 Quick Reference Commands

```bash
# Context management
/context                    # Detailed context breakdown
/clear                      # Clear conversation context
/model                      # Switch Claude model

# Session information
/cost                       # Detailed cost breakdown
/session                    # Session statistics
/help                       # Command reference

# Git integration
git status                  # Update git information
git checkout <branch>       # Switch branches (updates statusline)
cd <directory>              # Change directory (updates path)
```

---

*The enhanced statusline puts all essential information at your fingertips, helping you work more efficiently while staying aware of context usage and costs.*