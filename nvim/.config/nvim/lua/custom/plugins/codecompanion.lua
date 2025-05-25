return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    {
      'ravitemer/mcphub.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
      build = 'npm install -g mcp-hub@latest',
      config = function()
        require('mcphub').setup {
          port = 37373,
          config = vim.fn.expand '~/.config/mcphub/servers.json',
          auto_approve = true,
          extensions = {
            codecompanion = {
              show_result_in_chat = true,
              make_vars = true,
              make_slash_commands = true,
            },
          },
          ui = {
            window = {
              width = 0.8,
              height = 0.8,
              border = 'rounded',
              relative = 'editor',
              zindex = 50,
            },
          },
          on_ready = function(hub) end,
          on_error = function(err) end,
          log = {
            level = vim.log.levels.WARN,
            to_file = false,
            file_path = nil,
            prefix = 'MCPHub',
          },
        }
      end,
    },
  },
  config = function()
    require('codecompanion').setup {
      adapters = {
        openai = function()
          return require('codecompanion.adapters').extend('openai', {
            env = {
              api_key = 'cmd:pass show apis/OPENAI_API_KEY',
            },
            schema = {
              model = { default = 'gpt-4o' },
            },
          })
        end,

        anthropic = function()
          return require('codecompanion.adapters').extend('anthropic', {
            env = {
              api_key = 'cmd:pass show apis/ANTHROPIC_API_KEY',
            },
            schema = {
              model = { default = 'claude-sonnet-4-20250514' },
            },
          })
        end,

        gemini = function()
          return require('codecompanion.adapters').extend('gemini', {
            env = {
              api_key = 'cmd:pass show apis/GEMINI_API_KEY',
            },
            schema = {
              model = { default = 'gemini-2.5-flash-preview-05-20' },
            },
          })
        end,

        -- deepseek = function()
        --   return require('codecompanion.adapters').extend('deepseek', {
        --         api_key = 'cmd:pass show apis/DEEPSEEK_API_KEY',
        --       api_key = os.getenv 'DEEPSEEK_API_KEY',
        --     },
        --     schema = {
        --       model = { default = 'deepseek-coder' },
        --     },
        --   })
        -- end,
      },

      strategies = {
        chat = { adapter = 'gemini' },
        inline = { adapter = 'gemini' },
        cmd = { adapter = 'gemini' },
      },
      extensions = {
        mcphub = {
          callback = 'mcphub.extensions.codecompanion',
          opts = {
            show_result_in_chat = true, -- Show mcp tool results in chat
            make_vars = true, -- Convert resources to #variables
            make_slash_commands = true, -- Add prompts as /slash commands
          },
        },
      },
    }
  end,
}
