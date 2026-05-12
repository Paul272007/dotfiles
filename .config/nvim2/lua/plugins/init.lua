vim.pack.add({
  -- dependencies
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/rcarriga/nvim-notify",

  -- ui
  "https://github.com/akinsho/bufferline.nvim",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/folke/noice.nvim",
  "https://github.com/nvim-mini/mini.icons",
  "https://github.com/folke/snacks.nvim",

  -- editor
  "https://github.com/folke/flash.nvim",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/folke/todo-comments.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",

  -- code
  "https://github.com/Saghen/blink.lib",
  "https://github.com/Saghen/blink.cmp",
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/nvim-mini/mini.pairs",
  "https://github.com/nvim-mini/mini.ai",
  "https://github.com/folke/lazydev.nvim",
  "https://github.com/folke/trouble.nvim",
  "https://github.com/danymat/neogen",

  -- formatting
  "https://github.com/stevearc/conform.nvim",

  -- utils
  "https://github.com/folke/persistence.nvim",
})

require("plugins.ui")
require("plugins.editor")
require("plugins.code")
require("plugins.formatting")
