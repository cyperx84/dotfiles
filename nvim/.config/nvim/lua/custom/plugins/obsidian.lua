return {
  'obsidian-nvim/obsidian.nvim',
  version = '*',
  lazy = true,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('obsidian').setup {
      -- Workspace configuration
      workspaces = {
        {
          name = 'notes',
          path = vim.fn.expand '~/Library/Mobile Documents/iCloud~md~obsidian/Documents/notes',
        },
        {
          name = 'snowboarding',
          path = vim.fn.expand '~/Library/Mobile Documents/iCloud~md~obsidian/Documents/snowboarding',
        },
      },

      -- Daily notes (inbox folder per vault constitution)
      daily_notes = {
        folder = 'inbox',
        date_format = '%Y-%m-%d',
        alias_format = '%B %-d, %Y',
        default_tags = { 'daily-note' },
        template = nil,
      },

      -- Completion
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },

      -- Notes location (constitution: all notes live in root)
      new_notes_location = 'current_dir',

      -- Note ID function - creates URL-friendly slugs
      note_id_func = function(title)
        if title == nil or title == '' then
          return tostring(os.time())
        end
        local slug = title
          :gsub('^%s*(.-)%s*$', '%1') -- trim whitespace
          :gsub('%s+', '-') -- spaces → dashes
          :gsub('[^%w%-]', '') -- strip punctuation/symbols
        return slug
      end,

      -- Frontmatter configuration (new format)
      frontmatter = {
        -- Enable frontmatter for all vaults in Documents folder
        enabled = function(filename)
          local documents_path = vim.fn.expand '~/Library/Mobile Documents/iCloud~md~obsidian/Documents'
          local absolute_filename = vim.fn.fnamemodify(filename, ':p')
          -- Enable frontmatter for files in Documents (applies to all vaults: notes, newvault, etc.)
          if absolute_filename:match('^' .. vim.pesc(documents_path)) then
            return true
          end
          return false
        end,

        -- Custom frontmatter function aligned with vault constitution
        func = function(note)
          local now = os.date '%Y-%m-%d %H:%M'
          local created_date = (note.metadata and note.metadata.created) or now

          local out = {
            id = note.id,
            title = note.title or '',
            created = created_date,
            modified = now,
            reviewed = nil,
            tags = note.tags or {},
            aliases = note.aliases or {},
            base = nil,
          }

          -- Preserve other existing metadata
          if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
            for k, v in pairs(note.metadata) do
              if k ~= 'created' and k ~= 'modified' then
                out[k] = v
              end
            end
          end

          return out
        end,
      },

      -- Attachments
      attachments = {
        img_folder = 'assets/imgs',
        img_text_func = function(path)
          -- Path is already relative in new fork
          return string.format('![%s](%s)', path.name, path)
        end,
      },

      preferred_link_style = 'wiki',
      wiki_link_func = 'use_alias_only',

      -- Open URLs in browser
      follow_url_func = function(url)
        vim.fn.jobstart({ 'open', url }, { detach = true })
      end,

      -- Picker configuration
      picker = {
        name = 'telescope.nvim',
        note_mappings = {
          new = '<C-x>',
          insert_link = '<C-l>',
        },
        tag_mappings = {
          tag_note = '<C-x>',
          insert_tag = '<C-l>',
        },
        sort_by = 'modified',
        sort_reversed = true,
      },

      -- UI settings (disabled in favor of render-markdown.nvim)
      ui = {
        enable = false,
      },

      -- YAML parser
      yaml_parser = 'native',

      -- Disable legacy commands (use new :Obsidian xxx format)
      legacy_commands = false,
    }

    -- Markdown file autocmd for settings and keymaps
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function()
        -- Auto-reload settings for external changes
        vim.opt_local.autoread = true

        -- Conceal settings
        vim.opt_local.conceallevel = 2
        vim.opt_local.concealcursor = 'nc'

        -- Obsidian command keymaps
        local opts = { buffer = true }

        -- Override 'gf' to work on markdown/wiki links
        vim.keymap.set('n', 'gf', '<cmd>Obsidian follow_link<CR>', { buffer = true, desc = 'Follow link under cursor' })

        -- Toggle checkboxes
        vim.keymap.set('n', '<leader>ch', function()
          return require('obsidian').util.toggle_checkbox()
        end, vim.tbl_extend('force', opts, { desc = 'Toggle [Ch]eckbox' }))

        -- Smart action (context-aware: follow link or toggle checkbox)
        vim.keymap.set('n', '<cr>', function()
          return require('obsidian').util.smart_action()
        end, { buffer = true, expr = true, desc = 'Smart action' })

        -- Checkbox operations
        vim.keymap.set('n', '<leader>oc', function()
          return require('obsidian').util.toggle_checkbox()
        end, vim.tbl_extend('force', opts, { desc = '[O]bsidian Toggle [C]heckbox' }))

        -- Visual mode checkbox toggle
        vim.keymap.set('v', '<leader>oc', function()
          local start_line = vim.fn.line 'v'
          local end_line = vim.fn.line '.'
          if start_line > end_line then
            start_line, end_line = end_line, start_line
          end
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'x', false)
          for line = start_line, end_line do
            vim.api.nvim_win_set_cursor(0, { line, 0 })
            require('obsidian').util.toggle_checkbox()
          end
        end, vim.tbl_extend('force', opts, { desc = '[O]bsidian Toggle [C]heckbox (Visual)' }))

        -- Essential keymaps
        local keymaps = {
          -- Note operations
          { 'n', '<leader>on', ':Obsidian new<CR>', '[O]bsidian [N]ew note' },
          { 'n', '<leader>oo', ':Obsidian open<CR>', '[O]bsidian [O]pen in app' },
          { 'n', '<leader>of', ':Obsidian quick_switch<CR>', '[O]bsidian [F]ind note' },

          -- Search operations (using new commands)
          { 'n', '<leader>os', ':Obsidian search<CR>', '[O]bsidian [S]earch' },
          { 'n', '<leader>ob', ':Obsidian backlinks<CR>', '[O]bsidian [B]acklinks' },
          { 'n', '<leader>ol', ':Obsidian links<CR>', '[O]bsidian [L]inks' },
          { 'n', '<leader>ot', ':Obsidian tags<CR>', '[O]bsidian [T]ags' },

          -- Daily notes
          { 'n', '<leader>od', ':Obsidian today<CR>', '[O]bsidian [D]aily note' },
          { 'n', '<leader>oy', ':Obsidian yesterday<CR>', '[O]bsidian [Y]esterday' },
          { 'n', '<leader>om', ':Obsidian tomorrow<CR>', '[O]bsidian To[m]orrow' },

          -- Link operations
          { 'n', '<leader>oF', ':Obsidian follow_link<CR>', '[O]bsidian [F]ollow link' },

          -- Utility
          { 'n', '<leader>oi', ':Obsidian paste_img<CR>', '[O]bsidian Paste [I]mage' },
          { 'n', '<leader>or', function()
            vim.ui.input({ prompt = 'New note name: ' }, function(new_name)
              if not new_name or new_name == '' then return end

              local bufnr = vim.api.nvim_get_current_buf()
              local current_file = vim.api.nvim_buf_get_name(bufnr)
              local current_dir = vim.fn.fnamemodify(current_file, ':h')
              local new_path = current_dir .. '/' .. new_name .. '.md'

              -- Check if target file already exists (allow case-only renames on macOS)
              local is_case_only_rename = current_file:lower() == new_path:lower()
              if vim.fn.filereadable(new_path) == 1 and not is_case_only_rename then
                vim.notify('Error: File "' .. new_name .. '.md" already exists', vim.log.levels.ERROR)
                return
              end

              -- Save current file first
              local save_ok, save_err = pcall(vim.cmd, 'w')
              if not save_ok then
                vim.notify('Error: Failed to save current file: ' .. tostring(save_err), vim.log.levels.ERROR)
                return
              end

              local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

              -- Generate new ID
              local new_id = new_name:gsub('^%s*(.-)%s*$', '%1'):gsub('%s+', '-'):gsub('[^%w%-]', '')

              -- Update id and title in frontmatter
              for i = 1, #lines do
                if lines[i]:match '^id:' then
                  lines[i] = 'id: ' .. new_id
                elseif lines[i]:match '^title:' then
                  lines[i] = 'title: ' .. new_name
                end
              end

              -- Write updated frontmatter to current file
              local write_ok = pcall(vim.fn.writefile, lines, current_file)
              if not write_ok then
                vim.notify('Error: Failed to write file', vim.log.levels.ERROR)
                return
              end

              -- Rename file if needed
              if current_file ~= new_path then
                vim.fn.system('mv ' .. vim.fn.shellescape(current_file) .. ' ' .. vim.fn.shellescape(new_path))
              end

              -- Open the file (renamed or same)
              pcall(vim.cmd, 'edit ' .. vim.fn.fnameescape(new_path))
              vim.notify('Renamed to: ' .. new_name, vim.log.levels.INFO)
            end)
          end, '[O]bsidian [R]ename' },
          { 'n', '<leader>ow', ':Obsidian workspace<CR>', '[O]bsidian Switch [W]orkspace' },
          { 'n', '<leader>ox', ':Obsidian toc<CR>', '[O]bsidian Table of Contents' },
        }

        -- Visual mode keymaps
        local visual_keymaps = {
          { 'v', '<leader>oe', ':Obsidian extract_note<CR>', '[O]bsidian [E]xtract note' },
          { 'v', '<leader>oL', ':Obsidian link<CR>', '[O]bsidian [L]ink selection' },
          { 'v', '<leader>oln', ':Obsidian link_new<CR>', '[O]bsidian [L]ink [N]ew' },
        }

        -- Set all keymaps
        for _, keymap in ipairs(keymaps) do
          local mode, lhs, rhs, desc = unpack(keymap)
          vim.keymap.set(mode, lhs, rhs, vim.tbl_extend('force', opts, { desc = desc }))
        end

        for _, keymap in ipairs(visual_keymaps) do
          local mode, lhs, rhs, desc = unpack(keymap)
          vim.keymap.set(mode, lhs, rhs, vim.tbl_extend('force', opts, { desc = desc }))
        end
      end,
    })

    -- Auto-reload markdown files when changed externally
    vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold' }, {
      pattern = '*.md',
      callback = function()
        if vim.fn.mode() ~= 'c' then
          vim.cmd 'checktime'
        end
      end,
      desc = 'Auto-reload markdown files when changed externally',
    })
  end,
}
