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
      provider = 'snacks', -- "auto" (default), "snacks", or "native"
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
    -- { "<leader>a", nil, desc = "AI/Claude Code" },
    { "<c-M-j>", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    { "<leader>cf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    { "<leader>cr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    { "<leader>cC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    { "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    { "<leader>cs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    {
      "<leader>as",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file",
      ft = { "NvimTree", "neo-tree", "oil" },
    },
    -- Diff management
    { "<leader>ca", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>cd", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },},
}
