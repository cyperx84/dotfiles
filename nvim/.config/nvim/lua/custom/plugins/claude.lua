-- Shared helper: run ClaudeCode command with error notification
local function run_claudecode(label)
  local ok, err = pcall(vim.cmd, 'ClaudeCode')
  if not ok then
    vim.notify('Error launching Claude Code (' .. label .. '): ' .. (err or 'Unknown error'), vim.log.levels.ERROR)
    return false
  end
  return true
end

-- Toggle Claude Code without moving cursor focus
local function toggle_claude_no_focus()
  local current_win = vim.api.nvim_get_current_win()
  if not run_claudecode('toggle') then return end
  vim.defer_fn(function()
    if vim.api.nvim_win_is_valid(current_win) and vim.api.nvim_get_current_win() ~= current_win then
      vim.api.nvim_set_current_win(current_win)
    end
  end, 50)
end

-- Env keys managed by providers; unset via vim.NIL so children don't inherit empty strings
local PROVIDER_ENV_KEYS = {
  'ANTHROPIC_BASE_URL',
  'ANTHROPIC_AUTH_TOKEN',
  'API_TIMEOUT_MS',
  'ANTHROPIC_MODEL',
  'ANTHROPIC_SMALL_FAST_MODEL',
  'ANTHROPIC_DEFAULT_SONNET_MODEL',
  'ANTHROPIC_DEFAULT_OPUS_MODEL',
  'ANTHROPIC_DEFAULT_HAIKU_MODEL',
  'CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC',
}

local function clear_provider_env()
  local uv = vim.uv or vim.loop
  for _, k in ipairs(PROVIDER_ENV_KEYS) do
    if uv and uv.os_unsetenv then
      uv.os_unsetenv(k)
    else
      vim.fn.setenv(k, '')
    end
  end
end

-- Factory: build a provider launcher from a pass key and env table
local function make_launcher(name, pass_key, env)
  return function()
    clear_provider_env()
    if pass_key then
      local handle = io.popen('zsh -i -c "pass ' .. pass_key .. '" 2>&1')
      if not handle then
        vim.notify('Error: Could not retrieve ' .. name .. ' API key from pass', vim.log.levels.ERROR)
        return
      end
      local api_key = handle:read('*a'):gsub('\n', '')
      handle:close()
      if api_key == '' then
        vim.notify('Error: ' .. name .. ' API key is empty', vim.log.levels.ERROR)
        return
      end
      env.ANTHROPIC_AUTH_TOKEN = api_key
    end
    for k, v in pairs(env) do
      vim.fn.setenv(k, v)
    end
    run_claudecode(name)
  end
end

local launch_claude_normal = make_launcher('normal', nil, {})

local launch_claude_minimax = make_launcher('MiniMax', 'apis/MINIMAX_API_KEY', {
  ANTHROPIC_BASE_URL = 'https://api.minimax.io/anthropic',
  API_TIMEOUT_MS = '3000000',
  ANTHROPIC_MODEL = 'MiniMax-M2',
  ANTHROPIC_SMALL_FAST_MODEL = 'MiniMax-M2',
  ANTHROPIC_DEFAULT_SONNET_MODEL = 'MiniMax-M2',
  ANTHROPIC_DEFAULT_OPUS_MODEL = 'MiniMax-M2',
  ANTHROPIC_DEFAULT_HAIKU_MODEL = 'MiniMax-M2',
  CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC = '1',
})

local launch_claude_glm = make_launcher('GLM', 'apis/GLM_API_KEY', {
  ANTHROPIC_BASE_URL = 'https://api.z.ai/api/anthropic',
  API_TIMEOUT_MS = '3000000',
  ANTHROPIC_MODEL = 'GLM-4.6',
  ANTHROPIC_SMALL_FAST_MODEL = 'GLM-4.5-Air',
  ANTHROPIC_DEFAULT_SONNET_MODEL = 'GLM-4.6',
  ANTHROPIC_DEFAULT_OPUS_MODEL = 'GLM-4.6',
  ANTHROPIC_DEFAULT_HAIKU_MODEL = 'GLM-4.5-Air',
  CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC = '1',
})

-- Send a single buffer name to Claude Code via Lua API
local function send_bufname(bufname, source)
  local claudecode = require('claudecode')
  return pcall(claudecode.send_at_mention, bufname, nil, nil, source)
end

local function add_current_buffer()
  local bufname = vim.api.nvim_buf_get_name(0)
  if bufname == '' then
    vim.notify('No file in current buffer', vim.log.levels.WARN)
    return
  end
  local ok, err = send_bufname(bufname, 'add_buffer')
  if ok then
    vim.notify('Added buffer to Claude Code', vim.log.levels.INFO)
  else
    vim.notify('Error adding buffer: ' .. (err or 'Unknown error'), vim.log.levels.ERROR)
  end
end

