return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd.colorscheme 'monokai-pro-spectrum'
    end,
  },
  {
    'loctvl842/monokai-pro.nvim',
  },
}
