require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    c = { "clang-format" },
    h = { "clang-format" },
    java = { "clang-format" },
    javascript = { "clang-format" },
    typescript = { "clang-format" },
    json = { "clang-format" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})
