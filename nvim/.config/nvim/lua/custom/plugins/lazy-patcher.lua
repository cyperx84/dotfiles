return {
  'one-d-wide/lazy-patcher.nvim',
  config = true,
  ft = 'lazy', -- Load when Lazy UI is opened
  opts = {
    patches_path = vim.fn.stdpath('config') .. '/patches',
    print_logs = true, -- Show logs when applying patches
  },
}
