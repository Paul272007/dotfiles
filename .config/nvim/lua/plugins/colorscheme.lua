---@diagnostic disable: missing-fields
return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    enabled = false,
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
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "habamax",
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = {
          normal = {
            a = { fg = "#16120e", bg = "#c8814a", gui = "bold" },
            b = { fg = "#c8b89a", bg = "#3a2c1c" },
            c = { fg = "#a09078", bg = "#252018" },
          },
          insert = { a = { fg = "#16120e", bg = "#8faa74", gui = "bold" } },
          visual = { a = { fg = "#16120e", bg = "#d4a85a", gui = "bold" } },
          replace = { a = { fg = "#16120e", bg = "#c86050", gui = "bold" } },
          command = { a = { fg = "#16120e", bg = "#7aaa90", gui = "bold" } },
          inactive = {
            a = { fg = "#6b5c48", bg = "#252018" },
            b = { fg = "#6b5c48", bg = "#1e1812" },
            c = { fg = "#6b5c48", bg = "#1e1812" },
          },
        },
      },
      sections = {
        lualine_c = {
          {
            "filename",
            path = 1, -- Affiche le chemin relatif
            symbols = {
              modified = " [+] ",
              readonly = " [RO]",
              unnamed = "[No Name]",
            },
          },
        },
      },
    },
  },
}
