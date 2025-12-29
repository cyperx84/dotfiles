return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "OilActionsPost",
      callback = function(event)
        if event.data.actions.type == "move" then
          Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
        end
      end,
    })
  end,
  keys = {
    { "<leader>bd", function() Snacks.bufdelete() end,       desc = "Buffer delete",       mode = "n" },
    { "<leader>ba", function() Snacks.bufdelete.all() end,   desc = "Buffer delete all",   mode = "n" },
    { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Buffer delete other", mode = "n" },
    { "<leader>tz", function() Snacks.zen() end,             desc = "Toggle Zen Mode",     mode = "n" },
    { "<leader>tT", function() Snacks.terminal.toggle() end, desc = "Toggle Terminal",     mode = "n" },
  },
  opts = {
    bigfile = { enabled = true },
    picker = { enabled = false },  -- Disabled due to dimension validation issues - use Telescope instead
    image = {
      enabled = true,
      doc = {
        enabled = true,
        inline = true,
        max_width = 80,
        max_height = 40,
      },
      resolve = function(path, src)
        -- First try obsidian API resolution
        local ok, obsidian_api = pcall(require, "obsidian")
        if ok and obsidian_api.api and obsidian_api.api.path_is_note(path) then
          local resolved = obsidian_api.api.resolve_image_path(src)
          if resolved and vim.fn.filereadable(resolved) == 1 then
            return resolved
          end
        end

        -- Fallback: resolve relative to vault root
        local vault_root = vim.fn.expand('~/Library/Mobile Documents/iCloud~md~obsidian/Documents/notes')
        local fallback_path = vault_root .. '/' .. src
        if vim.fn.filereadable(fallback_path) == 1 then
          return fallback_path
        end

        -- Return original if nothing works
        return src
      end,
    },
    dashboard = {
      preset = {
        pick = nil,
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "s", desc = "Search Files", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          -- { icon = " ", key = "e", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        header = [[
          .o oOOOOOOOo                                            OOOo
          Ob.OOOOOOOo  OOOo.      oOOo.                      .adOOOOOOO
          OboO"""""""""""".OOo. .oOOOOOo.    OOOo.oOOOOOo.."""""""""'OO
          OOP.oOOOOOOOOOOO "POOOOOOOOOOOo.   `"OOOOOOOOOP,OOOOOOOOOOOB'
          `O'OOOO'     `OOOOo"OOOOOOOOOOO` .adOOOOOOOOO"oOOO'    `OOOOo
          .OOOO'            `OOOOOOOOOOOOOOOOOOOOOOOOOO'            `OO
          OOOOO                 '"OOOOOOOOOOOOOOOO"`                oOO
         oOOOOOba.                .adOOOOOOOOOOba               .adOOOOo.
        oOOOOOOOOOOOOOba.    .adOOOOOOOOOO@^OOOOOOOba.     .adOOOOOOOOOOOO
       OOOOOOOOOOOOOOOOO.OOOOOOOOOOOOOO"`  '"OOOOOOOOOOOOO.OOOOOOOOOOOOOO
       "OOOO"       "YKoOOOOnOOOSO1;'`  .   '"OOROAOPOEOOOoOY"     "OOO"
          Y           'OOOOOOOOOOOOOO: .oOOo. :OOOOOOOOOOO?'         :`
          :            .oO%OOOOOOOOOOo.OOOOOO.oOOOOOOOOOOOO?         .
          .            oOOP"%OOOOOOOOoOOOOOOO?oOOOOO?OOOO"OOo
                       '%o  OOOO"%OOOO%"%OOOOO"OOOOOO"OOO':
                            `$"  `OOOO' `O"Y ' `OOOO'  o             .
          .                  .     OP"          : o     .
                                    :
                                    .
                                                                             
               ████ ██████           █████      ██                     
              ███████████             █████                             
              █████████ ███████████████████ ███   ███████████   
             █████████  ███    █████████████ █████ ██████████████   
            █████████ ██████████ █████████ █████ █████ ████ █████   
          ███████████ ███    ███ █████████ █████ █████ ████ █████  
         ██████  █████████████████████ ████ █████ █████ ████ ██████ 
      ]],
      },
      sections = {
        { section = 'header' },
        {
          section = "keys",
          indent = 1,
          padding = 1,
        },
        { section = 'recent_files', icon = ' ', title = 'Recent Files', indent = 3, padding = 2 },
        { section = "startup" },
      },
    },
    explorer = { enabled = false },
    indent = { enabled = true },
    input = { enabled = false },
    notifier = { enabled = false },
    quickfile = { enabled = true },
    scope = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = false },
    rename = { enabled = true },
    zen = {
      enabled = true,
      toggles = {
        ufo             = true,
        dim             = true,
        git_signs       = false,
        diagnostics     = false,
        line_number     = false,
        relative_number = false,
        signcolumn      = "no",
        indent          = false
      }
    },
    terminal = {
      win = {
        style = "terminal",
        wo = {
          winhighlight = "Normal:Normal,NormalNC:Normal",
        },
      },
    },
  },
  config = function(_, opts)
    require("snacks").setup(opts)

    -- Explicitly setup image module
    if opts.image and opts.image.enabled then
      require("snacks").image.setup()
    end

    -- Make float window background transparent
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })

    Snacks.toggle.new({
      id = "ufo",
      name = "Enable/Disable ufo",
      get = function()
        return require("ufo").inspect()
      end,
      set = function(state)
        if state == nil then
          require("noice").enable()
          require("ufo").enable()
          vim.o.foldenable = true
          vim.o.foldcolumn = "1"
        else
          require("noice").disable()
          require("ufo").disable()
          vim.o.foldenable = false
          vim.o.foldcolumn = "0"
        end
      end,
    })
  end
}
