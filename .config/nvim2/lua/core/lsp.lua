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
