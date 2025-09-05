return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'olimorris/snacks.nvim',
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
          -- on_ready = function(hub) end,
          -- on_error = function(err) end,
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
      display = {
        chat = {
          window = {
            layout = 'vertical',
            position = 'left',
            border = 'single',
            height = 0.6, -- 60% of screen height (default is 0.8)
            width = 0.4, -- 30% of screen width (default is 0.45)
            relative = 'editor',
            full_height = false, -- Use full height of the editor
          },
        },
        action_palette = {
          width = 75,
          height = 10,
          prompt = 'Prompt', -- Prompt used for interactive LLM calls
          provider = 'default', -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
          opts = {
            show_default_actions = true, -- Show the default actions in the action palette?
            show_default_prompt_library = true, -- Show the default prompt library in the action palette?
          },
        },
      },
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

        deepseek = function()
          return require('codecompanion.adapters').extend('deepseek', {
            env = {
              api_key = 'cmd:pass show apis/DEEPSEEK_API_KEY',
            },
            schema = {
              model = { default = 'deepseek-chat' },
            },
          })
        end,

      },

      strategies = {
        chat = {
          adapter = 'deepseek',
          keymaps = {
            send = {
              modes = {
                i = { '<C-CR>', '<C-s>' },
              },
            },
            completion = {
              modes = {
                i = '<C-x>',
              },
            },
          },
          slash_commands = {
            ['buffer'] = {
              keymaps = {
                modes = {
                  i = '<C-b>',
                  v = '<C-b>',
                },
              },
            },
            ['fetch'] = {
              keymaps = {
                modes = {
                  i = '<C-f>',
                  v = '<C-f>',
                },
              },
            },
            ['help'] = {
              opts = {
                max_lines = 3000,
              },
            },
            ['image'] = {
              keymaps = {
                modes = {
                  v = '<C-i>',
                },
              },
              opts = {
                dirs = { '~/Documents/Screenshots' },
              },
            },
          },
        },
        inline = { adapter = 'deepseek' },
        cmd = { adapter = 'deepseek' },
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
