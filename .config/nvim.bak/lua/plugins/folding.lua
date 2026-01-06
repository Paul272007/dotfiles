return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  event = "BufReadPost", -- Charge le plugin à l'ouverture d'un fichier
  init = function()
    -- Options visuelles pour avoir la colonne avec les flèches
    vim.o.foldcolumn = "1" -- Affiche une colonne de largeur 1 pour les plis
    vim.o.foldlevel = 99 -- Ouvre tout par défaut au démarrage
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end,
  config = function()
    local ufo = require("ufo")

    -- Configuration pour utiliser Treesitter (plus intelligent)
    ufo.setup({
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,
    })

    -- Raccourcis clavier améliorés
    vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Ouvrir tous les plis" })
    vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Fermer tous les plis" })
    -- Note : 'za' fonctionne toujours pour plier/déplier sous le curseur
  end,
}
