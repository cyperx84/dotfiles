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
      opts = {
        log_level = 'INFO', -- Use 'DEBUG' or 'TRACE' for troubleshooting
      },
      display = {
        chat = {
          window = {
            layout = 'vertical',
            position = 'left',
            border = 'single',
            height = 0.7, -- Optimized height for better screen usage
            width = 0.35, -- Optimized width for better balance
            relative = 'editor',
            full_height = false, -- Use full height of the editor
          },
        },
        action_palette = {
          width = 75,
          height = 10,
          prompt = 'Prompt', -- Prompt used for interactive LLM calls
          provider = 'snacks', -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
          opts = {
            show_default_actions = true, -- Show the default actions in the action palette?
            show_default_prompt_library = true, -- Show the default prompt library in the action palette?
          },
        },
      },
      adapters = {
        http = {
          openai = function()
            return require('codecompanion.adapters').extend('openai', {
              env = {
                api_key = 'cmd:pass show apis/OPENAI_API_KEY',
              },
              schema = {
                model = { default = 'gpt-4o-mini' }, -- Updated to latest model
              },
            })
          end,

          anthropic = function()
            return require('codecompanion.adapters').extend('anthropic', {
              env = {
                api_key = 'cmd:pass show apis/ANTHROPIC_API_KEY',
              },
              schema = {
                model = { default = 'claude-3-5-sonnet-20241022' }, -- Updated to latest stable model
              },
            })
          end,

          gemini = function()
            return require('codecompanion.adapters').extend('gemini', {
              env = {
                api_key = 'cmd:pass show apis/GEMINI_API_KEY',
              },
              schema = {
                model = { default = 'gemini-2.0-flash-exp' }, -- Updated to latest model
              },
            })
          end,

          deepseek = function()
            return require('codecompanion.adapters').extend('deepseek', {
              env = {
                api_key = 'cmd:pass show apis/DEEPSEEK_API_KEY',
              },
              schema = {
                model = { default = 'deepseek-reasoner' },
              },
            })
          end,
        },

      },

      strategies = {
        chat = {
          adapter = 'deepseek', -- Switch to Anthropic for better performance
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
        inline = { adapter = 'deepseek' }, -- Updated for consistency
        cmd = { adapter = 'deepseek' }, -- Updated for consistency
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
