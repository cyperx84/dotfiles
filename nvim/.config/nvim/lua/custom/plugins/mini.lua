return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()
      -- Session management with auto-load and auto-save
      require('mini.sessions').setup {
        -- Automatically read default session when opening Neovim without files
        autoread = true,
        -- Automatically save current session before switching or quitting
        autowrite = true,
        -- Global sessions stored in standard location
        directory = vim.fn.stdpath 'data' .. '/sessions',
        -- Local session file name (in current working directory)
        file = 'Session.vim',
        -- Force options (be careful with these)
        force = { read = false, write = true, delete = false },
        -- Show session path after actions (helpful when learning)
        verbose = { read = true, write = true, delete = true },
      }
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
      -- File explorer with column view (Miller columns)
      require('mini.files').setup {
        -- Customization of shown content
        content = {
          filter = nil, -- Show all files by default
          prefix = nil, -- Use default icons
          sort = nil, -- Use default sort (directories first, then alphabetically)
        },
        -- Mappings inside the explorer
        mappings = {
          close = 'q',
          go_in = 'l',
          go_in_plus = 'L', -- Open file and close explorer
          go_out = 'h',
          go_out_plus = 'H', -- Go out and trim right
          mark_goto = "'",
          mark_set = 'm',
          reset = '<BS>',
          reveal_cwd = '@',
          show_help = 'g?',
          synchronize = '=', -- Apply file system changes
          trim_left = '<',
          trim_right = '>',
        },
        options = {
          permanent_delete = false, -- Delete permanently instead of to trash
          use_as_default_explorer = true, -- Replace netrw
        },
        windows = {
          max_number = math.huge, -- No limit on windows
          preview = true, -- Don't show preview by default
          width_focus = 50,
          width_nofocus = 15,
          width_preview = 25,
        },
      }

      -- Toggle function for mini.files
      _G.minifiles_toggle = function(...)
        if not MiniFiles.close() then
          MiniFiles.open(...)
        end
      end

      -- Keymaps for opening mini.files
      -- vim.keymap.set('n', '<c-e>', function()
      --   _G.minifiles_toggle()
      -- end, { desc = 'Toggle file [e]xplorer' })
      --
      -- vim.keymap.set('n', '<c-M-e>', function()
      --   _G.minifiles_toggle(vim.api.nvim_buf_get_name(0))
      -- end, { desc = 'Toggle file [E]xplorer (current file)' })

      -- Custom mappings inside mini.files buffers
      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          local buf_id = args.data.buf_id

          -- Toggle dotfiles with 'g.'
          local show_dotfiles = true
          local filter_show = function()
            return true
          end
          local filter_hide = function(fs_entry)
            return not vim.startswith(fs_entry.name, '.')
          end
          local toggle_dotfiles = function()
            show_dotfiles = not show_dotfiles
            local new_filter = show_dotfiles and filter_show or filter_hide
            MiniFiles.refresh { content = { filter = new_filter } }
          end
          vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id, desc = 'Toggle dotfiles' })

          -- Split mappings
          local map_split = function(lhs, direction, close_on_file)
            local rhs = function()
              local cur_target = MiniFiles.get_explorer_state().target_window
              local new_target = vim.api.nvim_win_call(cur_target, function()
                vim.cmd(direction .. ' split')
                return vim.api.nvim_get_current_win()
              end)
              MiniFiles.set_target_window(new_target)
              MiniFiles.go_in { close_on_file = close_on_file }
            end
            local desc = 'Open in ' .. direction .. ' split'
            vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
          end

          map_split('<C-s>', 'belowright horizontal', false)
          map_split('<C-v>', 'belowright vertical', false)

          -- Utility mappings
          local set_cwd = function()
            local path = (MiniFiles.get_fs_entry() or {}).path
            if path == nil then
              return vim.notify('Cursor is not on valid entry')
            end
            vim.fn.chdir(vim.fs.dirname(path))
            vim.notify('Set CWD to: ' .. vim.fs.dirname(path))
          end

          local yank_path = function()
            local path = (MiniFiles.get_fs_entry() or {}).path
            if path == nil then
              return vim.notify('Cursor is not on valid entry')
            end
            vim.fn.setreg(vim.v.register, path)
            vim.notify('Yanked path: ' .. path)
          end

          local open_with_system = function()
            local path = (MiniFiles.get_fs_entry() or {}).path
            if path == nil then
              return vim.notify('Cursor is not on valid entry')
            end
            vim.ui.open(path)
          end

          vim.keymap.set('n', 'g~', set_cwd, { buffer = buf_id, desc = 'Set CWD' })
          vim.keymap.set('n', 'gy', yank_path, { buffer = buf_id, desc = 'Yank path' })
          vim.keymap.set('n', 'gx', open_with_system, { buffer = buf_id, desc = 'Open with system' })
        end,
      })

      -- Set custom bookmarks
      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesExplorerOpen',
        callback = function()
          MiniFiles.set_bookmark('c', vim.fn.stdpath 'config', { desc = 'Config' })
          MiniFiles.set_bookmark('w', vim.fn.getcwd, { desc = 'Working directory' })
          MiniFiles.set_bookmark('~', '~', { desc = 'Home directory' })
        end,
      })

      -- Auto-sync on close (will still show confirmation prompt for safety)
      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesExplorerClose',
        callback = function()
          -- Check if there are any modified buffers before syncing
          local has_changes = false
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.bo[buf].modified and vim.bo[buf].buftype == '' then
              has_changes = true
              break
            end
          end
          if has_changes then
            MiniFiles.synchronize()
          end
        end,
      })
      require('mini.pick').setup()
      require('mini.colors').setup()
      require('mini.diff').setup()
      require('mini.test').setup {
        source = MiniDiff.gen_source.none(),
      }
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