local function send_all_buffers()
  local valid_buffers = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
      local bufname = vim.api.nvim_buf_get_name(buf)
      if bufname ~= '' and not bufname:match('^term://') then
        table.insert(valid_buffers, bufname)
      end
    end
  end

  if #valid_buffers == 0 then
    vim.notify('No valid buffers to send to Claude Code', vim.log.levels.WARN)
    return
  end

  for _, bufname in ipairs(valid_buffers) do
    local ok, err = send_bufname(bufname, 'send_all_buffers')
    if not ok then
      vim.notify('Error adding buffer ' .. bufname .. ': ' .. (err or 'Unknown error'), vim.log.levels.ERROR)
    end
  end
  vim.notify('Added ' .. #valid_buffers .. ' buffer(s) to Claude Code', vim.log.levels.INFO)
end

return {
  'coder/claudecode.nvim',
  lazy = false,
  priority = 1000,
  dependencies = {
    'folke/snacks.nvim',
  },
  opts = {
    terminal_cmd = vim.fn.expand('~/.local/bin/claude') .. ' --dangerously-skip-permissions',

    port_range = { min = 10000, max = 65535 },
    auto_start = true,
    log_level = 'warn',

    terminal = {
      split_side = 'right',
      provider = 'snacks',
      auto_close = true,
      split_width_percentage = 0.35,
      cwd_provider = function(ctx)
        local git_root = vim.fn.systemlist('git -C ' .. vim.fn.shellescape(ctx.file_dir) .. ' rev-parse --show-toplevel')[1]
        if vim.v.shell_error == 0 and git_root then
          return git_root
        end
        return ctx.file_dir
      end,
    },

    diff_opts = {
      auto_close_on_accept = true,
      vertical_split = true,
      open_in_current_tab = true,
      keep_terminal_focus = true,
    },
  },
  config = function(_, opts)
    require('claudecode').setup(opts)

    -- Auto-reload buffers when Claude Code modifies files
    vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
      callback = function()
        if vim.fn.mode() ~= 'c' then
          vim.cmd('checktime')
        end
      end,
      desc = 'Auto-reload buffers when changed externally by Claude Code',
    })

    -- Fix Claude Code terminal window width
    vim.api.nvim_create_autocmd('TermOpen', {
      pattern = 'term://*claude*',
      callback = function()
        local win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_width(win, 60)
        vim.wo.winfixwidth = true
        vim.wo.winfixheight = true

        if vim.fn.exists(':NoiceDismiss') == 2 then
          vim.cmd('NoiceDismiss')
        elseif pcall(require, 'notify') then
          vim.schedule(function() vim.cmd('echo ""') end)
        end
      end,
      desc = 'Fix Claude Code terminal window width at 60 columns',
    })

    vim.opt.autoread = true
  end,
  keys = {
    -- Core Claude Code commands
    { '<M-;>', launch_claude_normal, desc = 'Toggle Claude (normal)' },
    { '<M-;>', toggle_claude_no_focus, desc = 'Toggle Claude (close)', mode = 't' },
    { '<leader>cf', '<cmd>ClaudeCodeFocus<cr>', desc = 'Focus Claude' },
    { '<leader>cm', '<cmd>ClaudeCodeSelectModel<cr>', desc = 'Select Claude model' },

    -- Session management
    { '<leader>cr', '<cmd>ClaudeCode --resume<cr>', desc = 'Resume Claude' },
    { '<leader>cC', '<cmd>ClaudeCode --continue<cr>', desc = 'Continue Claude' },

    -- File/content management
    { '<leader>cb', add_current_buffer, desc = 'Add current buffer' },
    { '<leader>cB', send_all_buffers, desc = 'Add all buffers to Claude' },
    { '<leader>cs', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = 'Send selection to Claude' },
    { '<leader>cS', '<cmd>ClaudeCodeSend<cr>', mode = 'n', desc = 'Send current line to Claude' },

    -- Tree/file explorer integration
    {
      '<leader>ca',
      '<cmd>ClaudeCodeTreeAdd<cr>',
      desc = 'Add file from tree',
      ft = { 'NvimTree', 'neo-tree', 'oil', 'minifiles' },
    },

    -- Quick actions
    { '<leader>cc', '<cmd>ClaudeCode<cr>', desc = 'Claude Code' },
    { '<leader>c?', '<cmd>help claudecode<cr>', desc = 'Claude Code help' },
    { '<leader>cq', '<cmd>ClaudeCode --quit<cr>', desc = 'Quit Claude Code' },

    -- Claude Code with different providers
    { '<leader>ccc', launch_claude_normal, desc = 'Claude Code (original)' },
    { '<leader>ccm', launch_claude_minimax, desc = 'Claude Code (MiniMax)' },
    { '<leader>ccg', launch_claude_glm, desc = 'Claude Code (GLM)' },
  },
}
