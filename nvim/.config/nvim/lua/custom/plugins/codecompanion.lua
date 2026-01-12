---@diagnostic disable: undefined-global
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
              width = 100,
              height = 30,
              border = 'rounded',
              relative = 'editor',
              zindex = 50,
            },
          },
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
        log_level = 'DEBUG',
      },
      display = {
        chat = {
          intro_message = 'Welcome to CodeCompanion ✨! Press ? for options',
          show_settings =  true,
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
          debug_window = {
            width = vim.o.columns - 5,
            height = vim.o.lines - 2,
          },
          child_window = {
            width = vim.o.columns - 5,
            height = vim.o.lines - 2,
            row = 'center',
            col = 'center',
            relative = 'editor',
          },
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
          prompt = 'Prompt',
          provider = 'telescope',
          opts = {
            show_default_actions = true,
            show_default_prompt_library = true,
          },
        },
      },
      adapters = {
        http = {
          openai = function()
            return require('codecompanion.adapters').extend('openai', {
              env = {
                api_key = 'cmd:gopass show apis/OPENAI_API_KEY 2>/dev/null',
              },
              schema = {
                model = { default = 'gpt-4o-mini' },
              },
            })
          end,
          gemini = function()
            return require('codecompanion.adapters').extend('gemini', {
              env = {
                api_key = 'cmd:gopass show apis/GEMINI_API_KEY 2>/dev/null',
              },
              schema = {
                model = { default = 'gemini-2.0-flash-exp' },
              },
            })
          end,
          deepseek = function()
            return require('codecompanion.adapters').extend('deepseek', {
              env = {
                api_key = 'cmd:gopass show apis/DEEPSEEK_API_KEY 2>/dev/null',
              },
              schema = {
                model = { default = 'deepseek-chat' },
              },
            })
          end,
        },
        acp = {
          codex = function()
            return require('codecompanion.adapters').extend('codex', {
              defaults = {
                auth_method = 'openai-api-key',
              },
              env = {
                OPENAI_API_KEY = 'cmd:gopass show apis/OPENAI_API_KEY 2>/dev/null',
              },
            })
          end,
          gemini_cli = function()
            return require('codecompanion.adapters').extend('gemini_cli', {
              defaults = {
                auth_method = 'oauth-personal',
              },
              schema = {
                model = { default = 'gemini-3' },
              },
            })
          end,
        },
      },
      strategies = {
        chat = {
          adapter = 'gemini_cli',
          keymaps = {
            send = {
              modes = { n = '<CR>', i = '<C-s>' },
            },
            completion = {
              modes = { i = '<C-x>' },
            },
          },
          slash_commands = {
            opts = {
              provider = 'telescope',
            },
            ['buffer'] = {
              keymaps = {
                modes = {
                  i = '<C-b>',
                  v = '<C-b>',
                },
              },
              opts = {
                provider = 'telescope',
              },
            },
            ['file'] = {
              opts = {
                provider = 'telescope',
                contains_code = true,
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
                provider = 'telescope',
                max_lines = 3000,
              },
            },
            ['symbols'] = {
              opts = {
                provider = 'telescope',
              },
            },
            ['image'] = {
              keymaps = {
                modes = {
                  v = '<C-i>',
                },
              },
              opts = {
                provider = 'telescope',
                dirs = { '~/Documents/Screenshots' },
              },
            },
          },
          variables = {
            ['buffer'] = {
              opts = {
                default_params = 'watch',
              },
            },
          },
        },
        inline = { adapter = 'anthropic' },
        cmd = { adapter = 'anthropic' },
      },
    }
  end,
}
