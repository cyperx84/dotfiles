# claudecode.nvim - Code Reference and Examples

## File Locations

| Purpose | Path |
|---------|------|
| Plugin Installation | `/Users/cyperx/.local/share/nvim/lazy/claudecode.nvim/` |
| Main Module | `/Users/cyperx/.local/share/nvim/lazy/claudecode.nvim/lua/claudecode/init.lua` |
| Terminal Module | `/Users/cyperx/.local/share/nvim/lazy/claudecode.nvim/lua/claudecode/terminal.lua` |
| Server Module | `/Users/cyperx/.local/share/nvim/lazy/claudecode.nvim/lua/claudecode/server/init.lua` |
| Your Config | `/Users/cyperx/dotfiles/nvim/.config/nvim/lua/custom/plugins/claude.lua` |

## Setup Function Actual Code

**From `init.lua` lines 322-389:**

```lua
---Set up the plugin with user configuration
---@param opts PartialClaudeCodeConfig|nil Optional configuration table to override defaults.
---@return table module The plugin module
function M.setup(opts)
  opts = opts or {}

  local config = require("claudecode.config")
  M.state.config = config.apply(opts)

  logger.setup(M.state.config)

  -- Setup terminal module
  local terminal_setup_ok, terminal_module = pcall(require, "claudecode.terminal")
  if terminal_setup_ok then
    if type(terminal_module.setup) == "function" then
      terminal_module.setup(opts.terminal, M.state.config.terminal_cmd, M.state.config.env)
    end
  else
    logger.error("init", "Failed to load claudecode.terminal module for setup.")
  end

  local diff = require("claudecode.diff")
  diff.setup(M.state.config)

  -- THIS IS WHERE auto_start WORKS:
  if M.state.config.auto_start then
    M.start(false) -- Suppress notification on auto-start
  end

  M._create_commands()

  vim.api.nvim_create_autocmd("VimLeavePre", {
    group = vim.api.nvim_create_augroup("ClaudeCodeShutdown", { clear = true }),
    callback = function()
      if M.state.server then
        M.stop()
      else
        -- Clear queue even if server isn't running
        clear_mention_queue()
      end
    end,
    desc = "Automatically stop Claude Code integration when exiting Neovim",
  })

  M.state.initialized = true
  return M
end
```

## Start Function Actual Code

**From `init.lua` lines 395-482:**

```lua
---Start the Claude Code integration
---@param show_startup_notification? boolean Whether to show a notification upon successful startup (defaults to true)
---@return boolean success Whether the operation was successful
---@return number|string port_or_error The WebSocket port if successful, or error message if failed
function M.start(show_startup_notification)
  if show_startup_notification == nil then
    show_startup_notification = true
  end
  if M.state.server then
    local msg = "Claude Code integration is already running on port " .. tostring(M.state.port)
    logger.warn("init", msg)
    return false, "Already running"
  end

  local server = require("claudecode.server.init")
  local lockfile = require("claudecode.lockfile")

  -- Generate auth token first
  local auth_token
  local auth_success, auth_result = pcall(function()
    return lockfile.generate_auth_token()
  end)

  if not auth_success then
    local error_msg = "Failed to generate authentication token: " .. (auth_result or "unknown error")
    logger.error("init", error_msg)
    return false, error_msg
  end

  auth_token = auth_result

  -- Validate the generated auth token
  if not auth_token or type(auth_token) ~= "string" or #auth_token < 10 then
    local error_msg = "Invalid authentication token generated"
    logger.error("init", error_msg)
    return false, error_msg
  end

  local success, result = server.start(M.state.config, auth_token)

  if not success then
    local error_msg = "Failed to start Claude Code server: " .. (result or "unknown error")
    logger.error("init", error_msg)
    return false, error_msg
  end

  M.state.server = server
  M.state.port = tonumber(result)
  M.state.auth_token = auth_token

  -- Create lock file so Claude CLI can discover the server
  local lock_success, lock_result, returned_auth_token = lockfile.create(M.state.port, auth_token)

  if not lock_success then
    server.stop()
    M.state.server = nil
    M.state.port = nil
    M.state.auth_token = nil

    local error_msg = "Failed to create lock file: " .. (lock_result or "unknown error")
    logger.error("init", error_msg)
    return false, error_msg
  end

  if M.state.config.track_selection then
    local selection = require("claudecode.selection")
    selection.enable(M.state.server, M.state.config.visual_demotion_delay_ms)
  end

  if show_startup_notification then
    logger.info("init", "Claude Code integration started on port " .. tostring(M.state.port))
  end

  return true, M.state.port
end
```

## ClaudeCode Command Handler

**From `init.lua` lines 986-996:**

```lua
vim.api.nvim_create_user_command("ClaudeCode", function(opts)
  local current_mode = vim.fn.mode()
  if current_mode == "v" or current_mode == "V" or current_mode == "\22" then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
  end
  local cmd_args = opts.args and opts.args ~= "" and opts.args or nil
  terminal.simple_toggle({}, cmd_args)  -- cmd_args contains your --continue or --resume
end, {
  nargs = "*",
  desc = "Toggle the Claude Code terminal window (simple show/hide) with optional arguments",
})
```

## Terminal Command Concatenation

**From `terminal.lua` lines 288-325:**

