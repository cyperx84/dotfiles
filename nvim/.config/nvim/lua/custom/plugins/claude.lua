return {
  'coder/claudecode.nvim',
  dependencies = {
    'folke/snacks.nvim', -- Optional for enhanced terminal
  },
  opts = {
    -- Server options
    port_range = { min = 10000, max = 65535 },
    auto_start = true,
    log_level = 'info',

    -- Terminal options
    terminal = {
      split_side = 'right',
      split_width_percentage = 0.2,
      provider = 'native', -- "auto" (default), "snacks", or "native"
      auto_close = true, -- Auto-close terminal after command completion
    },

    -- Diff options
    diff_opts = {
      auto_close_on_accept = true,
      vertical_split = true,
    },
  },
  config = true,
  keys = {
    { '<leader>c', nil, desc = 'AI/Claude Code' },
    { '<c-M-j>', '<cmd>ClaudeCode<cr>', desc = 'Toggle Claude' },
    { '<leader>cf', '<cmd>ClaudeCodeFocus<cr>', desc = 'Focus Claude' },
    { '<leader>cs', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = 'Send to Claude' },
    {
      '<leader>cs',
      '<cmd>ClaudeCodeTreeAdd<cr>',
      desc = 'Add file',
      ft = { 'NvimTree', 'neo-tree' },
    },
    { '<leader>co', '<cmd>ClaudeCodeOpen<cr>', desc = 'Open Claude' },
    { '<leader>cx', '<cmd>ClaudeCodeClose<cr>', desc = 'Close Claude' },
  },
}
