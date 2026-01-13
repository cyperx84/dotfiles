--[[
Neovim keymaps configuration
This file defines custom keybindings for Neovim, including:
- Window navigation
- Plugin integrations (e.g., MiniDiff, Obsidian, Neogit)
- Utility mappings (e.g., yanking, pasting, buffer management)
- Terminal and diagnostic controls
]]
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- Diagnostic keymaps
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('t', '<C-q>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Quick Save
vim.keymap.set('n', '<C-s>', ':w<CR>', { desc = 'Save file' })

-- Quick quit
vim.keymap.set('n', '<C-q>', ':q<CR>', { desc = 'Quit current buffer' })

-- Toggle Markview (no plugin file - keep here)
vim.keymap.set("n", "<leader>tm", "<cmd>Markview<CR>", { desc = "Toggle Markview" })

-- Exit insert mode without hitting Esc
vim.keymap.set("i", "jk", "<Esc><Esc>", { desc = "Esc" })

-- Make Y behave like C or D
vim.keymap.set("n", "Y", "y$")

-- Select all
vim.keymap.set("n", "==", "gg<S-v>G")

-- Keep window centered when going up/down
vim.keymap.set("n", "J", "mzJ`z")

-- Smart center: only zz when in the middle of buffer (can scroll both ways)
-- Skips centering at edges or on short files that fit on screen
local function should_center()
  local at_top = vim.fn.line 'w0' == 1
  local at_bottom = vim.fn.line 'w$' >= vim.fn.line '$'
  return not at_top and not at_bottom
end

-- Note: <C-d> and <C-u> are handled by neoscroll.nvim plugin with smart centering
vim.keymap.set("n", "n", function()
  vim.cmd "normal! n"
  if should_center() then
    vim.cmd "normal! zzzv"
  end
end, { desc = "Next search result (smart center)" })

vim.keymap.set("n", "N", function()
  vim.cmd "normal! N"
  if should_center() then
    vim.cmd "normal! zzzv"
  end
end, { desc = "Previous search result (smart center)" })

-- Paste without overwriting register
vim.keymap.set("v", "p", '"_dP')

-- Copy text to system clipboard
vim.keymap.set("n", "<leader>y", "\"+y", { desc = "Yank to system clipboard" })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "Yank line to system clipboard" })

-- Delete text to void register (preserves clipboard)
vim.keymap.set("n", "<leader>D", "\"_d", { desc = "Delete to void register" })
vim.keymap.set("v", "<leader>D", "\"_d", { desc = "Delete to void register" })

-- Quit with q
vim.keymap.set("n", "Q", "<nop>")

-- close buffer
vim.keymap.set("n", "<leader>bq", "<cmd>bd<CR>", { desc = "Close Buffer" })

-- Close buffer without closing split
vim.keymap.set("n", "<leader>bw", "<cmd>bp|bd #<CR>", { desc = "Close Buffer; Retain Split" })

-- Navigate between quickfix items (moved to avoid conflicts with which-key groups)
vim.keymap.set("n", "<leader>qn", "<cmd>cnext<CR>zz", { desc = "Next quickfix item" })
vim.keymap.set("n", "<leader>qp", "<cmd>cprev<CR>zz", { desc = "Previous quickfix item" })

-- Navigate between location list items
vim.keymap.set("n", "<leader>ln", "<cmd>lnext<CR>zz", { desc = "Next location item" })
vim.keymap.set("n", "<leader>lp", "<cmd>lprev<CR>zz", { desc = "Previous location item" })

-- vim: ts=2 sts=2 sw=2 et
