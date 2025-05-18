return {
  {
    'loctvl842/monokai-pro.nvim',
    priority = 1000,
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd.colorscheme 'tokyonight-storm'
    end,
  },
}
