return {
  'ThePrimeagen/git-worktree.nvim',
  config = function()
    require("git-worktree").setup({
      change_directory_command = "cd",    -- default: "cd"
      update_on_change = true,           -- default: true
      update_on_change_command = "e .",  -- default: "e ."
      clearjumps_on_change = true,       -- default: true
      autopush = false,                  -- default: false
    })
  end
}

