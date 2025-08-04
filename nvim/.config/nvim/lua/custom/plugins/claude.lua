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
    -- Core Claude Code commands
    { "<c-M-j>", toggle_claude_no_focus, desc = "Toggle Claude (no focus)" },
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
      "<leader>as",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file from tree",
      ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
    },
    
    -- Diff management
    { "<leader>ca", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>cd", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    
    -- Quick actions
    { "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Claude Code" },
    { "<leader>c?", "<cmd>help claudecode<cr>", desc = "Claude Code help" },
  },
}
