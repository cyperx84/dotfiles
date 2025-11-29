return {
  'epwalsh/obsidian.nvim',
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
          path = vim.fn.expand '~/Library/Mobile Documents/iCloud~md~obsidian/Documents/newvault',
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

      -- Frontmatter aligned with vault constitution
      note_frontmatter_func = function(note)
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

      -- Enable frontmatter for all vaults in Documents folder
      disable_frontmatter = function(filename)
        local documents_path = vim.fn.expand '~/Library/Mobile Documents/iCloud~md~obsidian/Documents'
        local absolute_filename = vim.fn.fnamemodify(filename, ':p')
        -- Enable frontmatter for files in Documents (applies to all vaults: notes, newvault, etc.)
        if absolute_filename:match('^' .. vim.pesc(documents_path)) then
          return false
        end
        return true
      end,

      -- Attachments
      attachments = {
        img_folder = 'assets/imgs',
        img_text_func = function(client, path)
          path = client:vault_relative_path(path) or path
          return string.format('![%s](%s)', path.name, path)
        end,
      },

      preferred_link_style = 'wiki',
      wiki_link_func = 'use_alias_only',

      -- Open URLs in browser
      follow_url_func = function(url)
        vim.fn.jobstart({ 'open', url }, { detach = true })
      end,

      -- Essential keymaps
      mappings = {
        -- Override 'gf' to work on markdown/wiki links
        ['gf'] = {
          action = function()
            return require('obsidian').util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle checkboxes
        ['<leader>ch'] = {
          action = function()
            return require('obsidian').util.toggle_checkbox()
          end,
          opts = { buffer = true, desc = 'Toggle [Ch]eckbox' },
        },
        -- Smart action (context-aware: follow link or toggle checkbox)
        ['<cr>'] = {
          action = function()
            return require('obsidian').util.smart_action()
          end,
          opts = { buffer = true, expr = true, desc = 'Smart action' },
        },
      },

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
          { 'n', '<leader>on', ':ObsidianNew<CR>', '[O]bsidian [N]ew note' },
          { 'n', '<leader>oo', ':ObsidianOpen<CR>', '[O]bsidian [O]pen in app' },
          { 'n', '<leader>of', ':ObsidianQuickSwitch<CR>', '[O]bsidian [F]ind note' },

          -- Search operations (using built-in commands)
          { 'n', '<leader>os', ':ObsidianSearch<CR>', '[O]bsidian [S]earch' },
          { 'n', '<leader>ob', ':ObsidianBacklinks<CR>', '[O]bsidian [B]acklinks' },
          { 'n', '<leader>ol', ':ObsidianLinks<CR>', '[O]bsidian [L]inks' },
          { 'n', '<leader>ot', ':ObsidianTags<CR>', '[O]bsidian [T]ags' },

          -- Daily notes
          { 'n', '<leader>od', ':ObsidianToday<CR>', '[O]bsidian [D]aily note' },
          { 'n', '<leader>oy', ':ObsidianYesterday<CR>', '[O]bsidian [Y]esterday' },
          { 'n', '<leader>om', ':ObsidianTomorrow<CR>', '[O]bsidian To[m]orrow' },

          -- Link operations
          { 'n', '<leader>oF', ':ObsidianFollowLink<CR>', '[O]bsidian [F]ollow link' },

          -- Utility
          { 'n', '<leader>oi', ':ObsidianPasteImg<CR>', '[O]bsidian Paste [I]mage' },
          { 'n', '<leader>or', function()
            vim.ui.input({ prompt = 'New note name: ' }, function(new_name)
              if not new_name or new_name == '' then return end

              local bufnr = vim.api.nvim_get_current_buf()
              local current_file = vim.api.nvim_buf_get_name(bufnr)
              local current_dir = vim.fn.fnamemodify(current_file, ':h')
              local new_path = current_dir .. '/' .. new_name .. '.md'

              vim.cmd 'w'
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

              -- Write new file, verify it exists before deleting old
              vim.fn.writefile(lines, new_path)
              if vim.fn.filereadable(new_path) == 0 then
                vim.notify('Error: Failed to create new file', vim.log.levels.ERROR)
                return
              end

              vim.fn.delete(current_file)
              vim.cmd('edit ' .. vim.fn.fnameescape(new_path))
              vim.notify('Renamed to: ' .. new_name, vim.log.levels.INFO)
            end)
          end, '[O]bsidian [R]ename' },
          { 'n', '<leader>ow', ':ObsidianWorkspace<CR>', '[O]bsidian Switch [W]orkspace' },
          { 'n', '<leader>ox', ':ObsidianTOC<CR>', '[O]bsidian Table of Contents' },
        }

        -- Visual mode keymaps
        local visual_keymaps = {
          { 'v', '<leader>oe', ':ObsidianExtractNote<CR>', '[O]bsidian [E]xtract note' },
          { 'v', '<leader>oL', ':ObsidianLink<CR>', '[O]bsidian [L]ink selection' },
          { 'v', '<leader>oln', ':ObsidianLinkNew<CR>', '[O]bsidian [L]ink [N]ew' },
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
