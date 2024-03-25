-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit insert mode without hitting Esc
vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Esc' })

-- Keymaps for better default experience
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- center the screen when jumping to another line
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
-- vim.keymap.set('n', '<C-d>', "<Cmd>lua vim.cmd('normal! n'); MiniAnimate.execute_after('scroll', 'normal! zz')<CR>")
-- vim.keymap.set('n', '<C-u>', "<Cmd>lua vim.cmd('normal! n'); MiniAnimate.execute_after('scroll', 'normal! zz')<CR>")

-- Neotree
vim.keymap.set('n', '<C-e>', '<Cmd>Neotree toggle<CR>', { desc = 'Open Neotree' })

-- UndotreeToggle
vim.keymap.set('n', '<C-M-r>', '<Cmd>UndotreeToggle<CR>', { desc = 'Open Undotree toggle' })

-- Diagnostic
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- ChatGPT
vim.keymap.set('n', '<C-M-c>', '<Cmd>ChatGPT<CR>', { desc = 'ChatGPT' })

-- Obsidian
vim.keymap.set('n', '<leader>on', '<Cmd>ObsidianNew<CR>', { desc = 'Obsidian New' })
vim.keymap.set('n', '<leader>or', '<Cmd>ObsidianRename<CR>', { desc = 'Obsidian Rename' })
vim.keymap.set('n', '<leader>op', '<Cmd>ObsidianQuickSwitch<CR>', { desc = 'Obsidian Quick Switcher' })
vim.keymap.set('n', '<leader>oe', '<Cmd>ObsidianExtractNote<CR>', { desc = 'Obsidian Link New' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See :help lua-guide-autocommands

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
