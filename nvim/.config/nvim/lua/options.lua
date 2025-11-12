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
vim.opt.listchars = { tab = '» ', trail = ' ', nbsp = '␣' }
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
vim.opt.laststatus = 3
vim.g.python3_host_prog = os.getenv("HOME") .. "/.nvim-venv/bin/python"
vim.g.loaded_perl_provider = 0
vim.opt.isfname:append("@-@") -- already present in most setups
vim.opt.isfname:append("32")  -- allow spaces in filenames
vim.opt.swapfile = false
-- [[ Autocmds ]]
-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
