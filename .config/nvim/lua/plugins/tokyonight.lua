---@diagnostic disable: missing-fields
return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      transparent = true,
      styles = {
        -- sidebars = "transparent",
        -- floats = "transparent",
      },

      -- Change color number color and disable current line highlighting
      on_highlights = function(hl, c)
        hl.CursorLine = { bg = "none" }
        hl.CursorLineNr = { fg = c.orange, bold = true } -- Le numéro sera orange (ou utilise c.blue)
      end,
    })
    vim.cmd.colorscheme("tokyonight")

    -- Optionnel : s'assurer que l'option de Neovim pour afficher la ligne est bien activée
    vim.opt.cursorline = true
  end,
}
