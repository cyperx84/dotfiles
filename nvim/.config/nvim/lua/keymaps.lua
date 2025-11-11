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

-- NOTE: TextYankPost autocmd moved to options.lua or autocmds.lua for better organization

-- [[FILES]]

-- Mini.Files
-- vim.keymap.set('n', '<c-e>', function()
--   local bufname = vim.api.nvim_buf_get_name(0)
--   if vim.bo.filetype == 'minifiles' or bufname:match('^MiniFiles') then
--     require('mini.files').close()
--   else
--     require('mini.files').open()
--   end
-- end, { desc = 'Toggle mini.files' })

-- Yazi
vim.keymap.set('n', '-', '<CMD>Yazi<CR>', { desc = 'Open parent directory' })
-- -- OIL
-- vim.keymap.set('n', '<c-e>', '<CMD>Oil --float<CR>', { desc = 'Open parent directory' })
-- Neotree
-- vim.keymap.set('n', '<leader>E', '<Cmd>Neotree toggle<CR>', { desc = 'Open Neotree' })

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

-- toggle notify log
vim.keymap.set("n", "<leader>sl", "<cmd>Telescope notify<CR>", { desc = "[S]earch Notify [L]og" })

-- Toggle Markview
vim.keymap.set("n", "<leader>tm", "<cmd>Markview<CR>", { desc = "Toggle Markview" })

-- Toggle Transparent
vim.keymap.set("n", "<leader>tt", "<cmd>TransparentToggle<CR>", { desc = "Transparent Toggle" })

-- toggle MiniDiff
vim.keymap.set("n", "<leader>td", function() require('mini.diff').toggle_overlay() end, { desc = "Toggle MiniDiff" })

-- Paste Image
vim.keymap.set("n", "<leader>pi", "<cmd>PasteImage<CR>", { desc = "Paste Image" })

-- Create Git Worktree - select or enter name for new
vim.keymap.set("n", "<leader>gW", "<cmd>:lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>", { desc = "Create Worktree" })

-- Switch Git Worktree - c-f Force c-d Del
vim.keymap.set("n", "<leader>gt", "<cmd>:lua require('telescope').extensions.git_worktree.git_worktrees()<CR>", { desc = "Switch Worktree" })

-- MCPHub
vim.keymap.set("n", "<leader>m", "<cmd>MCPHub<CR>", { desc = "MCPHub" })

--Code Companion
vim.keymap.set("n", "<M-c>", "<cmd>CodeCompanionChat Toggle<CR>", { desc = "Code Companion Chat Toggle" })
vim.keymap.set("n", "<leader>CC", "<cmd>CodeCompanion<CR>", { desc = "Code Companion" })
vim.keymap.set("n", "<leader>Cc", "<cmd>CodeCompanionActions<CR>", { desc = "Code Companion Actions" })
vim.keymap.set("n", "<leader>Cb", "<cmd>CodeCompanionChat Add<CR>", { desc = "Add Buffer to Chat" })
vim.keymap.set("v", "<leader>Cs", "<cmd>CodeCompanionChat Add<CR>", { desc = "Add Selection to Chat" })

--Claude-code History
vim.keymap.set("n", "<leader>ch", "<cmd>ClaudeHistory<CR>", { desc = "Claude-code History" })

-- Python Documentation Lookup
vim.keymap.set("n", "<leader>hp", function()
  vim.ui.input({ prompt = "Python module: " }, function(module)
    if module and module ~= "" then
      -- Create a new buffer for the documentation
      vim.cmd("enew")
      vim.cmd("file pydoc-" .. module)
      vim.bo.swapfile = false
      vim.bo.bufhidden = "wipe"
      vim.bo.filetype = "help"  -- Set filetype to help for better highlighting

      -- Run pydoc in the new buffer
      local cmd = "read !python3 -m pydoc " .. vim.fn.shellescape(module)
      vim.cmd(cmd)
      vim.cmd("normal! gg")
      vim.cmd("setlocal nomodifiable")
      vim.notify("Python docs for: " .. module, vim.log.levels.INFO)
    end
  end)
end, { desc = "[H]elp [P]ython module" })

-- NOTE: Markdown header navigation (gj/gk) is defined in autocmds.lua for markdown files

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

-- Copy text to system clipboard
vim.keymap.set("n", "<leader>y", "\"+y", { desc = "Yank to system clipboard" })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "Yank line to system clipboard" })

-- Delete text to void register (preserves clipboard)
vim.keymap.set("n", "<leader>D", "\"_d", { desc = "Delete to void register" })
vim.keymap.set("v", "<leader>D", "\"_d", { desc = "Delete to void register" })

-- Get out Q
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

-- Session Management (mini.sessions)
-- Save current session with name
vim.keymap.set('n', '<leader>Ss', function()
  vim.ui.input({ prompt = 'Session name: ' }, function(input)
    if input then
      require('mini.sessions').write(input)
      vim.notify('Session saved: ' .. input, vim.log.levels.INFO)
    end
  end)
end, { desc = '[S]ession [S]ave' })

-- Quick open/restore sessions for specific contexts
vim.keymap.set('n', '<leader>Sh', function()
  vim.cmd('%bdelete')  -- Close all buffers
  if vim.fn.exists(':Snacks') == 2 then
    Snacks.dashboard()
  end
end, { desc = '[S]ession [H]ome (Dashboard)' })

vim.keymap.set('n', '<leader>Sn', function()
  require('mini.sessions').read('notes')
end, { desc = '[S]ession open [N]otes' })

vim.keymap.set('n', '<leader>Sd', function()
  require('mini.sessions').read('dotfiles')
end, { desc = '[S]ession open [D]otfiles' })

vim.keymap.set('n', '<leader>Sc', function()
  require('mini.sessions').read('code')
end, { desc = '[S]ession open [C]ode' })

-- Load/Restore sessions
vim.keymap.set('n', '<leader>Sl', function()
  require('mini.sessions').select('read')
end, { desc = '[S]ession [L]oad (select)' })

vim.keymap.set('n', '<leader>Sr', function()
  vim.ui.input({ prompt = 'Session name to restore: ', default = 'notes' }, function(input)
    if input then
      require('mini.sessions').read(input)
    end
  end)
end, { desc = '[S]ession [R]estore by name' })

-- Delete session
vim.keymap.set('n', '<leader>Sx', function()
  require('mini.sessions').select('delete')
end, { desc = '[S]ession delete (select)' })

-- Write current session (updates last loaded)
vim.keymap.set('n', '<leader>Sw', function()
  require('mini.sessions').write()
  vim.notify('Current session saved', vim.log.levels.INFO)
end, { desc = '[S]ession [W]rite current' })

-- vim: ts=2 sts=2 sw=2 et
