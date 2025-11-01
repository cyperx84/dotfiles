# claudecode.nvim Research Index

## Overview
Comprehensive research on the claudecode.nvim Neovim plugin, including function analysis, initialization flow, and configuration guidance.

**Research Date:** November 1, 2025  
**Plugin Version:** 0.2.0  
**Status:** Complete and fully documented

## Documents in This Research

### 1. CLAUDECODE_QUICK_REFERENCE.md (START HERE)
**Best for:** Quick answers and immediate understanding  
**Length:** ~150 lines  
**Contains:**
- One-line summary
- Available functions table
- How auto_start works
- How --continue/--resume work
- Config status checklist
- The fix for your bug
- Common commands

**Read this first if you want the quick answer**

---

### 2. claudecode_nvim_research.md (COMPREHENSIVE)
**Best for:** Deep understanding of the plugin  
**Length:** ~550 lines  
**Contains:**
- Executive summary
- Complete list of available functions
- How auto_start mechanism works (with code)
- The initialize_server() bug explanation
- Terminal command flow for arguments
- How --continue and --resume preserve context
- All registered Vim commands
- Your keybindings explanation
- Complete initialization sequence flow
- Server startup and connection flow
- Recommendations for configuration
- Testing procedures
- Code examples from the plugin

**Read this for complete understanding of how everything works**

---

### 3. claudecode_nvim_code_reference.md (DEVELOPER REFERENCE)
**Best for:** Actual source code and implementation details  
**Length:** ~400 lines  
**Contains:**
- File locations (absolute paths)
- setup() function actual code
- start() function actual code
- ClaudeCode command handler code
- Terminal command concatenation code
- Your configuration analysis
- The bug (with explanation)
- Session management code
- How to test your setup (4 tests)
- The correct configuration template
- All public API functions
- Configuration options reference
- Next steps checklist

**Read this if you want to see the actual code**

---

## Quick Navigation

### Understanding the Bug
1. Start: CLAUDECODE_QUICK_REFERENCE.md (The Fix section)
2. Deep dive: claudecode_nvim_research.md (The `initialize_server()` Bug section)
3. See code: claudecode_nvim_code_reference.md (The Bug section)

### Understanding auto_start
1. Start: CLAUDECODE_QUICK_REFERENCE.md (How auto_start=true Works section)
2. Deep dive: claudecode_nvim_research.md (How `auto_start=true` Works section)
3. See code: claudecode_nvim_code_reference.md (Setup Function Actual Code section)

### Understanding Session Continuation
1. Start: CLAUDECODE_QUICK_REFERENCE.md (How --continue and --resume Work section)
2. Deep dive: claudecode_nvim_research.md (How `--continue` and `--resume` Preserve Context section)
3. See code: claudecode_nvim_code_reference.md (Terminal Command Concatenation section)

### Understanding Complete Startup
1. Start: CLAUDECODE_QUICK_REFERENCE.md (What Actually Happens on Startup section)
2. Deep dive: claudecode_nvim_research.md (Server Initialization and Connection Flow section)
3. See code: claudecode_nvim_code_reference.md (Setup and Start Function sections)

### Testing Your Setup
1. Commands: CLAUDECODE_QUICK_REFERENCE.md (Test Commands section)
2. Procedures: claudecode_nvim_code_reference.md (How to Test Your Setup section)

---

## Key Findings Summary

### The Bug
- **File:** `/Users/cyperx/dotfiles/nvim/.config/nvim/lua/custom/plugins/claude.lua`
- **Lines:** 141-150
- **Issue:** Calls non-existent function `require('claudecode').initialize_server()`
- **Status:** Redundant with `auto_start=true` and non-functional
- **Fix:** Remove lines 141-150

### Available Public Functions
```lua
require('claudecode').setup(opts)
require('claudecode').start(notify?)
require('claudecode').stop()
require('claudecode').is_claude_connected()
require('claudecode').send_at_mention(file, start_line, end_line, context)
require('claudecode').process_mention_queue(from_new_connection?)
require('claudecode').get_version()
require('claudecode').open_with_model(args)
```

### How It Works
1. `auto_start=true` in your config
2. `setup()` calls `M.start(false)` automatically
3. WebSocket server starts on random port
4. Lock file created at `~/.claude/ide/[port].lock`
5. User launches Claude with keybinding
6. Claude reads lock file, connects to server
7. Full IDE integration active

### Session Continuation
- `--continue` and `--resume` flags passed directly to Claude CLI
- Claude CLI's backend handles session restoration
- Neovim WebSocket server connection maintained
- File context preserved through lock file mechanism

---

## Plugin Files (Absolute Paths)

**Installation:**
- `/Users/cyperx/.local/share/nvim/lazy/claudecode.nvim/`

**Key Modules:**
- `/Users/cyperx/.local/share/nvim/lazy/claudecode.nvim/lua/claudecode/init.lua` - Main module (1337 lines)
- `/Users/cyperx/.local/share/nvim/lazy/claudecode.nvim/lua/claudecode/terminal.lua` - Terminal management
- `/Users/cyperx/.local/share/nvim/lazy/claudecode.nvim/lua/claudecode/server/init.lua` - WebSocket server

**Your Configuration:**
- `/Users/cyperx/dotfiles/nvim/.config/nvim/lua/custom/plugins/claude.lua`

---

## Testing Commands

```vim
:ClaudeCodeStatus                              Check if server running
:lua print(require('claudecode').is_claude_connected())  Check Claude connected
:lua print(vim.inspect(require('claudecode').state.config))  View config
```

```bash
ls -la ~/.claude/ide/*.lock                    Check lock file
env | grep CLAUDE_CODE_SSE_PORT                Check port environment
```

---

## Configuration Status

Your current configuration:

| Item | Status | Details |
|------|--------|---------|
| auto_start | ✅ | Correctly set to true |
| terminal_cmd | ✅ | Correctly set to `/Users/cyperx/.claude/local/claude` |
| --resume keybinding | ✅ | Works correctly |
| --continue keybinding | ✅ | Works correctly |
| VimEnter autocmd | ❌ | Calls non-existent function (lines 141-150) |

---

## Recommended Reading Order

1. **For quick fix:** CLAUDECODE_QUICK_REFERENCE.md
2. **For understanding:** claudecode_nvim_research.md
3. **For implementation:** claudecode_nvim_code_reference.md

---

## Summary

Your claudecode.nvim setup is **99% correct**. The only issue is a redundant VimEnter autocmd (lines 141-150) that calls a non-existent function. Remove it and everything works perfectly.

Your session continuation setup with `--continue` and `--resume` is correctly implemented and will work as expected once the bug is fixed.

All configuration choices are appropriate and well-setup for your use case.

