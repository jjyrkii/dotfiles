-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Function to toggle line numbering
local function toggle_line_numbers()
  local bufname = vim.api.nvim_buf_get_name(0)
  local filetype = vim.bo.filetype

  if filetype == "netrw" or filetype == "neo-tree" or bufname:match("NvimTree") then
    vim.wo.number = false
    vim.wo.relativenumber = false
    return
  else
    local mode = vim.api.nvim_get_mode().mode

    -- Check if in normal mode (mode "n" for normal, "no" for operator-pending)
    if mode == "n" or mode == "no" then
      vim.wo.number = true
      vim.wo.relativenumber = true
    else
      vim.wo.number = true
      vim.wo.relativenumber = false
    end
  end
end

-- Autocommand that listens to mode changes and executes the function
vim.api.nvim_create_augroup("LineNumbers", { clear = true })
vim.api.nvim_create_autocmd({ "ModeChanged", "BufEnter" }, {
  group = "LineNumbers",
  callback = toggle_line_numbers,
})

-- Create an augroup named 'BladeFiletypeRelated'
vim.api.nvim_create_augroup("BladeFiletypeRelated", {})

-- Define the autocommand for BufNewFile and BufRead events
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.blade.php",
  command = "setlocal ft=blade.php",
  group = "BladeFiletypeRelated",
})
