return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd.colorscheme 'unokai'

      -- -- Make window separators and float borders purple
      -- local function set_purple_highlights()
      --   vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#ff00ff', bg = 'NONE' })
      --   vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#ff00ff', bg = 'NONE' })
      --   vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE' })
      --   -- Telescope-specific highlights
      --   vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg = '#ff00ff', bg = 'NONE' })
      --   vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { fg = '#ff00ff', bg = 'NONE' })
      --   vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', { fg = '#ff00ff', bg = 'NONE' })
      --   vim.api.nvim_set_hl(0, 'TelescopePreviewBorder', { fg = '#ff00ff', bg = 'NONE' })
      -- end
      --
      -- set_purple_highlights()
      --
      -- -- Ensure they stay purple even if other plugins override them
      -- vim.api.nvim_create_autocmd('ColorScheme', {
      --   pattern = '*',
      --   callback = set_purple_highlights,
      -- })
      --
      -- -- Also re-apply after window/buffer changes
      -- vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter', 'CmdlineLeave' }, {
      --   callback = set_purple_highlights,
      -- })
    end,
  },
  {
    'loctvl842/monokai-pro.nvim',
  },
}
