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

-- Auto-position cursor below frontmatter and fold it when opening markdown files
vim.api.nvim_create_autocmd({ 'BufRead', 'BufWinEnter', 'BufWritePost' }, {
  pattern = '*.md',
  group = vim.api.nvim_create_augroup('markdown-frontmatter-cursor', { clear = true }),
  callback = function(event)
    -- Save current cursor position (for BufWritePost/BufWinEnter)
    local cursor_pos = vim.api.nvim_win_get_cursor(0)

    -- Only proceed if file starts with frontmatter delimiter
    local first_line = vim.fn.getline(1)
    if first_line ~= '---' then
      return
    end

    -- Find the closing frontmatter delimiter
    local line_count = vim.fn.line('$')
    for i = 2, math.min(50, line_count) do  -- Limit search to first 50 lines
      if vim.fn.getline(i) == '---' then
        -- Set foldmethod to manual to create the fold
        vim.opt_local.foldmethod = 'manual'

        -- Create fold for frontmatter section (lines 1 to i)
        vim.cmd(string.format('1,%d fold', i))

        -- Move to line 1 and close the fold
        vim.api.nvim_win_set_cursor(0, { 1, 0 })
        vim.cmd('normal! zc')

        -- Only move cursor to after frontmatter on initial file open (BufRead)
        -- On BufWritePost/BufWinEnter, restore original cursor position
        if event.event == 'BufRead' then
          local target_line = i + 1
          if target_line <= line_count then
            vim.api.nvim_win_set_cursor(0, { target_line, 0 })
          end
        else
          vim.api.nvim_win_set_cursor(0, cursor_pos)
        end
        return
      end
    end
  end,
})

-- Save and restore folds automatically
local fold_exclude_ft = { 'gitcommit', 'gitrebase', 'help', '' }

vim.api.nvim_create_autocmd('BufWinLeave', {
  pattern = '*',
  group = vim.api.nvim_create_augroup('save-folds', { clear = true }),
  callback = function()
    if not vim.tbl_contains(fold_exclude_ft, vim.bo.filetype) then
      vim.cmd('silent! mkview')
    end
  end,
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = '*',
  group = vim.api.nvim_create_augroup('restore-folds', { clear = true }),
  callback = function()
    if not vim.tbl_contains(fold_exclude_ft, vim.bo.filetype) then
      vim.cmd('silent! loadview')
    end
  end,
})

-- vim: ts=2 sts=2 sw=2 et
