-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins, you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup {
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --  This is equivalent to:
  --    require('Comment').setup({})

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  { 'mbbill/undotree' },

  { 'github/copilot.vim' },

  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {},
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
  },

  -- modular approach: using `require 'path/name'` will
  -- include a plugin definition from file lua/path/name.lua
  require 'cyperx/plugins/debug',

  require 'cyperx/plugins/indent_line',

  require 'cyperx/plugins/gitsigns',

  require 'cyperx/plugins/which-key',

  require 'cyperx/plugins/telescope',

  require 'cyperx/plugins/lspconfig',

  require 'cyperx/plugins/conform',

  require 'cyperx/plugins/cmp',

  require 'cyperx/plugins/colorscheme',

  require 'cyperx/plugins/todo-comments',

  require 'cyperx/plugins/mini',

  require 'cyperx/plugins/treesitter',

  require 'cyperx/plugins/mojo',

  require 'cyperx/plugins/neotree',

  require 'cyperx/plugins/tmux-navigator',

  require 'cyperx/plugins/harpoon-config',

  require 'cyperx/plugins/jackmort-chatgpt',

  require 'cyperx/plugins/obsidian',

  require 'cyperx/plugins/venv-selector',

  -- require 'cyperx/plugins/image',

  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- put them in the right spots if you want.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for kickstart
  --
  --  Here are some example plugins that I've included in the kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information see: :help lazy.nvim-lazy.nvim-structuring-your-plugins
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

vim.keymap.set('n', '<C-e>', function()
  toggle_telescope(harpoon:list())
end, { desc = 'Open harpoon window' })

vim.keymap.set('n', '<C-M-a>', function()
  harpoon:list():append()
end)
vim.keymap.set('n', '<C-e>', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set('n', '<C-M-s>', function()
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

package.path = package.path .. ';' .. vim.fn.expand '$HOME' .. '/.luarocks/share/lua/5.1/?/init.lua;'
package.path = package.path .. ';' .. vim.fn.expand '$HOME' .. '/.luarocks/share/lua/5.1/?.lua;'

-- vim: ts=2 sts=2 sw=2 et
