# claudecode.nvim Plugin Research - Complete Analysis

## Plugin Location

**Installation Path:**
- `/Users/cyperx/.local/share/nvim/lazy/claudecode.nvim/`

**Key Source Files:**
- `/Users/cyperx/.local/share/nvim/lazy/claudecode.nvim/lua/claudecode/init.lua` - Main module (1337 lines)
- `/Users/cyperx/.local/share/nvim/lazy/claudecode.nvim/lua/claudecode/terminal.lua` - Terminal management
- `/Users/cyperx/.local/share/nvim/lazy/claudecode.nvim/lua/claudecode/server/init.lua` - WebSocket server
- `/Users/cyperx/.local/share/nvim/lazy/claudecode.nvim/README.md` - Plugin documentation

**Your Configuration:**
- `/Users/cyperx/dotfiles/nvim/.config/nvim/lua/custom/plugins/claude.lua` - Your plugin config

## Exported Public Functions

### Core Server Management
```lua
require('claudecode').setup(opts)
-- Initializes plugin with config
-- Auto-starts server if opts.auto_start == true (default)
-- Registers all Vim commands
-- Returns: module self

require('claudecode').start(show_startup_notification)
-- Manually start the WebSocket server
-- Parameters: boolean (optional, default true)
-- Returns: success (boolean), port_or_error (number|string)

require('claudecode').stop()
-- Stop the WebSocket server
-- Returns: success (boolean), error_message (string|nil)
```

### Connection Status
```lua
require('claudecode').is_claude_connected()
-- Check if Claude Code CLI is actively connected
-- Returns: boolean

require('claudecode').get_version()
-- Get plugin version information
-- Returns: table with {version, major, minor, patch, prerelease}
```

### Context Management
```lua
require('claudecode').send_at_mention(file_path, start_line, end_line, context)
-- Send file mention to Claude (queues if not connected)
-- Parameters:
--   - file_path (string): File or directory to mention
--   - start_line (number|nil): Optional start line (0-indexed for Claude)
--   - end_line (number|nil): Optional end line (0-indexed for Claude)
--   - context (string|nil): Log context name
-- Returns: success (boolean), error_message (string|nil)

require('claudecode').process_mention_queue(from_new_connection)
-- Process any queued file mentions when ready
-- Parameters: from_new_connection (boolean|nil) - true if triggered by new connection
-- Returns: none
```

### UI/Model Selection
```lua
require('claudecode').open_with_model(additional_args)
-- Open model selection UI then launch Claude
-- Parameters: additional_args (string|nil) - Extra args for claude command
-- Returns: none (opens UI)
```

### Internal/Test Functions (NOT recommended for user code)
```lua
require('claudecode')._broadcast_at_mention(file_path, start_line, end_line)
require('claudecode')._ensure_terminal_visible_if_connected()
require('claudecode')._format_path_for_at_mention(file_path)
require('claudecode')._add_paths_to_claude(file_paths, options)
require('claudecode')._create_commands()
```

## Non-Existent Functions (Your Bug)

**Function that does NOT exist:**
```lua
require('claudecode').initialize_server()  -- DOES NOT EXIST!
```

Your config (line 145 of claude.lua) calls this on VimEnter, which causes a silent error (due to pcall wrapping).

## How `auto_start=true` Works

**Source:** `lua/claudecode/init.lua` lines 368-370

```lua
if M.state.config.auto_start then
  M.start(false) -- Suppress notification on auto-start
end
```

**Mechanism:**
1. When `setup()` is called (during plugin loading), it reads your config
2. If `opts.auto_start == true`, it immediately calls `M.start(false)`
3. Server starts without any additional action needed
4. Lock file created at `~/.claude/ide/[port].lock`
5. Environment variable `CLAUDE_CODE_SSE_PORT` set to the port number
6. Claude CLI can now connect when launched

**Your Current Config:**
```lua
opts = {
  auto_start = true,  -- This enables automatic startup
  -- ... other options
}
```

This is already handling server initialization - the VimEnter autocmd is redundant and broken.

## Terminal Command Flow (How `--continue` Works)

**Source:** `lua/claudecode/terminal.lua` lines 292-325

### Step 1: Command Parsing
```lua
local function get_claude_command_and_env(cmd_args)
  local cmd_from_config = defaults.terminal_cmd
  local base_cmd = cmd_from_config or "claude"
  
  -- Your terminal_cmd from config:
  -- base_cmd = "/Users/cyperx/.claude/local/claude"
```

### Step 2: Argument Concatenation
```lua
  local cmd_string
  if cmd_args and cmd_args ~= "" then
    cmd_string = base_cmd .. " " .. cmd_args
    -- Result: "/Users/cyperx/.claude/local/claude --continue"
  else
    cmd_string = base_cmd
  end
```

### Step 3: Environment Setup
```lua
  local env_table = {
    ENABLE_IDE_INTEGRATION = "true",
    FORCE_CODE_TERMINAL = "true",
    CLAUDE_CODE_SSE_PORT = tostring(M.state.port),  -- e.g., "24591"
  }
```

### Step 4: Execution
```lua
  provider.open(cmd_string, claude_env_table, effective_config)
  -- Terminal provider executes the command with environment variables
```

## How Your Keybindings Work

**Your Config (line 189-190):**
```lua
{ "<leader>cr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
{ "<leader>cC", launch_claude_continue, desc = "Continue Claude" },
```

**Execution Flow:**
1. User presses `<leader>cr` → `:ClaudeCode --resume` executed
2. Goes to `ClaudeCode` command handler (init.lua line 986)
3. Handler extracts `opts.args` = `"--resume"`
4. Calls `terminal.simple_toggle({}, "--resume")`
5. Terminal module appends to command: `"/Users/cyperx/.claude/local/claude --resume"`
6. Claude Code CLI launches with --resume flag
7. Claude's backend handles session restoration

