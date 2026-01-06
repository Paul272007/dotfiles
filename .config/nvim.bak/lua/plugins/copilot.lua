return {
  -- Plugin officiel Copilot en Lua
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    -- event = "VeryLazy",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        filetypes = {
          ["*"] = false,
        },
        suggestion = { enabled = false }, -- On désactive l'affichage fantôme par défaut pour utiliser cmp
        panel = { enabled = false },
      })
      -- vim.cmd("Copilot disable") -- désactivé par défaut
    end,
  },
  -- Connecteur pour nvim-cmp
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
