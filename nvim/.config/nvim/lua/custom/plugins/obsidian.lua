return {
  'obsidian-nvim/obsidian.nvim',
  version = '*',
  lazy = true,
  ft = 'markdown',
  -- No dependencies required for v3.13.0+

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
        {
          name = 'cyperx',
          path = vim.fn.expand '~/Library/Mobile Documents/iCloud~md~obsidian/Documents/cyperx',
        },
      },

      -- Daily notes (inbox folder per vault constitution)
      daily_notes = {
        folder = 'inbox',
        date_format = '%Y-%m-%d',
        alias_format = '%B %-d, %Y',
        default_tags = { 'daily-note' },
        template = 'daily.md',
      },

      -- Completion - use blink.cmp
      completion = {
        blink = true,
        min_chars = 2,
      },

      -- Notes location (constitution: all notes live in root)
      new_notes_location = 'current_dir',

      -- Templates configuration (per-vault templates/ folder)
      templates = {
        folder = 'templates',
        date_format = '%Y-%m-%d',
        time_format = '%H:%M',
      },

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

        func = function(note)
          local now = os.date '%Y-%m-%d %H:%M'
          local created_date = (note.metadata and note.metadata.created) or now

          local out = {
            id = note.id,
            title = note.title or '',
            created = created_date,
            modified = now,
            reviewed = (note.metadata and note.metadata.reviewed) or nil,
            tags = note.tags or {},
            topics = (note.metadata and note.metadata.topics) or {},
            refs = (note.metadata and note.metadata.refs) or {},
            aliases = note.aliases or {},
            base = (note.metadata and note.metadata.base) or nil,
          }

          -- Preserve additional custom metadata fields
          if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
            for k, v in pairs(note.metadata) do
              -- Skip fields we've already handled explicitly
              if not vim.tbl_contains({ 'created', 'modified', 'reviewed', 'topics', 'refs', 'base' }, k) then
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
        img_name_func = function()
          return os.date('%Y-%m-%d-%H%M%S')
        end,
        img_text_func = function(path)
          -- Use the same format that works: ![name](assets/imgs/filename.png)
          -- path.name is the filename without extension
          -- path.filename is the full path
          local filename = vim.fn.fnamemodify(path.filename, ':t')
          return string.format('![%s](assets/imgs/%s)', path.name, filename)
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

    -- ========================================================================
    -- MONKEY-PATCH: Fix tag picker data format issues
    -- Problem: Plugin expects entry.user_data as string, but Telescope returns
    --          {tag="x"} for existing tags or raw strings for new tags
    -- ========================================================================
    vim.schedule(function()
      local ok, mappings = pcall(require, 'obsidian.picker.mappings')
      if not ok then return end

      local orig_insert_tag = mappings.insert_tag
      local orig_tag_note = mappings.tag_note

      -- Normalize any entry format to {user_data = "tagname"}
      local function normalize(entry)
        if type(entry) == 'string' then
          return { user_data = entry }
        end
        if type(entry) == 'table' and entry.user_data then
          if type(entry.user_data) == 'table' and entry.user_data.tag then
            entry.user_data = entry.user_data.tag
          end
        end
        return entry
      end

      mappings.insert_tag = function(entry)
        return orig_insert_tag(normalize(entry))
      end

      mappings.tag_note = function(...)
        local entries = { ... }
        for i, entry in ipairs(entries) do
          entries[i] = normalize(entry)
        end

        -- Fix: Ensure calling_bufnr is valid (broken in fresh vaults with no tags)
        local picker = require('obsidian.picker')
        if not picker.state.calling_bufnr or not vim.api.nvim_buf_is_valid(picker.state.calling_bufnr) then
          -- Try alternate buffer first (the markdown file we came from)
          local alt_buf = vim.fn.bufnr('#')
          if alt_buf ~= -1 and vim.api.nvim_buf_is_valid(alt_buf) then
            picker.state.calling_bufnr = alt_buf
          else
            -- Fallback: find first markdown buffer
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].filetype == 'markdown' then
                picker.state.calling_bufnr = buf
                break
              end
            end
          end
        end

        return orig_tag_note(unpack(entries))
      end
    end)

    -- Markdown file autocmd for settings and keymaps
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function()
        -- Auto-reload settings for external changes
        vim.opt_local.autoread = true

        -- Conceal settings
        vim.opt_local.conceallevel = 2
        vim.opt_local.concealcursor = 'nc'

        -- Manually attach snacks image rendering with delay
        -- Need delay to ensure treesitter is fully loaded
        vim.defer_fn(function()
          local ok, snacks = pcall(require, 'snacks')
          if ok and snacks.image and snacks.image.doc then
            -- Force re-attach to catch markdown_inline images
            snacks.image.doc._attach(vim.api.nvim_get_current_buf())
          end
        end, 100) -- 100ms delay

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

          -- Template operations
          { 'n', '<leader>oT', ':Obsidian new_from_template<CR>', '[O]bsidian New from [T]emplate' },
          { 'n', '<leader>op', ':Obsidian template<CR>', '[O]bsidian Insert tem[P]late' },

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