**Context Preservation:**
- `--continue`: Continues existing conversation in Claude Code backend
- `--resume`: Resumes previous session from Claude Code backend
- The Neovim WebSocket server connection is maintained across both
- File context is preserved by the Claude Code backend service

## All Registered Vim Commands

**From `_create_commands()` (lines 527-1052):**

```vim
:ClaudeCode [args]                              Toggle terminal (show/hide)
:ClaudeCodeFocus [args]                        Smart focus toggle
:ClaudeCodeOpen [args]                         Open terminal
:ClaudeCodeClose                               Close terminal
:ClaudeCodeStart                               Start WebSocket server
:ClaudeCodeStop                                Stop WebSocket server
:ClaudeCodeStatus                              Show server status
:ClaudeCodeAdd <file> [start-line] [end-line]  Add file to context
:ClaudeCodeSend                                Send visual selection
:ClaudeCodeTreeAdd                             Add from file tree
:ClaudeCodeSelectModel [args]                  Choose model and launch
:ClaudeCodeDiffAccept                          Accept proposed changes
:ClaudeCodeDiffDeny                            Reject proposed changes
```

All of these support optional arguments that get passed to the Claude CLI.

## Complete Initialization Sequence

```
NEOVIM STARTUP
    ↓
lazy.nvim detects and loads claudecode.nvim
    ↓
plugin/claudecode.lua loads (guard against double-load)
    ↓
Your config function in lua/custom/plugins/claude.lua executes
    ├─ calls require('claudecode').setup(opts)
    │  ├─ reads config: auto_start=true, terminal_cmd, etc.
    │  ├─ if auto_start: calls M.start(false)
    │  │  ├─ generates auth token
    │  │  ├─ starts TCP/WebSocket server on random port (e.g., 24591)
    │  │  ├─ creates ~/.claude/ide/24591.lock with connection info
    │  │  └─ returns port number
    │  ├─ calls _create_commands() to register all :ClaudeCode* commands
    │  └─ returns module
    │
    ├─ sets up terminal module with your config
    ├─ sets up selection tracking if enabled
    ├─ registers VimEnter autocmd (your code - BROKEN)
    ├─ registers FocusGained/BufEnter autocmd for :checktime
    ├─ registers TermOpen autocmd for window sizing
    └─ sets vim.opt.autoread = true
        ↓
VimEnter event fires
    ├─ your autocmd runs pcall(require('claudecode').initialize_server())
    ├─ initialize_server() doesn't exist
    ├─ pcall silently catches the error
    └─ no harm done, but no effect either
        ↓
User presses <leader>cr
    ├─ `:ClaudeCode --resume` executed
    ├─ terminal opens with Claude Code CLI
    ├─ environment: CLAUDE_CODE_SSE_PORT=24591
    ├─ command: /Users/cyperx/.claude/local/claude --resume
    ├─ Claude Code connects to Neovim's WebSocket server
    ├─ WebSocket handshake completes
    └─ Full IDE integration active
```

## Issue Summary

**Problem:**
- Your VimEnter autocmd calls `require('claudecode').initialize_server()`
- This function does not exist in claudecode.nvim
- The error is silently caught by pcall, so you don't see it
- But the intended effect (starting the server) never happens

**Why It Doesn't Break Everything:**
- `auto_start=true` already starts the server in the setup function
- By the time VimEnter fires, the server is already running
- The broken autocmd just tries to do the same thing that already happened
- So your Claude integration actually works despite the bug

**The Fix:**
Option 1 (Recommended - remove it):
```lua
-- Delete lines 141-150 from your claude.lua
-- auto_start=true already handles this
```

Option 2 (If you want explicit control):
```lua
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    vim.defer_fn(function()
      -- Use the correct function name
      require('claudecode').start(false)
    end, 100)
  end,
  desc = 'Ensure Claude Code server is running',
})
```

## Testing the Setup

**Check server status:**
```vim
:ClaudeCodeStatus
" Should show: "Claude Code integration is running on port XXXXX"
```

**Check if Claude is connected:**
```lua
:lua print(require('claudecode').is_claude_connected())
" Should eventually show: true (after you launch Claude)
```

**View configuration:**
```lua
:lua print(vim.inspect(require('claudecode').state.config))
```

**Check lock file:**
```bash
ls -la ~/.claude/ide/*.lock
" Should show a lock file with the port number
```

## Summary

| Aspect | Status | Details |
|--------|--------|---------|
| Plugin installed | ✅ | `/Users/cyperx/.local/share/nvim/lazy/claudecode.nvim/` |
| auto_start enabled | ✅ | Server starts automatically on Neovim startup |
| Terminal cmd configured | ✅ | `/Users/cyperx/.claude/local/claude` |
| Keybindings setup | ✅ | --continue and --resume work correctly |
| VimEnter autocmd | ❌ | Calls non-existent `initialize_server()` function |
| Session continuation | ✅ | Handled by Claude Code CLI backend |
| WebSocket server | ✅ | Started automatically, port in lock file |
| IDE integration | ✅ | Full MCP protocol implementation |

## Recommended Next Steps

1. Remove the broken VimEnter autocmd from claude.lua (lines 141-150)
2. Test server startup: `:ClaudeCodeStatus`
3. Launch Claude: `<leader>cm` then select model
4. Try session continuation: `<leader>cr` for resume
5. Everything should work the same or better

All your other Claude integration features are correctly implemented!
