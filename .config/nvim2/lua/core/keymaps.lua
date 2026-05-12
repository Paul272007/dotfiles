local map = vim.keymap.set

-- Disable page up and down keys when in insert mode
map("i", "<PageUp>", "<Nop>", { desc = "Disable PageUp" })
map("i", "<PageDown>", "<Nop>", { desc = "Disable PageDown" })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- LSP
map('n', '<leader>cd', vim.diagnostic.open_float, { desc = "Show line diagnostics" })

-- Clear search on esc
map({ "n" }, "<esc>", function()
  vim.cmd("noh")
end, { desc = "Clear search highlights" })

-- Append character at the end of the line
map("n", "<leader>a", function()
  local char = vim.fn.nr2char(vim.fn.getchar())
  if char:match("[%z\27]") then return end
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()
  vim.api.nvim_set_current_line(line .. char)
  vim.api.nvim_win_set_cursor(0, cursor)
end, { desc = "Append character at end of line" })

---- Buffers
-- move between buffers
map("n", "<PageDown>", ":bnext<CR>", { desc = "Switch to next buffer", noremap = true, silent = true })
map("n", "<PageUp>", ":bprev<CR>", { desc = "Switch to previous buffer", noremap = true, silent = true })
map("n", "<tab>", ":bnext<CR>", { desc = "Switch to next buffer", noremap = true, silent = true })
map("n", "<S-tab>", ":bprev<CR>", { desc = "Switch to previous buffer", noremap = true, silent = true })
-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

---- Terminal mode
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Quit terminal mode" })

---- ZC
map("n", "<leader>zc", ":w<CR>:term zc run %<CR>", { desc = "Compile and execute C/C++ file" })
map("n", "<leader>zq", ":w<CR>:term zc run -q %<CR>", { desc = "Compile and execute C/C++ file quietly" })

---- Neogen
map("n", "<leader>co", ":lua require('neogen').generate()<cr>", { desc = "Générer Doc (@brief)" })

---- Snacks
-- picker and buffers
map("n", "<leader><space>", function() Snacks.picker.smart() end, { desc = "Smart find files" })
map("n", "<leader>q", function() Snacks.bufdelete() end, { desc = "Delete current buffer" })
map("n", "<leader>,", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>:", function() Snacks.picker.command_history() end, { desc = "Command history" })
map("n", "<leader>n", function() Snacks.picker.notifications() end, { desc = "Notifications history" })
map("n", "<leader>e", function() Snacks.explorer({ layout = { layout = { position = "right" } }, }) end,
  { desc = "File Explorer" })

-- find
map("n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "Find project" })
map("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent" })
map("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Find file" })
map("n", "<leader>fg", function() Snacks.picker.git_files() end, { desc = "Find git file" })
map("n", "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,
  { desc = "Find config file" })

-- git
map("n", "<leader>gb", function() Snacks.picker.git_branches() end, { desc = "Git branches" })
map("n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "Git log" })
map("n", "<leader>gL", function() Snacks.picker.git_log_line() end, { desc = "Git log line" })
map("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git status" })
map("n", "<leader>gS", function() Snacks.picker.git_stash() end, { desc = "Git stash" })
map("n", "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "Git diff (hunks)" })
map("n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git log file" })
map("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "Lazygit" })

-- TODO : gh

-- grep / search
map("n", "<leader>/", function() Snacks.picker.grep() end, { desc = "Grep in workspace" })
map("n", "<leader>sb", function() Snacks.picker.lines() end, { desc = "Grep buffer lines" })
map("n", "<leader>sB", function() Snacks.picker.grep_buffers() end, { desc = "Grep lines in open buffers" })
map({ "n", "x" }, "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "Visual selection or word" })

-- lsp
map("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols" });
map("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "LSP Workspace Symbols" });
