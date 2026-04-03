-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- opt.relativenumber = false
-- opt.autoindent = true

-- doesn't work
vim.g.lazyvim_lsp_inlay_hints = false

-- Pour Lua (init.lua)
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

opt.clipboard = "unnamedplus"

-- opt.formatoptions:remove({ "r", "o" })
vim.cmd([[autocmd FileType * set formatoptions-=ro]])
-- Chaque lettre correspond à un comportement spécifique de Neovim :
-- r : Ajoute automatiquement le symbole de commentaire après avoir appuyé sur Entrée en mode Insertion.
-- o : Ajoute automatiquement le symbole de commentaire après avoir appuyé sur o ou O en mode Normal.

-- LazyVim root dir detection
-- Each entry can be:
-- the name of a detector function like `lsp` or `cwd`
-- a pattern or array of patterns like `.git` or `lua`.
-- a function with signature `function(buf) -> string|string[]`
-- vim.g.root_spec = { "lsp", "cwd" }

-- Fix pour l'erreur "nothing is copied" sur Wayland/Hyprland
if os.getenv("WAYLAND_DISPLAY") then
  vim.g.clipboard = {
    name = "wl-clipboard",
    copy = {
      ["+"] = { "wl-copy", "--foreground", "--type", "text/plain" },
      ["*"] = { "wl-copy", "--foreground", "--type", "text/plain" },
    },
    paste = {
      ["+"] = { "wl-paste", "--no-newline" },
      ["*"] = { "wl-paste", "--no-newline" },
    },
    cache_enabled = 1,
  }
end
