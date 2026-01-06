--[[return {
  "nvim-telescope/telescope.nvim",
  -- branch = "0.1.x",
  -- tag = '0.1.8',
  branch = "master",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- fzf implémentation en C pour plus de rapidité
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {

        -- Parce que c'est joli
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        file_ignore_patterns = { ".git/", "node_modules", "dist/", "build" },

        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
        },
      },
    })

    telescope.load_extension("fzf")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set(
      "n",
      "<leader>ff",
      "<cmd>Telescope find_files<cr>",
      { desc = "Recherche de chaînes de caractères dans les noms de fichiers" }
    )
    keymap.set(
      "n",
      "<leader>fg",
      "<cmd>Telescope live_grep<cr>",
      { desc = "Recherche de chaînes de caractères dans le contenu des fichiers" }
    )
    keymap.set(
      "n",
      "<leader>fb",
      "<cmd>Telescope buffers<cr>",
      { desc = "Recherche de chaînes de caractères dans les noms de buffers" }
    )
    keymap.set(
      "n",
      "<leader>fx",
      "<cmd>Telescope grep_string<cr>",
      { desc = "Recherche de la chaîne de caractères sous le curseur" }
    )
  end,
} ]]
return {
  "nvim-telescope/telescope.nvim",
  tag = '0.1.8',
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    telescope.setup({
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        file_ignore_patterns = { ".git/", "node_modules", "dist/", "build" },

        -- Disable treesitter to fix ft_to_lang error with Neovim 0.11
        preview = {
          treesitter = false,
        },

        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
        },
      },
    })
    telescope.load_extension("fzf")

    local keymap = vim.keymap
    keymap.set(
      "n",
      "<leader>ff",
      "<cmd>Telescope find_files<cr>",
      { desc = "Recherche de chaînes de caractères dans les noms de fichiers" }
    )
    keymap.set(
      "n",
      "<leader>fg",
      "<cmd>Telescope live_grep<cr>",
      { desc = "Recherche de chaînes de caractères dans le contenu des fichiers" }
    )
    keymap.set(
      "n",
      "<leader>fb",
      "<cmd>Telescope buffers<cr>",
      { desc = "Recherche de chaînes de caractères dans les noms de buffers" }
    )
    keymap.set(
      "n",
      "<leader>fx",
      "<cmd>Telescope grep_string<cr>",
      { desc = "Recherche de la chaîne de caractères sous le curseur" }
    )
  end,
}
