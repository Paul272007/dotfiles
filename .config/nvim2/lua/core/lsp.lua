local config = vim.lsp.config

config("clangd", {
  cmd = { "clangd" },
  filetypes = { "c", "h", "cpp", "hpp" },
})

config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
})

config("intelephense", { -- FIX : exits with error code 1 when launched
  cmd = { "intelephense" },
  filetypes = { "php" },
})

config("pyright", { -- FIX : cannot be started
  cmd = { "pyright" },
  filetypes = { "python" },
})

vim.lsp.enable({
  "clangd", "lua_ls", "intelephense", "pyright"
})

-- Diagnostic configuration
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
  virtual_text = {
    spacing = 4,
    prefix = "●",
  },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = signs.Error,
      [vim.diagnostic.severity.WARN] = signs.Warn,
      [vim.diagnostic.severity.HINT] = signs.Hint,
      [vim.diagnostic.severity.INFO] = signs.Info,
    },
  },
})
