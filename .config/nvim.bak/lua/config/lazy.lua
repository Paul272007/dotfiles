-- Mise en place et installation de lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Configuration unique de lazy.nvim
require("lazy").setup({
  -- 1. On charge les plugins "en vrac" dans le dossier plugins/
  { import = "plugins" },
  -- 2. On charge spécifiquement le sous-dossier lsp/
  { import = "plugins.lsp" },
}, {
  -- Options de Lazy
  checker = {
    enabled = true,
    notify = false,
  },
  install = { colorscheme = { "tokyonight" } },
  change_detection = {
    notify = false,
  },
})
