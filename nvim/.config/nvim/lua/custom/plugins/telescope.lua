return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- native fzf sorter
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      local telescope = require 'telescope'
      local themes = require 'telescope.themes'
      local builtin = require 'telescope.builtin'

      telescope.setup {
        defaults = {
          -- follow symlinks in both file and grep pickers
          -- NOTE: These are regex patterns, not literal strings! Escape dots with \\
          file_ignore_patterns = { '\\.git', 'node_modules', '\\.cache', '\\.obsidian', '\\.smart%-connections' },
          -- Centered float layout with larger preview
          layout_strategy = 'horizontal',
          layout_config = {
            horizontal = {
              prompt_position = 'top',
              width = 0.85,         -- 85% of screen width
              height = 0.85,        -- 85% of screen height
              preview_width = 0.6,  -- Preview takes 60% of the window
              preview_cutoff = 1,   -- Always show preview
            },
          },

          -- Border styling
          borderchars = {
            prompt  = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            results = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          },

          sorting_strategy = 'ascending',
          winblend = 0,
          follow_symlinks = true,
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--follow',
          },
        },
        pickers = {
          -- make `:Telescope find_files` chase symlinks too
          find_files = {
            follow = true,
            hidden = true,
          },
        },
        extensions = {
          ['ui-select'] = themes.get_dropdown(),
        },
      }

      -- load extensions if available
      pcall(telescope.load_extension, 'fzf')
      pcall(telescope.load_extension, 'ui-select')
      pcall(telescope.load_extension, 'obsidian')
      pcall(telescope.load_extension, 'git_worktree')

      -- Orange border with transparent background (matching Oil)
      vim.api.nvim_set_hl(0, 'TelescopeBorder', {
        fg = '#ff9e64',  -- Orange border color
        bg = 'NONE'      -- Transparent background
      })

      vim.api.nvim_set_hl(0, 'TelescopePromptBorder', {
        fg = '#ff9e64',
        bg = 'NONE'
      })

      vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', {
        fg = '#ff9e64',
        bg = 'NONE'
      })

      vim.api.nvim_set_hl(0, 'TelescopePreviewBorder', {
        fg = '#ff9e64',
        bg = 'NONE'
      })

      -- keymaps
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- override default for current-buffer fuzzy-find
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(themes.get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- live-grep in open files only
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- search Neovim config
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files {
          cwd = vim.fn.resolve(vim.fn.stdpath 'config'),
          follow = true,
          hidden = true,
          file_ignore_patterns = {},
          use_git_root = false,
        }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
