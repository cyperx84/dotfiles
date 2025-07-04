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
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })


vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[FILES]]

-- Mini.Files
vim.keymap.set('n', '<C-e>', function()
  local bufname = vim.api.nvim_buf_get_name(0)
  if vim.bo.filetype == 'minifiles' or bufname:match('^MiniFiles') then
    require('mini.files').close()
  else
    require('mini.files').open()
  end
end, { desc = 'Toggle mini.files' })

-- Yazi
vim.keymap.set('n', '<leader>-', '<CMD>Yazi<CR>', { desc = 'Open parent directory' })
-- OIL
vim.keymap.set('n', '-', '<CMD>Oil --float<CR>', { desc = 'Open parent directory' })
-- Neotree
vim.keymap.set('n', '<leader>E', '<Cmd>Neotree toggle<CR>', { desc = 'Open Neotree' })

-- Neogit
vim.keymap.set("n", "<leader>gg", "<cmd>Neogit kind=floating<CR>", { desc = "Floating" })
vim.keymap.set("n", "<leader>gG", "<cmd>Neogit kind=split<CR>", { desc = "Auto" })
vim.keymap.set("n", "<leader>gb", "<cmd>Neogit branch kind=auto<CR>", { desc = "Branch" })
vim.keymap.set("n", "<leader>gB", "<cmd>Neogit branch_config kind=auto<CR>", { desc = "Branch Config" })
vim.keymap.set("n", "<leader>gc", "<cmd>Neogit commit kind=auto<CR>", { desc = "Commit" })
vim.keymap.set("n", "<leader>gd", "<cmd>Neogit diff kind=auto<CR>", { desc = "Diff" })
vim.keymap.set("n", "<leader>gl", "<cmd>Neogit log kind=auto<CR>", { desc = "Log" })
vim.keymap.set("n", "<leader>gs", "<cmd>Neogit stash kind=auto<CR>", { desc = "Stash" })
vim.keymap.set("n", "<leader>gm", "<cmd>Neogit merge kind=auto<CR>", { desc = "Merge" })
vim.keymap.set("n", "<leader>gP", "<cmd>Neogit pull<CR>", { desc = "Pull" })
vim.keymap.set("n", "<leader>gp", "<cmd>Neogit push<CR>", { desc = "Push" })

-- Dismiss Noice Message
vim.keymap.set("n", "<leader>z", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss Noice Message" })

-- Obsidian
vim.keymap.set("n", "<leader>oc", "<cmd>lua require('obsidian').util.toggle_checkbox()<CR>",
  { desc = "Obsidian Check Checkbox" })
vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianTags<CR>", { desc = "Obsidian Tags" })
vim.keymap.set("n", "<leader>oO", "<cmd>ObsidianOpen<CR>", { desc = "Open in Obsidian App" })
vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "Show ObsidianBacklinks" })
vim.keymap.set("n", "<leader>oe", "<cmd>ObsidianExtractNote<CR>", { desc = "Extract - New" })
vim.keymap.set("n", "<leader>oF", "<cmd>ObsidianFollowLink<CR>", { desc = "Follow Link" })
vim.keymap.set("n", "<leader>ol", "<cmd>ObsidianLinks<CR>", { desc = "Show ObsidianLinks" })
vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "Create New Note" })
vim.keymap.set("n", "<leader>or", "<cmd>ObsidianRename<CR>", { desc = "Rename" })
vim.keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "Search Obsidian" })
vim.keymap.set("n", "<leader>of", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Quick Switch" })
vim.keymap.set("n", "<leader>op", "<cmd>ObsidianPasteImg<CR>", { desc = "Paste Img" })
vim.keymap.set("n", "<leader>ow", "<cmd>ObsidianWorkspace<CR>", { desc = "Workspace" })

-- toggle notify log
vim.keymap.set("n", "<leader>sl", "<cmd>Telescope notify<CR>", { desc = "[S]earch Notify [L]og" })

-- Toggle Markview
vim.keymap.set("n", "<leader>tm", "<cmd>Markview<CR>", { desc = "Toggle Markview" })

-- Toggle Transparent
vim.keymap.set("n", "<leader>tt", "<cmd>TransparentToggle<CR>", { desc = "Transparent Toggle" })

-- toggle MiniDiff
vim.keymap.set("n", "<leader>td", function() require('mini.diff').toggle() end, { desc = "Toggle MiniDiff" })

-- Paste Image
vim.keymap.set("n", "<leader>pi", "<cmd>PasteImage<CR>", { desc = "Paste Image" })

-- Create Git Worktree - select or enter name for new
vim.keymap.set("n", "<leader>gW", "<cmd>:lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>", { desc = "Create Worktree" })

-- Switch Git Worktree - c-f Force c-d Del
vim.keymap.set("n", "<leader>gt", "<cmd>:lua require('telescope').extensions.git_worktree.git_worktrees()<CR>", { desc = "Switch Worktree" })

-- MCPHub
vim.keymap.set("n", "<leader>m", "<cmd>MCPHub<CR>", { desc = "MCPHub" })

--Code Companion
vim.keymap.set("n", "<c-M-k>", "<cmd>CodeCompanionChat Toggle<CR>", { desc = "Code Companion Chat Toggle" })
vim.keymap.set("n", "<leader>CC", "<cmd>CodeCompanion<CR>", { desc = "Code Companion" })
vim.keymap.set("n", "<leader>Cc", "<cmd>CodeCompanionActions<CR>", { desc = "Code Companion Actions" })
vim.keymap.set("n", "<leader>Cd", "<cmd>CodeCompanionCMD<CR>", { desc = "Code Companion Actions" })

-- Jump between markdown headers
vim.keymap.set("n", "gj", [[/^##\+ .*<CR>]], { buffer = true, silent = true })
vim.keymap.set("n", "gk", [[?^##\+ .*<CR>]], { buffer = true, silent = true })

-- Exit insert mode without hitting Esc
vim.keymap.set("i", "jk", "<Esc><Esc>", { desc = "Esc" })

-- Make Y behave like C or D
vim.keymap.set("n", "Y", "y$")

-- Select all
vim.keymap.set("n", "==", "gg<S-v>G")

-- Keep window centered when going up/down
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste without overwriting register
vim.keymap.set("v", "p", '"_dP')

-- Copy text to " register
vim.keymap.set("n", "<leader>y", "\"+y", { desc = "Yank into \" register" })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "Yank into \" register" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "Yank into \" register" })

-- Delete text to " register
vim.keymap.set("n", "<leader>d", "\"_d", { desc = "Delete into \" register" })
vim.keymap.set("v", "<leader>d", "\"_d", { desc = "Delete into \" register" })

-- Get out Q
vim.keymap.set("n", "Q", "<nop>")

-- close buffer
vim.keymap.set("n", "<leader>q", "<cmd>bd<CR>", { desc = "Close Buffer" })

-- Close buffer without closing split
vim.keymap.set("n", "<leader>w", "<cmd>bp|bd #<CR>", { desc = "Close Buffer; Retain Split" })

-- Navigate between quickfix items
vim.keymap.set("n", "<leader>h", "<cmd>cnext<CR>zz", { desc = "Forward qfixlist" })
vim.keymap.set("n", "<leader>;", "<cmd>cprev<CR>zz", { desc = "Backward qfixlist" })

-- Navigate between location list items
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Forward location list" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Backward location list" })

-- vim: ts=2 sts=2 sw=2 et
