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
map("n", "<F5>", ":w<CR>:term zc run -q %<CR>", { desc = "Compile and execute C/C++ file using ZC" })

---- Neogen
map("n", "<leader>co", ":lua require('neogen').generate()<cr>", { desc = "Générer Doc (@brief)" })

---- Snacks
--
-- picker
map("n", "<leader><space>", function() Snacks.picker.smart() end, { desc = "Smart find files" })
map("n", "<leader>e", function()
  Snacks.explorer({
    layout = { layout = { position = "right" } },
  })
end, { desc = "File Explorer" })
-- buffers
map("n", "<leader>q", function() Snacks.bufdelete() end, { desc = "Delete current buffer" })
-- lsp
map("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols" });
map("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "LSP Workspace Symbols" });
-- lazygit
map("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "Lazygit" }) -- FIX : doesn't work
