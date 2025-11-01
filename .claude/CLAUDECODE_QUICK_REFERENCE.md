# claudecode.nvim Quick Reference

## The One Line Summary
The `initialize_server()` function you're calling on VimEnter doesn't exist. Remove lines 141-150 from your claude.lua. Everything else works fine.

## Available Functions

| Function | Purpose | Usage |
|----------|---------|-------|
| `setup(opts)` | Initialize plugin | Called in config function |
| `start(notify?)` | Start WebSocket server | `require('claudecode').start(false)` |
| `stop()` | Stop server | Manual cleanup |
| `is_claude_connected()` | Check Claude connection | Returns boolean |
| `send_at_mention(...)` | Queue file for Claude | Sends file to Claude |
| `process_mention_queue(...)` | Process queued files | Auto-called when connected |
| `get_version()` | Get version info | Debugging |
| `open_with_model(args)` | Model selection UI | Opens UI popup |

## How auto_start=true Works

1. Your config: `opts = { auto_start = true }`
2. Plugin calls: `require('claudecode').setup(opts)`
3. setup() sees auto_start=true
4. Calls: `M.start(false)` automatically
5. Server runs on random port
6. Done! No manual initialization needed

## How --continue and --resume Work

```
:ClaudeCode --resume
    ↓
Command handler extracts "--resume"
    ↓
Appends to command: "/Users/cyperx/.claude/local/claude --resume"
    ↓
Sets env: CLAUDE_CODE_SSE_PORT=24591
    ↓
Claude CLI connects to Neovim server
    ↓
Claude's backend restores session
    ↓
Full IDE integration active
```

## Test Commands

```vim
:ClaudeCodeStatus                    " Check if server is running
:lua print(require('claudecode').is_claude_connected())  " Check Claude connected
```

## Your Config Status

| Item | Status | Note |
|------|--------|------|
| auto_start | ✅ | Server starts automatically |
| terminal_cmd | ✅ | Path is correct |
| --resume keybinding | ✅ | Works correctly |
| --continue keybinding | ✅ | Works correctly |
| VimEnter autocmd | ❌ | Calls non-existent function |

## The Fix

**Remove from your claude.lua:**
```lua
-- Lines 141-150 - DELETE THIS BLOCK:
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    vim.defer_fn(function()
      pcall(function()
        require('claudecode').initialize_server()  -- DOESN'T EXIST!
      end)
    end, 100)
  end,
  desc = 'Initialize Claude Code server on startup',
})
```

Why? Because `auto_start=true` already does this!

## Key Files

- Plugin: `/Users/cyperx/.local/share/nvim/lazy/claudecode.nvim/lua/claudecode/init.lua`
- Your Config: `/Users/cyperx/dotfiles/nvim/.config/nvim/lua/custom/plugins/claude.lua`
- Research: `/Users/cyperx/dotfiles/.claude/claudecode_nvim_research.md`
- Code Ref: `/Users/cyperx/dotfiles/.claude/claudecode_nvim_code_reference.md`

## What Actually Happens on Startup

```
lazy.nvim loads plugin
  ↓
Your config runs
  ↓
setup(opts) called
  ↓
auto_start=true → M.start(false)
  ↓
WebSocket server starts on random port (e.g., 24591)
  ↓
Auth token generated
  ↓
Lock file: ~/.claude/ide/24591.lock
  ↓
VimEnter fires
  ↓
Your broken autocmd does nothing (already running)
  ↓
User launches Claude with <leader>cm
  ↓
Claude reads lock file, connects to server
  ↓
Full IDE integration active
```

## Session Continuation

Your keybindings are correct:

```lua
{ "<leader>cr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
{ "<leader>cC", launch_claude_continue, desc = "Continue Claude" },
```

These work because:
1. Server already running (from auto_start)
2. Arguments passed to Claude CLI
3. Claude's backend handles session restoration
4. Neovim WebSocket connection preserved

## Common Commands

```vim
:ClaudeCode                          Toggle terminal
:ClaudeCode --continue               Continue session
:ClaudeCode --resume                 Resume session
:ClaudeCodeFocus                     Focus terminal
:ClaudeCodeAdd file.lua              Add file to context
:ClaudeCodeSelectModel               Choose model
:ClaudeCodeStatus                    Check server status
:ClaudeCodeStart                     Start server
:ClaudeCodeStop                      Stop server
```

## Summary

Your configuration is 99% correct. Just remove one broken autocmd (lines 141-150) that:
- Calls a non-existent function
- Is redundant with auto_start=true
- Does nothing harmful but is wrong

Everything else works perfectly!
