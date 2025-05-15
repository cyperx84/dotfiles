-- [[ Setting options ]]
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.confirm = true
vim.opt.termguicolors = true
vim.opt.relativenumber = true
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)
vim.opt.conceallevel = 2
vim.opt.isfname:append("@-@") -- already present in most setups
vim.opt.isfname:append("32")  -- allow spaces in filenames
-- vim: ts=2 sts=2 sw=2 et
