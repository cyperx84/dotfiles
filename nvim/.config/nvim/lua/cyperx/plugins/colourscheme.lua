return {
  -- Monokai Pro colorscheme
  'loctvl842/monokai-pro.nvim',
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'monokai-pro-machine'
  end,
}