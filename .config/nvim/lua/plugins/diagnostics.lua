return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy", -- Ou "LspAttach"
  priority = 1000, -- Needs to be loaded early
  config = function()
    require('tiny-inline-diagnostic').setup({
      preset = "modern", -- Style moderne "ghost text"
      options = {
        show_source = true,
        use_icons_from_diagnostic = true,
        multilines = true,
      }
    })
    vim.diagnostic.config({ virtual_text = false }) -- Important pour laisser la place au plugin
  end,
}
