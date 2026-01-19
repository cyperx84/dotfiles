---@diagnostic disable: undefined-global

local function http_adapter(name, model)
  return function()
    return require('codecompanion.adapters').extend(name, {
      env = { api_key = ('cmd:gopass show apis/%s_API_KEY 2>/dev/null'):format(name:upper()) },
      schema = { model = { default = model } },
    })
  end
end

-- Reusable window dimensions
local full_width = function() return vim.o.columns - 5 end
local full_height = function() return vim.o.lines - 2 end

return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'ravitemer/mcphub.nvim',
  },
  cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionActions' },
  keys = {
    { '<M-.>', '<cmd>CodeCompanionChat Toggle<CR>', desc = 'Code Companion Chat Toggle' },
    { '<leader>CC', '<cmd>CodeCompanionActions<CR>', desc = 'Code Companion Actions' },
    { '<leader>Cb', '<cmd>CodeCompanionChat Add<CR>', desc = 'Add Buffer to Chat' },
    { '<leader>Cs', '<cmd>CodeCompanionChat Add<CR>', mode = 'v', desc = 'Add Selection to Chat' },
  },

  config = function()
    require('codecompanion').setup {
      opts = {
        log_level = 'WARN',
        provider = 'telescope',
      },

      -- Disable automatic rules/context file loading (CLAUDE.md, AGENTS.md, etc.)
      rules = {
        opts = {
          show_presets = false,
          chat = {
            enabled = false,
          },
        },
      },

      display = {
        chat = {
          intro_message = 'Welcome to CodeCompanion! Press ? for options',
          show_settings = false,
          show_token_count = true,
          show_context = true,
          show_header_separator = true,
          start_in_insert_mode = false,
          window = {
            layout = 'vertical',
            position = 'left',
            border = 'single',
            height = 50,
            width = 60,
            relative = 'editor',
            full_height = false,
            sticky = false,
          },
          debug_window = { width = full_width, height = full_height },
          child_window = {
            width = full_width,
            height = full_height,
            row = 'center',
            col = 'center',
            relative = 'editor',
          },
          diff_window = {
            width = function() return math.min(120, vim.o.columns - 10) end,
            height = function() return vim.o.lines - 4 end,
          },
        },
        action_palette = {
          width = 75,
          height = 10,
          prompt = 'Prompt',
          opts = {
            show_default_actions = true,
            show_default_prompt_library = true,
          },
        },
      },

      adapters = {
        http = {
          openai = http_adapter('openai', 'gpt-4o-mini'),
          gemini = http_adapter('gemini', 'gemini-2.0-flash-exp'),
          deepseek = http_adapter('deepseek', 'deepseek-chat'),
        },
        acp = {
          codex = function()
            return require('codecompanion.adapters').extend('codex', {
              defaults = { auth_method = 'openai-api-key' },
              env = { OPENAI_API_KEY = 'cmd:gopass show apis/OPENAI_API_KEY 2>/dev/null' },
            })
          end,
          gemini_cli = function()
            return require('codecompanion.adapters').extend('gemini_cli', {
              defaults = { auth_method = 'oauth-personal' },
              schema = { model = { default = 'gemini-3' } },
            })
          end,
        },
      },

      strategies = {
        chat = {
          adapter = 'gemini_cli',
          roles = {
            user = 'Me',
            llm = 'CodeCompanion',
          },
          keymaps = {
            send = { modes = { n = '<CR>', i = '<C-s>' } },
            completion = { modes = { i = '<C-x>' } },
          },
          slash_commands = {
            buffer = { keymaps = { modes = { i = '<C-b>', v = '<C-b>' } } },
            file = { opts = { contains_code = true } },
            fetch = { keymaps = { modes = { i = '<C-f>', v = '<C-f>' } } },
            help = { opts = { max_lines = 3000 } },
            image = {
              keymaps = { modes = { v = '<C-i>' } },
              opts = { dirs = { '~/Documents/Screenshots' } },
            },
          },
          variables = {
            buffer = { opts = { default_params = 'watch' } },
          },
        },
        inline = { adapter = 'anthropic' },
        cmd = { adapter = 'anthropic' },
      },
    }
  end,
}
