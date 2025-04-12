return {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    -- Monokai Pro colorscheme
    'loctvl842/monokai-pro.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'monokai-pro-machine'
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
