return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup {
      default_file_explorer = true,
      columns = {
        'icon',
        -- "permissions",
        -- "size",
        -- "mtime",
      },
      -- Buffer-local options to use for oil buffers
      buf_options = {
        buflisted = false,
        bufhidden = 'hide',
      },
      -- Window-local options to use for oil buffers
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      skip_confirm_for_actions = true,
      confirm_on_delete = false,
      -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
      -- (:help prompt_save_on_select_new_entry)
      prompt_save_on_select_new_entry = false,
      -- Oil will automatically delete hidden buffers after this delay
      -- You can set the delay to false to disable cleanup entirely
      -- Note that the cleanup process only starts when none of the oil buffers are currently displayed
      cleanup_delay_ms = 2000,
      lsp_file_methods = {
        -- Enable or disable LSP file operations
        enabled = true,
        -- Time to wait for LSP file operations to complete before skipping
        timeout_ms = 1000,
        -- Set to true to autosave buffers that are updated with LSP willRenameFiles
        -- Set to "unmodified" to only save unmodified buffers
        autosave_changes = true,
      },
      -- Constrain the cursor to the editable parts of the oil buffer
      -- Set to `false` to disable, or "name" to keep it on the file names
      constrain_cursor = 'editable',
      -- Set to true to watch the filesystem for changes and reload oil
      watch_for_changes = true,
      -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
      -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
      -- Additionally, if it is a string that matches "actions.<name>",
      -- it will use the mapping at require("oil.actions").<name>
      -- Set to `false` to remove a keymap
      -- See :help oil-actions for a list of all available actions
      keymaps = {
        ['g?'] = { 'actions.show_help', mode = 'n' },
        ['<CR>'] = 'actions.select',
        ['<C-s>'] = { 'actions.select', opts = { vertical = true } },
        ['<C-h>'] = { 'actions.select', opts = { horizontal = true } },
        ['<C-t>'] = { 'actions.select', opts = { tab = true } },
        ['<C-p>'] = 'actions.preview',
        ['<C-c>'] = { 'actions.close', mode = 'n' },
        ['<C-l>'] = 'actions.refresh',
        ['-'] = { 'actions.parent', mode = 'n' },
        ['_'] = { 'actions.open_cwd', mode = 'n' },
        ['`'] = { 'actions.cd', mode = 'n' },
        ['~'] = { 'actions.cd', opts = { scope = 'tab' }, mode = 'n' },
        ['gs'] = { 'actions.change_sort', mode = 'n' },
        ['gx'] = 'actions.open_external',
        ['g.'] = { 'actions.toggle_hidden', mode = 'n' },
        ['g\\'] = { 'actions.toggle_trash', mode = 'n' },
        ['<c-e>'] = 'actions.close',
        ['q'] = 'actions.close',
      },
      -- Set to false to disable all of the above keymaps
      use_default_keymaps = true,
      view_options = {
        show_hidden = true,
        natural_order = true,
        is_always_hidden = function(name, _)
          return name == '..' or name == '.git'
        end,
      },
      float = {
        -- padding = 1,
        max_width = 100,
        max_height = 25,
        border = 'rounded',
      },

      win_options = {
        wrap = true,
        -- winblend = 10,
        signcolumn = 'no',
        cursorcolumn = false,
        foldcolumn = '0',
        spell = false,
        list = false,
        conceallevel = 2,
        concealcursor = 'nvic',

      },
    }

    -- Orange border with transparent background
    vim.api.nvim_set_hl(0, 'FloatBorder', {
      fg = '#ff9e64',  -- Orange border color
      bg = 'NONE'      -- Transparent background
    })

    -- Global keybinds for toggling oil float
    vim.keymap.set('n', '<C-e>', function()
      require('oil').toggle_float()
    end, { desc = 'Toggle Oil float with cursor on current file' })
    vim.keymap.set('n', '<C-M-e>', function()
      require('oil').toggle_float(vim.fn.getcwd())
    end, { desc = 'Toggle Oil float at current working directory' })
  end,
}
