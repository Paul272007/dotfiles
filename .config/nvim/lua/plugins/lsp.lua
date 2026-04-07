return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
    },
    servers = {
      qmlls = {
        cmd = { "qmlls6", "-I", "/usr/lib/qt6/qml" },
        filetypes = { "qml", "qmljs" },
      },
    },
  },
}
