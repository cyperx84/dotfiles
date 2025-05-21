vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
require 'options'
require 'keymaps'
require 'lazy-bootstrap'
require 'lazy-plugins'
vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(ev)
    vim.api.nvim_create_autocmd('BufWipeout', {
      buffer = ev.data.buf_id,
      callback = function()
        require('mini.files').synchronize()
      end,
    })
  end,
})
-- vim: ts=2 sts=2 sw=2 et
