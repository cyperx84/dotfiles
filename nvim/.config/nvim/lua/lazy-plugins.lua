require('lazy').setup {

  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  { 'numToStr/Comment.nvim', opts = {} },

  { 'mbbill/undotree' },

  { 'github/copilot.vim' },

  require 'cyperx/plugins/noice',
  require 'cyperx/plugins/which-key',
  require 'cyperx/plugins/telescope',
  require 'cyperx/plugins/lspconfig',
  require 'cyperx/plugins/conform',
  require 'cyperx/plugins/cmp',
  require 'cyperx/plugins/colorscheme',
  require 'cyperx/plugins/todo-comments',
  require 'cyperx/plugins/mini',
  require 'cyperx/plugins/treesitter',
  require 'cyperx/plugins/indent_line',
  require 'cyperx/plugins/gitsigns',

  require 'cyperx/plugins/debug',
  require 'cyperx/plugins/dap-python',

  require 'cyperx/plugins/neotree',
  require 'cyperx/plugins/tmux-navigator',
  require 'cyperx/plugins/harpoon-config',
  require 'cyperx/plugins/jackmort-chatgpt',

  require 'cyperx/plugins/venv-selector',
  require 'cyperx/plugins/obsidian',
  require 'cyperx/plugins/mojo',
  -- { 'girishji/pythondoc.vim', opts = {} },
  -- {
  --   'nvimdev/dashboard-nvim',
  --   event = 'VimEnter',
  --   theme = 'hyper',
  --   config = function()
  --     require('dashboard').setup {
  --       -- config
  --       center = {
  --         {
  --           icon = '',
  --           icon_hl = 'group',
  --           desc = 'description',
  --           desc_hl = 'group',
  --           key = 'shortcut key in dashboard buffer not keymap !!',
  --           key_hl = 'group',
  --           key_format = ' [%s]', -- `%s` will be substituted with value of `key`
  --           action = '',
  --         },
  --       },
  --       footer = {},
  --     }
  --   end,
  --   dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  -- },
  -- require 'cyperx/plugins/image',

  -- { import = 'custom.plugins' },
}

-- Config for harpoon
local harpoon = require 'harpoon'
harpoon:setup {}

-- basic telescope configuration
local conf = require('telescope.config').values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require('telescope.pickers')
    .new({}, {
      prompt_title = 'Harpoon',
      finder = require('telescope.finders').new_table {
        results = file_paths,
      },
      previewer = conf.file_previewer {},
      sorter = conf.generic_sorter {},
    })
    :find()
end

vim.keymap.set('n', '<C-M-a>', function()
  harpoon:list():append()
end)
vim.keymap.set('n', '<C-M-e>', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set('n', '<C-M-t>', function()
  toggle_telescope(harpoon:list())
end, { desc = 'Open harpoon window' })

vim.keymap.set('n', '<C-M-h>', function()
  harpoon:list():select(1)
end)
vim.keymap.set('n', '<C-M-j>', function()
  harpoon:list():select(2)
end)
vim.keymap.set('n', '<C-M-k>', function()
  harpoon:list():select(3)
end)
vim.keymap.set('n', '<C-M-l>', function()
  harpoon:list():select(4)
end)
-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set('n', '<C-M-P>', function()
  harpoon:list():prev()
end)
vim.keymap.set('n', '<C-M-N>', function()
  harpoon:list():next()
end)

vim.filetype.add {
  extension = {
    mdx = 'markdown.mdx',
  },
  filename = {},
  pattern = {},
}
-- Add mdx to treesitter
local ft_to_parser = require('nvim-treesitter.parsers').filetype_to_parsername
ft_to_parser.mdx = 'markdown'

-- package.path = package.path .. ';' .. vim.fn.expand '$HOME' .. '/.luarocks/share/lua/5.1/?/init.lua;'
-- package.path = package.path .. ';' .. vim.fn.expand '$HOME' .. '/.luarocks/share/lua/5.1/?.lua;'

-- vim: ts=2 sts=2 sw=2 et
