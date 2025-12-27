return {
  "sindrets/diffview.nvim",
  event = "VeryLazy",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Ouvrir la vue Diff (comparaison)" },
    { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Fermer la vue Diff" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Historique du fichier actuel" },
  },
}
