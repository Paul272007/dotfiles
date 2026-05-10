vim.pack.add({
  -- ui
	"https://github.com/akinsho/bufferline.nvim",

  -- editor
  "https://github.com/folke/flash.nvim",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/folke/todo-comments.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",

  -- code
	"https://github.com/nvim-mini/mini.pairs",
  "https://github.com/nvim-mini/mini.ai",
  "https://github.com/folke/lazydev.nvim",
  "https://github.com/folke/trouble.nvim",

  -- formatting
  "https://github.com/stevearc/conform.nvim",
})

require("plugins.ui")
require("plugins.editor")
require("plugins.code")
