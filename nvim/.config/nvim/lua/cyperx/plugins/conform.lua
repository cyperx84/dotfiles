return {
  { -- Autoformat
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { { 'prettierd', 'prettier' } },
        -- Conform can also run multiple formatters sequentially
        -- python = { 'isort', 'black' },
        python = function(bufnr)
          if require('conform').get_formatter_info('ruff_format', bufnr).available then
            return { 'ruff_format' }
          else
            return { 'isort', 'black' }
          end
        end,
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
