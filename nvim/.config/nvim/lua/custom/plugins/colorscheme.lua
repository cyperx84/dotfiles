return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd.colorscheme 'unokai'

      -- Make window separators purple
      vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#ff00ff', bg = 'NONE' })

      -- Ensure it stays purple even if colorscheme resets it
      vim.api.nvim_create_autocmd('ColorScheme', {
        pattern = '*',
        callback = function()
          vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#ff00ff', bg = 'NONE' })
        end,
      })
    end,
  },
  {
    'loctvl842/monokai-pro.nvim',
  },
}
