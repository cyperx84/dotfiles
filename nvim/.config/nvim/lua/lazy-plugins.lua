require('lazy').setup {

  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  { 'numToStr/Comment.nvim', opts = {} },

  { 'mbbill/undotree' },

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

  -- require 'cyperx/plugins/venv-selector',
  require 'cyperx/plugins/obsidian',
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    opts = function()
      local logo = [[
                                                                             
               ████ ██████           █████      ██                     
              ███████████             █████                             
              █████████ ███████████████████ ███   ███████████   
             █████████  ███    █████████████ █████ ██████████████   
            █████████ ██████████ █████████ █████ █████ ████ █████   
          ███████████ ███    ███ █████████ █████ █████ ████ █████  
         ██████  █████████████████████ ████ █████ █████ ████ ██████
      ]]

      logo = string.rep('\n', 8) .. logo .. '\n\n'

      local opts = {
        theme = 'doom',
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          header = vim.split(logo, '\n'),
          -- stylua: ignore
          center = {
            { action = "Telescope find_files", desc = " Find file", icon = " ", key = "f" },
            { action = "ene | startinsert", desc = " New file", icon = " ", key = "n" },
            { action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r" },
            { action = "Telescope live_grep", desc = " Find text", icon = " ", key = "g" },
            -- {
            --   action = [[lua require("lazyvim.util").telescope.config_files()()]],
            --   desc = " Config",
            --   icon = " ",
            --   key = "c"
            -- },
            -- { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
            -- { action = "LazyExtras", desc = " Lazy Extras", icon = " ", key = "x" },
            { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
            { action = "qa", desc = " Quit", icon = " ", key = "q" },
          },
          footer = function()
            local stats = require('lazy').stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms' }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(' ', 43 - #button.desc)
        button.key_format = '  %s'
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == 'lazy' then
        vim.cmd.close()
        vim.api.nvim_create_autocmd('User', {
          pattern = 'DashboardLoaded',
          callback = function()
            require('lazy').show()
          end,
        })
      end

      return opts
    end,
  },
  {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup {
        default_file_explorer = true,
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        view_options = {
          show_hidden = true,
          natural_order = true,
          is_always_hidden = function(name, _)
            return name == '..' or name == '.git'
          end,
        },
        float = {
          padding = 2,
          max_width = 90,
          max_height = 0,
        },
        win_options = {
          wrap = true,
          winblend = 0,
        },
        keymaps = {
          ['<C-c>'] = false,
          ['q'] = 'actions.close',
        },
      }
    end,
  },
  -- require 'cyperx/plugins/mojo',
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
  harpoon:list():add()
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

package.path = package.path .. ';' .. vim.fn.expand '$HOME' .. '/.luarocks/share/lua/5.1/?/init.lua;'
package.path = package.path .. ';' .. vim.fn.expand '$HOME' .. '/.luarocks/share/lua/5.1/?.lua;'

-- vim: ts=2 sts=2 sw=2 et
