local config = vim.lsp.config

config("clangd", {
  cmd = { "clangd", "--clang-tidy" },
  filetypes = { "c", "h", "cpp", "hpp" },
  root_markers = { ".git" },
})

config("neocmakelsp", {
  cmd = { "neocmakelsp", "--stdio" },
  filetypes = { "cmake" },
  root_markers = { ".git" },
})

config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enabled = false },
      diagnostics = { globals = { "vim" } },
    },
  },
})

config("intelephense", {
  cmd = { "intelephense", "--stdio" },
  filetypes = { "php" },
  root_markers = { "composer.json", ".git" },
})

config("pyright", {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" },
})

config("rust-analyzer", {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", ".git" }
})

config("bash-language-server", {
  cmd = { "bash-language-server", "start" },
  filetypes = { "bash", "sh" },
  root_markers = { ".git" }
})

-- TODO : add: jdtls, ts_ls, volar, html, cssls

vim.lsp.enable({
  "clangd",
  "neocmakelsp",
  "lua_ls",
  "intelephense",
  "pyright",
  "rust-analyzer",
  "bash-language-server"
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