```lua
---Gets the claude command string and necessary environment variables
---@param cmd_args string? Optional arguments to append to the command
---@return string cmd_string The command string
---@return table env_table The environment variables table
local function get_claude_command_and_env(cmd_args)
  -- Inline get_claude_command logic
  local cmd_from_config = defaults.terminal_cmd
  local base_cmd
  if not cmd_from_config or cmd_from_config == "" then
    base_cmd = "claude" -- Default if not configured
  else
    base_cmd = cmd_from_config
  end

  local cmd_string
  if cmd_args and cmd_args ~= "" then
    cmd_string = base_cmd .. " " .. cmd_args  -- <-- THIS IS HOW --continue GETS ADDED
  else
    cmd_string = base_cmd
  end

  local sse_port_value = claudecode_server_module.state.port
  local env_table = {
    ENABLE_IDE_INTEGRATION = "true",
    FORCE_CODE_TERMINAL = "true",
  }

  if sse_port_value then
    env_table["CLAUDE_CODE_SSE_PORT"] = tostring(sse_port_value)
  end

  -- Merge custom environment variables from config
  for key, value in pairs(defaults.env) do
    env_table[key] = value
  end

  return cmd_string, env_table
end
```

## Your Configuration Analysis

**Your Config File:** `/Users/cyperx/dotfiles/nvim/.config/nvim/lua/custom/plugins/claude.lua`

### The Bug (Lines 141-150)

```lua
-- Ensure Claude Code server starts on Neovim startup
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    vim.defer_fn(function()
      pcall(function()
        require('claudecode').initialize_server()  -- THIS FUNCTION DOES NOT EXIST
      end)
    end, 100)
  end,
  desc = 'Initialize Claude Code server on startup',
})
```

**Why it's a bug:**
1. `require('claudecode')` doesn't have an `initialize_server()` function
2. `pcall()` catches the error silently, so you don't see it
3. The function would try to start the server manually
4. But `auto_start=true` (line 112) already started it during setup
5. So this is redundant AND broken

### Correct Session Management (Lines 188-190)

```lua
-- Session management
{ "<leader>cr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
{ "<leader>cC", launch_claude_continue, desc = "Continue Claude" },
```

**This works correctly because:**
1. `:ClaudeCode --resume` calls the command handler
2. `cmd_args = "--resume"` is extracted
3. Terminal module appends it: `base_cmd .. " " .. cmd_args`
4. Final: `/Users/cyperx/.claude/local/claude --resume`
5. Claude CLI receives --resume and handles session restoration

## How to Test Your Setup

### Test 1: Check if Server is Running

```vim
" In Neovim:
:ClaudeCodeStatus

" Output should be:
" [INFO] Claude Code integration is running on port 24591
```

### Test 2: Check Connection State

```lua
" In Neovim:
:lua print(require('claudecode').is_claude_connected())

" Output: false (until you launch Claude Code CLI)
" After launching Claude with your config:
" Output: true
```

### Test 3: Verify Lock File

```bash
# In terminal:
ls -la ~/.claude/ide/*.lock

# Output should show something like:
# -rw-r--r-- 1 cyperx staff 289 Nov  1 15:30 24591.lock
```

### Test 4: Check Environment Variables

```bash
# In terminal (while Claude is running):
env | grep CLAUDE_CODE_SSE_PORT

# Output should show:
# CLAUDE_CODE_SSE_PORT=24591
```

## The Correct Configuration

**Minimal working setup:**

```lua
return {
  'coder/claudecode.nvim',
  lazy = false,
  priority = 1000,
  dependencies = { 'folke/snacks.nvim' },
  opts = {
    terminal_cmd = '/Users/cyperx/.claude/local/claude',
    auto_start = true,        -- Starts server automatically
    port_range = { min = 10000, max = 65535 },
    log_level = 'info',
    terminal = {
      split_side = 'right',
      provider = 'snacks',
      split_width_percentage = 0.35,
    },
  },
  config = function(_, opts)
    require('claudecode').setup(opts)
    -- NO NEED FOR VimEnter autocmd - auto_start handles it!
  end,
  keys = {
    { "<leader>cr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    { "<leader>cC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    -- ... rest of your keybindings
  },
}
```

## All Public API Functions

**Complete list of functions you can call:**

```lua
local claude = require('claudecode')

-- Server control
claude.setup(opts)                                    -- Initialize plugin
claude.start(show_notification)                      -- Start WebSocket server
claude.stop()                                        -- Stop WebSocket server
claude.is_claude_connected()                         -- Check if Claude is connected

-- Context management
claude.send_at_mention(file, start_line, end_line, context)  -- Queue/send file
claude.process_mention_queue(from_new_connection)    -- Process queued mentions

-- Version and UI
claude.get_version()                                 -- Get version info
claude.open_with_model(args)                         -- Model selection UI
```

**Functions to AVOID (internal/test only):**

```lua
claude._broadcast_at_mention()
claude._ensure_terminal_visible_if_connected()
claude._format_path_for_at_mention()
claude._add_paths_to_claude()
claude._create_commands()
claude.initialize_server()  -- DOES NOT EXIST!
```

## Configuration Options

**From your config (opts passed to setup):**

```lua
opts = {
  -- Server
  auto_start = true,                          -- Auto-start server (recommended)
  port_range = { min = 10000, max = 65535 },
  log_level = 'info',
  
  -- Terminal
  terminal_cmd = '/Users/cyperx/.claude/local/claude',  -- Your Claude installation
  terminal = {
    split_side = 'right',
    provider = 'snacks',
    split_width_percentage = 0.35,
    auto_close = true,
  },
  
  -- Selection tracking
  track_selection = true,
  visual_demotion_delay_ms = 50,
  
  -- Focus behavior
  focus_after_send = false,
  
  -- Diff integration
  diff_opts = {
    auto_close_on_accept = true,
    vertical_split = true,
  },
}
```

## Next Steps

1. Remove lines 141-150 from your claude.lua (the broken VimEnter autocmd)
2. Test with `:ClaudeCodeStatus`
3. Launch Claude with your keybinding
4. Use `<leader>cr` to resume sessions
5. Everything should work as expected

All the rest of your configuration is correct!
