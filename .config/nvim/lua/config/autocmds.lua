-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    local red = "#c86050"
    local gray = "#0F0F0F"
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = red, bg = gray })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = gray })
    vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = red, bg = gray })
    vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = red, bg = gray })
  end,
})
