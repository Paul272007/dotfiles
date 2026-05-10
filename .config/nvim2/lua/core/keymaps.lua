local map = vim.keymap.set

-- Disable some keys
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

-- Buffers
map("n", "<PageDown>", ":bnext<CR>", { desc = "Switch to next buffer", noremap = true, silent = true })
map("n", "<PageUp>", ":bprev<CR>", { desc = "Switch to previous buffer", noremap = true, silent = true })
map("n", "<tab>", ":bnext<CR>", { desc = "Switch to next buffer", noremap = true, silent = true })
map("n", "<S-tab>", ":bprev<CR>", { desc = "Switch to previous buffer", noremap = true, silent = true })

-- Terminal mode
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Quit terminal mode" })
