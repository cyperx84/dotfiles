return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd.colorscheme 'unokai'
    end,
  },
  {
    'loctvl842/monokai-pro.nvim',
  },
}
