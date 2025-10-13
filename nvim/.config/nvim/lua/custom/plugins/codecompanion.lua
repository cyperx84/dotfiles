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
          -- Display options
          intro_message = 'Welcome to CodeCompanion ✨! Press ? for options',
          show_settings = false, -- Show LLM settings at top of chat buffer (YAML block)
          show_token_count = true, -- Show token count for each response
          show_context = true, -- Show context from slash commands and variables
          show_header_separator = true, -- Useful if using external markdown plugin
          start_in_insert_mode = false, -- Open chat buffer in insert mode

          -- Chat window configuration
          window = {
            layout = 'vertical',
            position = 'left',
            border = 'single',
            -- Fixed dimensions (plain numbers in columns/lines)
            height = 50, -- Fixed: 50 lines
            width = 60, -- Fixed: 80 columns
            relative = 'editor',
            full_height = false, -- Use vsplit instead of botright/topleft vsplit
            sticky = false, -- Keep chat open when switching tabs
          },

          -- Debug window (opened with 'gd' in chat buffer)
          debug_window = {
            width = vim.o.columns - 5,
            height = vim.o.lines - 2,
          },

          -- Floating child windows (for diffs, messages, permissions)
          child_window = {
            width = vim.o.columns - 5,
            height = vim.o.lines - 2,
            row = 'center',
            col = 'center',
            relative = 'editor',
          },

          -- Diff window (takes precedence over child_window)
          diff_window = {
            width = function()
              return math.min(120, vim.o.columns - 10)
            end,
            height = function()
              return vim.o.lines - 4
            end,
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
                model = { default = 'gpt-4o-mini' },
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
                model = { default = 'gemini-2.0-flash-exp' },
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
