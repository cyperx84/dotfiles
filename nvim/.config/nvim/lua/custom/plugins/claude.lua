-- Custom function to toggle Claude Code without moving cursor focus
local function toggle_claude_no_focus()
  local current_win = vim.api.nvim_get_current_win()

  -- Safely execute ClaudeCode command with error handling
  local success, err = pcall(vim.cmd, 'ClaudeCode')
  if not success then
    vim.notify('Error toggling Claude Code: ' .. (err or 'Unknown error'), vim.log.levels.ERROR)
    return
  end

  -- Small delay to ensure Claude Code has time to toggle
  vim.defer_fn(function()
    -- Check if the original window still exists before trying to focus it
    if vim.api.nvim_win_is_valid(current_win) then
      local current_focus = vim.api.nvim_get_current_win()
      -- Only switch focus if we're not already in the original window
      if current_focus ~= current_win then
        vim.api.nvim_set_current_win(current_win)
      end
    end
  end, 50) -- 50ms delay
end

-- Custom function to launch Claude Code with DeepSeek configuration
local function launch_claude_deepseek()
  local current_win = vim.api.nvim_get_current_win()

  -- Get DeepSeek API key from pass
  local handle = io.popen('pass apis/DEEPSEEK_API_KEY 2>/dev/null')
  if not handle then
    vim.notify('Error: Could not retrieve DeepSeek API key from pass', vim.log.levels.ERROR)
    return
  end
  local api_key = handle:read('*a'):gsub('\n', '')
  handle:close()

  if api_key == '' then
    vim.notify('Error: DeepSeek API key is empty', vim.log.levels.ERROR)
    return
  end

  -- Set environment variables for DeepSeek
  vim.fn.setenv('ANTHROPIC_BASE_URL', 'https://api.deepseek.com/anthropic')
  vim.fn.setenv('ANTHROPIC_AUTH_TOKEN', api_key)
  vim.fn.setenv('API_TIMEOUT_MS', '600000')
  vim.fn.setenv('ANTHROPIC_MODEL', 'deepseek-chat')
  vim.fn.setenv('ANTHROPIC_SMALL_FAST_MODEL', 'deepseek-chat')
  vim.fn.setenv('CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC', '1')

  -- Launch Claude Code
  local success, err = pcall(vim.cmd, 'ClaudeCode')
  if not success then
    vim.notify('Error launching Claude Code (DeepSeek): ' .. (err or 'Unknown error'), vim.log.levels.ERROR)
    return
  end

  -- Restore focus
  vim.defer_fn(function()
    if vim.api.nvim_win_is_valid(current_win) then
      local current_focus = vim.api.nvim_get_current_win()
      if current_focus ~= current_win then
        vim.api.nvim_set_current_win(current_win)
      end
    end
  end, 50)
end

return {
  'coder/claudecode.nvim',
  dependencies = {
    'folke/snacks.nvim', -- Optional for enhanced terminal
  },
  opts = {
    -- Path to your Claude Code installation
    terminal_cmd = '/Users/cyperx/.claude/local/claude --dangerously-skip-permissions',

    -- Server options
    port_range = { min = 10000, max = 65535 },
    auto_start = true,
    log_level = 'info', -- Use 'debug' for troubleshooting

    -- Terminal options
    terminal = {
      split_side = 'right',
      provider = 'snacks', -- "auto" (default), "snacks", or "native"
      auto_close = true, -- Auto-close terminal after command completion
      split_width_percentage = 0.35, -- 35% of window width (adjust as needed)
      cwd_provider = function(ctx)
        -- Dynamic working directory detection for git repos
        local git_root = vim.fn.systemlist('git -C ' .. vim.fn.shellescape(ctx.file_dir) .. ' rev-parse --show-toplevel')[1]
        if vim.v.shell_error == 0 and git_root then
          return git_root
        end
        return ctx.file_dir
      end,
    },

    -- Diff options
    diff_opts = {
      auto_close_on_accept = true,
      vertical_split = true, -- Better for code comparison
    },
  },
  config = function(_, opts)
    require('claudecode').setup(opts)

    -- Auto-reload buffers when Claude Code modifies files
    -- Triggers on focus gain, buffer enter, and cursor hold
    vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
      callback = function()
        if vim.fn.mode() ~= 'c' then -- Don't reload in command mode
          vim.cmd('checktime')
        end
      end,
      desc = 'Auto-reload buffers when changed externally by Claude Code',
    })

    -- Fix Claude Code terminal window size (prevent resizing)
    vim.api.nvim_create_autocmd({ 'TermOpen', 'BufWinEnter' }, {
      pattern = { 'term://*claude*', '*ClaudeCode*' },
      callback = function()
        local win = vim.api.nvim_get_current_win()
        -- Set fixed width of 100 columns
        vim.api.nvim_win_set_width(win, 60)
        -- Prevent resizing
        vim.wo.winfixwidth = true
        vim.wo.winfixheight = true
      end,
      desc = 'Fix Claude Code terminal window size at 100 columns',
    })

    -- Enable autoread globally for better file watching
    vim.opt.autoread = true
  end,
  keys = {
    -- Core Claude Code commands
    { "<M-;>", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude (with focus)" },
    { "<M-;>", toggle_claude_no_focus, desc = "Toggle Claude (close)", mode = "t" },
    { "<M-'>", launch_claude_deepseek, desc = "Toggle Claude (DeepSeek)" },
    { "<leader>cf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    { "<leader>cm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },

    -- Session management
    { "<leader>cr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    { "<leader>cC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },

    -- File/content management
    { "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    { "<leader>cs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send selection to Claude" },
    { "<leader>cS", "<cmd>ClaudeCodeSend<cr>", mode = "n", desc = "Send line to Claude" },

    -- Tree/file explorer integration
    {
      "<leader>ca",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file from tree",
      ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
    },

    -- Diff management
    -- { "<leader>ca", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    -- { "<leader>cd", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },

    -- Quick actions
    { "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Claude Code" },
    { "<leader>c?", "<cmd>help claudecode<cr>", desc = "Claude Code help" },
    { "<leader>cq", "<cmd>ClaudeCode --quit<cr>", desc = "Quit Claude Code" },
  },
}
