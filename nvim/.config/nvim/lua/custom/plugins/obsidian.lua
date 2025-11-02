-- Obsidian.nvim configuration
-- Aligned with VAULT-CONSTITUTION.md principles:
--   • Universal frontmatter: id, title, created, modified, reviewed, tags, aliases, base
--   • Minimal structure: _inbox, _ai, _projects, _knowledge, _bases, _archive, _settings
--   • Links are primary, wiki-style for bi-directional connections
--   • Tag system: #type/, #status/, #project/, #area/
--   • Neovim as primary interface with comprehensive keymaps

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
      workspaces = {
        {
          name = 'personal',
          path = vim.fn.expand '~/Library/Mobile Documents/iCloud~md~obsidian/Documents/notes',
        },
      },

      -- Daily notes configuration (aligned with vault constitution)
      daily_notes = {
        folder = '_inbox', -- Constitution: Single entry point for new information
        date_format = '%Y-%m-%d',
        alias_format = '%B %-d, %Y',
        -- Constitution tag system: #type/ #status/ #project/ #area/
        default_tags = { 'type/fleeting-note' }, -- Daily captures start as fleeting notes
        template = nil, -- Set to template name if you create one
      },

      -- Completion settings
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },

      -- New notes location (constitution: all notes live in root)
      new_notes_location = 'current_dir', -- Notes go to root/current directory

      -- Note ID function - creates URL-friendly slugs
      note_id_func = function(title)
        if title == nil or title == '' then
          return tostring(os.time()) -- fallback to timestamp
        end
        local slug = title
          :gsub('^%s*(.-)%s*$', '%1') -- trim whitespace
          :gsub('%s+', '-') -- spaces → dashes
          :gsub('[^%w%-]', '') -- strip punctuation/symbols
        return slug
      end,

      -- Note path function - organize notes by creation date (optional)
      -- Uncomment to organize notes into year/month folders
      -- note_path_func = function(spec)
      --   local path = spec.dir / os.date('%Y/%m') / tostring(spec.id)
      --   return path:with_suffix('.md')
      -- end,

      -- Enhanced frontmatter aligned with vault constitution
      note_frontmatter_func = function(note)
        -- Get current timestamp
        local now = os.date '%Y-%m-%d %H:%M'

        -- Preserve existing created date or use current time for new notes
        local created_date = (note.metadata and note.metadata.created) or now

        -- NOTE: Tags should NOT have hashtag prefix in frontmatter
        -- The obsidian.nvim plugin expects tags in YAML format without '#'
        -- YAML format (correct for tag search):
        --   tags: [type/fleeting-note, status/active]
        -- NOT hashtag format (breaks tag filtering):
        --   tags: [#type/fleeting-note, #status/active]

        local out = {
          id = note.id,
          title = note.title or '',
          created = created_date,        -- Preserve original or set once
          modified = now,                 -- Always update to current time
          reviewed = nil,                 -- Last review date (weekly gardening ritual)
          tags = note.tags or {},         -- Tags without hashtag prefix
          aliases = note.aliases or {},
          base = nil,                     -- Which Obsidian Base context this belongs to
        }

        -- Preserve other existing metadata (but not created/modified)
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            if k ~= 'created' and k ~= 'modified' then
              out[k] = v
            end
          end
        end

        return out
      end,

      -- Disable frontmatter for files outside the vault
      disable_frontmatter = function(filename)
        local vault_path = vim.fn.expand '~/Library/Mobile Documents/iCloud~md~obsidian/Documents/notes'
        local absolute_filename = vim.fn.fnamemodify(filename, ':p')

        -- Only apply frontmatter to files within the vault
        if not absolute_filename:match('^' .. vim.pesc(vault_path)) then
          return true -- disable frontmatter
        end

        return false -- enable frontmatter
      end,

      -- Attachments (images, files) - Constitution doesn't specify, keeping sensible default
      attachments = {
        img_folder = 'assets/imgs',
        ---@param client obsidian.Client
        ---@param path obsidian.Path
        ---@return string
        img_text_func = function(client, path)
          path = client:vault_relative_path(path) or path
          return string.format('![%s](%s)', path.name, path)
        end,
      },

      -- Link style preferences (constitution: "Links are primary")
      preferred_link_style = 'wiki', -- Wiki-style links for bi-directional linking
      wiki_link_func = 'use_alias_only', -- Use aliases for cleaner link text

      -- Open URLs in browser
      follow_url_func = function(url)
        vim.fn.jobstart({ 'open', url }, { detach = true })
      end,

      -- Enhanced keymaps
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

    -- Enhanced autocmd for markdown files
    -- Constitution: "Neovim primary interface" - comprehensive keymaps below
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function()
        -- Auto-reload settings for external changes (e.g., from Obsidian app)
        vim.opt_local.autoread = true

        -- Conceal settings
        vim.opt_local.conceallevel = 2
        vim.opt_local.concealcursor = 'nc'

        -- Obsidian command keymaps (aligned with constitution workflow)
        local opts = { buffer = true }

        -- Checkbox operations
        vim.keymap.set('n', '<leader>oc', function()
          return require('obsidian').util.toggle_checkbox()
        end, vim.tbl_extend('force', opts, { desc = '[O]bsidian Toggle [C]heckbox' }))
        vim.keymap.set('v', '<leader>oc', function()
          -- Get current visual selection (works while in visual mode)
          local start_line = vim.fn.line("v")
          local end_line = vim.fn.line(".")

          -- Ensure start is before end
          if start_line > end_line then
            start_line, end_line = end_line, start_line
          end

          -- Exit visual mode
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), 'x', false)

          -- Process each line
          for line = start_line, end_line do
            vim.api.nvim_win_set_cursor(0, {line, 0})
            require('obsidian').util.toggle_checkbox()
          end
        end, vim.tbl_extend('force', opts, { desc = '[O]bsidian Toggle [C]heckbox (Visual)' }))

        -- Table-driven keymap definitions
        local keymaps = {
          -- Note operations
          { 'n', '<leader>on', ':ObsidianNew<CR>', '[O]bsidian [N]ew note' },
          { 'n', '<leader>oo', ':ObsidianOpen<CR>', '[O]bsidian [O]pen in app' },
          { 'n', '<leader>of', ':ObsidianQuickSwitch<CR>', '[O]bsidian [Q]uick switch' },

          -- Search operations
          { 'n', '<leader>os', ':ObsidianSearch<CR>', '[O]bsidian [S]earch' },
          { 'n', '<leader>ob', ':ObsidianBacklinks<CR>', '[O]bsidian [B]acklinks' },
          { 'n', '<leader>ol', ':ObsidianLinks<CR>', '[O]bsidian [L]inks' },
          { 'n', '<leader>ot', ':ObsidianTags<CR>', '[O]bsidian [T]ags' },

          -- Daily notes
          { 'n', '<leader>od', ':ObsidianToday<CR>', '[O]bsidian Today ([D]aily)' },
          { 'n', '<leader>oy', ':ObsidianYesterday<CR>', '[O]bsidian [Y]esterday' },
          { 'n', '<leader>om', ':ObsidianTomorrow<CR>', '[O]bsidian To[m]orrow' },

          -- Link operations (normal mode)
          { 'n', '<leader>oF', ':ObsidianFollowLink<CR>', '[O]bsidian [F]ollow link' },

          -- Utility
          { 'n', '<leader>oi', ':ObsidianPasteImg<CR>', '[O]bsidian Paste [I]mage' },
          { 'n', '<leader>or', '<cmd>ObsidianRename<CR>', '[O]bsidian [R]ename' },
          { 'n', '<leader>ow', ':ObsidianWorkspace<CR>', '[O]bsidian [W]orkspace' },
          { 'n', '<leader>ox', ':ObsidianTOC<CR>', '[O]bsidian Table of Contents' },
        }

        -- Visual mode keymaps
        local visual_keymaps = {
          { 'v', '<leader>oe', ':ObsidianExtractNote<CR>', '[O]bsidian [E]xtract note' },
          { 'v', '<leader>oL', ':ObsidianLink<CR>', '[O]bsidian [L]ink selection' },
          { 'v', '<leader>oln', ':ObsidianLinkNew<CR>', '[O]bsidian [L]ink [N]ew' },
        }

        -- Set all keymaps using iteration
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
    -- Triggers on focus gain, buffer enter, and cursor hold
    vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold' }, {
      pattern = '*.md',
      callback = function()
        if vim.fn.mode() ~= 'c' then -- Don't reload in command mode
          vim.cmd('checktime')
        end
      end,
      desc = 'Auto-reload markdown files when changed externally',
    })
  end,
}
