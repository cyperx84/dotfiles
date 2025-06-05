return {
  "coder/claudecode.nvim",
  dependencies = {
    "folke/snacks.nvim", -- Optional for enhanced terminal
  },
  opts = {
    -- Server options
    port_range = { min = 10000, max = 65535 },
    auto_start = true,
    log_level = "info",

    -- Terminal options
    terminal = {
      split_side = "left", -- or "right"
      split_width_percentage = 0.3,
      provider = "native", -- or "snacks"
    },

    -- Diff options
    diff_opts = {
      auto_close_on_accept = true,
      vertical_split = true,
    },
  },
  config = function()
    require("claudecode").setup()
    
    local managed_claude_buffer_id = nil 
    
    local function is_valid_claude_buffer(buf_id)
        if not buf_id or not vim.api.nvim_buf_is_valid(buf_id) then return false end
        if vim.bo[buf_id].buftype ~= "terminal" then return false end
        local name = vim.api.nvim_buf_get_name(buf_id)
        return name:match("term://.*claude") or name:match("ClaudeCode") or name:match("claudecode")
    end

    local function get_managed_claude_buffer()
      if is_valid_claude_buffer(managed_claude_buffer_id) then
        return managed_claude_buffer_id
      end
      
      managed_claude_buffer_id = nil -- Clear if invalid

      -- Fallback: Scan for the most recent existing Claude buffer and adopt it
      local bufs = vim.api.nvim_list_bufs()
      for i = #bufs, 1, -1 do 
        local buf = bufs[i]
        if is_valid_claude_buffer(buf) then
          managed_claude_buffer_id = buf -- Adopt it
          return managed_claude_buffer_id
        end
      end
      return nil -- No managed or existing Claude buffer found
    end
    
    local function find_all_claude_windows_info()
      local windows_info = {}
      for _, win_id in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_is_valid(win_id) then
          local buf_in_win = vim.api.nvim_win_get_buf(win_id)
          if is_valid_claude_buffer(buf_in_win) then -- Use the checker
            table.insert(windows_info, { win_id = win_id, buf_id = buf_in_win })
          end
        end
      end
      return windows_info
    end
    
    -- TermOpen Autocommand: Set managed_claude_buffer_id only if not already managing a valid one.
    vim.api.nvim_create_autocmd({"TermOpen"}, {
      pattern = "*",
      group = vim.api.nvim_create_augroup("ClaudeCodeManager", { clear = true }),
      callback = function(args)
        if is_valid_claude_buffer(args.buf) then
            -- Only set if we don't have a valid managed one, making it "sticky"
            if not is_valid_claude_buffer(managed_claude_buffer_id) then
                managed_claude_buffer_id = args.buf
            end
        end
      end,
    })

    local function claude_toggle()
      local target_buf_id = get_managed_claude_buffer()
      local visible_target_win_id = nil

      if target_buf_id then
          for _, win_info in ipairs(find_all_claude_windows_info()) do
              if win_info.buf_id == target_buf_id then
                  visible_target_win_id = win_info.win_id
                  break
              end
          end
      end
      
      if visible_target_win_id then
        local current_win_before_close = vim.api.nvim_get_current_win()
        pcall(vim.api.nvim_win_close, visible_target_win_id, false)
        if vim.api.nvim_win_is_valid(current_win_before_close) and current_win_before_close ~= visible_target_win_id then
          vim.api.nvim_set_current_win(current_win_before_close)
        end
      elseif target_buf_id then
        vim.cmd("vsplit")
        local new_win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_buf(new_win, target_buf_id)
        local width = math.floor(vim.o.columns * 0.3)
        vim.api.nvim_win_set_width(new_win, width)
        vim.api.nvim_set_current_win(new_win)
        vim.cmd("stopinsert")
      else
        vim.cmd("ClaudeCodeOpen") -- TermOpen should set managed_claude_buffer_id
        vim.defer_fn(function()
          local new_opened_buf_id = get_managed_claude_buffer() 
          if new_opened_buf_id then
            for _, win_info in ipairs(find_all_claude_windows_info()) do
                if win_info.buf_id == new_opened_buf_id then
                    vim.api.nvim_set_current_win(win_info.win_id)
                    vim.cmd("stopinsert")
                    break
                end
            end
          end
        end, 300) -- Increased delay for ClaudeCodeOpen to fully initialize
      end
    end
    
    local function claude_send_smart()
        local original_win_id = vim.api.nvim_get_current_win()
        local mode_was_visual = vim.fn.mode():find("[vV]") ~= nil

        if mode_was_visual then
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), 'nx', false)
        end

        local function core_send_and_cleanup_logic(claude_buf_intended_for_code)
            if not vim.api.nvim_win_is_valid(original_win_id) then return end
            vim.api.nvim_set_current_win(original_win_id)

            if mode_was_visual then
                vim.cmd("normal! gv") 
            end
            
            vim.cmd("ClaudeCodeSend") 

            vim.defer_fn(function() 
                local all_c_wins_info = find_all_claude_windows_info()
                if #all_c_wins_info == 0 then
                    if vim.api.nvim_win_is_valid(original_win_id) then vim.api.nvim_set_current_win(original_win_id) end
                    return
                end

                local final_target_buf_id_to_keep = nil
                local final_win_id_to_keep = nil

                -- Priority 1: The buffer we intended the code for, if it's still valid and in a window
                if is_valid_claude_buffer(claude_buf_intended_for_code) then
                    for _, win_info in ipairs(all_c_wins_info) do
                        if win_info.buf_id == claude_buf_intended_for_code then
                            final_target_buf_id_to_keep = claude_buf_intended_for_code
                            final_win_id_to_keep = win_info.win_id
                            break
                        end
                    end
                end

                -- Priority 2: If intended buffer not found (or became invalid), use current globally managed one
                if not final_win_id_to_keep then
                    local current_managed_buf = get_managed_claude_buffer() -- TermOpen might have updated this
                    if current_managed_buf then
                         for _, win_info in ipairs(all_c_wins_info) do
                            if win_info.buf_id == current_managed_buf then
                                final_target_buf_id_to_keep = current_managed_buf
                                final_win_id_to_keep = win_info.win_id
                                break
                            end
                        end
                    end
                end
                
                -- Priority 3: Absolute fallback
                if not final_win_id_to_keep and #all_c_wins_info > 0 then
                    final_win_id_to_keep = all_c_wins_info[1].win_id
                    final_target_buf_id_to_keep = all_c_wins_info[1].buf_id
                end

                if not final_win_id_to_keep then
                     if vim.api.nvim_win_is_valid(original_win_id) then vim.api.nvim_set_current_win(original_win_id) end
                     return
                end

                for _, win_info in ipairs(all_c_wins_info) do
                    if win_info.win_id ~= final_win_id_to_keep then
                        pcall(vim.api.nvim_win_close, win_info.win_id, false)
                    end
                end
                
                if vim.api.nvim_win_is_valid(final_win_id_to_keep) then
                    if vim.api.nvim_win_get_buf(final_win_id_to_keep) ~= final_target_buf_id_to_keep then
                         pcall(vim.api.nvim_win_set_buf, final_win_id_to_keep, final_target_buf_id_to_keep)
                    end
                    vim.api.nvim_set_current_win(final_win_id_to_keep)
                    vim.cmd("stopinsert")
                else
                    if vim.api.nvim_win_is_valid(original_win_id) then vim.api.nvim_set_current_win(original_win_id) end
                end
            end, 450)
        end

        vim.schedule(function() 
            local claude_buf_for_visibility_check = get_managed_claude_buffer()
            local claude_is_visible = false
            if claude_buf_for_visibility_check then
                for _, win_info in ipairs(find_all_claude_windows_info()) do
                    if win_info.buf_id == claude_buf_for_visibility_check then
                        claude_is_visible = true
                        break
                    end
                end
            end

            if claude_is_visible then
                core_send_and_cleanup_logic(claude_buf_for_visibility_check)
            else
                local buf_to_open = get_managed_claude_buffer()
                if buf_to_open then
                    vim.cmd("vsplit")
                    local new_win = vim.api.nvim_get_current_win()
                    vim.api.nvim_win_set_buf(new_win, buf_to_open)
                    local width = math.floor(vim.o.columns * 0.3)
                    vim.api.nvim_win_set_width(new_win, width)
                else
                    vim.cmd("ClaudeCodeOpen")
                end
                vim.defer_fn(function()
                    -- After opening, the buffer that should receive code is the newly managed one
                    local newly_managed_buf = get_managed_claude_buffer()
                    core_send_and_cleanup_logic(newly_managed_buf)
                end, 350) -- Increased delay for opening actions
            end
        end)
    end
    
    _G.claude_toggle = claude_toggle
    _G.claude_send_smart = claude_send_smart
  end,
  keys = {
    { "<c-M-j>", function() _G.claude_toggle() end, desc = "Toggle Claude Window" },
    { "<leader>cs", function() _G.claude_send_smart() end, mode = "v", desc = "Send to Claude" },
    { "<leader>co", "<cmd>ClaudeCodeOpen<cr>", desc = "Open Claude" },
    { "<leader>cx", "<cmd>ClaudeCodeClose<cr>", desc = "Close Claude" },
  },
}


