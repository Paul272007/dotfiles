-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap.set

-- keymap("n", "<leader>h", ":nohl<CR>", { desc = "Remove search highlighting", noremap = true, silent = true })

-- Disable PageUp and PageDown in insert mode to avoid misclicks
keymap("i", "<PageUp>", "<Nop>", { desc = "Disable PageUp" })
keymap("i", "<PageDown>", "<Nop>", { desc = "Disable PageDown" })

-- I moves the selected text upwards in visual mode
keymap(
  "v",
  "<S-i>",
  ":m .-2<CR>==",
  { desc = "Move the selected text upwards in visual mode", noremap = true, silent = true }
)
-- K moves the selected text downwards in visual mode
keymap(
  "v",
  "<S-k>",
  ":m .+1<CR>==",
  { desc = "Move the selected text downwards in visual mode", noremap = true, silent = true }
)

-- I moves the selected text upwards in Visual mode
keymap(
  "x",
  "<S-i>",
  ":move '<-2<CR>gv-gv",
  { desc = "Move the selected text upwards in Visual mode", noremap = true, silent = true }
)

-- K moves the selected text downwards in Visual mode
keymap(
  "x",
  "<S-k>",
  ":move '>+1<CR>gv-gv",
  { desc = "Move the selected text downwards in Visual mode", noremap = true, silent = true }
)

keymap("n", "<PageDown>", ":bnext<CR>", { desc = "Switch to next buffer", noremap = true, silent = true })

keymap("n", "<PageUp>", ":bprev<CR>", { desc = "Switch to previous buffer", noremap = true, silent = true })

-- keymap("n", "C-Del", ":bdelete<CR>", { desc = "Close current buffer", noremap = true, silent = true })

keymap("t", "<Esc>", "<C-\\><C-n>", { desc = "Quit terminal mode" })

keymap("n", "<F5>", ":w<CR>:term zc run %<CR>", { desc = "Compile and execute C/C++ code with ZC" })

--[[
keymap("n", "<leader>rn", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })
]]

keymap("n", "<leader>a;", "mqA;<esc>`q", { desc = "Append ';' at the end of the line" })
keymap("n", "<leader>a,", "mqA,<esc>`q", { desc = "Append ',' at the end of the line" })
