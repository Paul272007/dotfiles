return {
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        -- 1. Désactive le texte gris fantôme (Ghost Text)
        ghost_text = { enabled = false },

        -- 2. Configure la fenêtre de documentation
        documentation = {
          auto_show_delay_ms = 1000,
          -- window = { border = "rounded" }, -- Optionnel : met une jolie bordure si tu l'affiches
        },

        -- 3. Configure le menu de complétion lui-même
        menu = {
          -- border = "rounded",
          scrollbar = false,
          draw = {
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
          },
        },
      },
    },
  },
}
