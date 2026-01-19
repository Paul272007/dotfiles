return {
  {
    "danymat/neogen",
    config = true,
    -- Optionnel : lier à un raccourci clavier
    keys = {
      { "<leader>cd", ":lua require('neogen').generate()<cr>", desc = "Générer Doc (@brief)" },
    },
  },
}
