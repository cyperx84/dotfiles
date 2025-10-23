--[[
=============================================================================
Neovim Autocmds Configuration
=============================================================================
File-type specific autocmds and buffer-local configurations
============================================================================
]]

-- Markdown-specific keymaps
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  group = vim.api.nvim_create_augroup('markdown-keymaps', { clear = true }),
  callback = function(event)
    local opts = { buffer = event.buf, silent = true }

    -- Jump between markdown headers
    vim.keymap.set('n', 'gj', [[/^##\+ .*<CR>]], vim.tbl_extend('force', opts, { desc = 'Next markdown header' }))
    vim.keymap.set('n', 'gk', [[?^##\+ .*<CR>]], vim.tbl_extend('force', opts, { desc = 'Previous markdown header' }))
  end,
})

-- vim: ts=2 sts=2 sw=2 et