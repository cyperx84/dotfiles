return {
  'pittcat/claude-fzf-history.nvim',
  dependencies = { 'ibhagwan/fzf-lua' },
  config = function()
    require('claude-fzf-history').setup()
  end,
  cmd = { 'ClaudeHistory', 'ClaudeHistoryDebug' },
  keys = {
    { '<leader>ch', '<cmd>ClaudeHistory<CR>', desc = 'Claude-code History' },
  },
}
