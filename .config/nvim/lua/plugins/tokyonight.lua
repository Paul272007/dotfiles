return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },

      -- C'est ici qu'on personnalise les couleurs spécifiques
      on_highlights = function(hl, c)
        -- CHOIX 1 (Recommandé) : Ligne 100% transparente, mais numéro coloré
        hl.CursorLine = { bg = "none" }
        hl.CursorLineNr = { fg = c.orange, bold = true } -- Le numéro sera orange (ou utilise c.blue)

        -- CHOIX 2 (Alternative) : Ligne opaque mais avec la couleur subtile de Tokyo Night
        -- Pour l'utiliser, efface les deux lignes du Choix 1 et décommente celle-ci :
        -- hl.CursorLine = { bg = c.bg_highlight }
      end,
    })

    vim.cmd.colorscheme("tokyonight")

    -- Optionnel : s'assurer que l'option de Neovim pour afficher la ligne est bien activée
    vim.opt.cursorline = true
  end,
}
