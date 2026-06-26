vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("blink-build", { clear = true }),
  callback = function(ev)
    if ev.data.spec.name == "blink.cmp" and (ev.data.kind == "install" or ev.data.kind == "update") then
      vim.notify("Building blink.cmp...", vim.log.levels.INFO)
      if not ev.data.active then
        vim.cmd.packadd("blink.cmp")
      end
      require("blink.cmp").build():wait(60000)
    end
  end,
})

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
  "https://github.com/sphamba/smear-cursor.nvim",

  -- editor
  "https://github.com/folke/flash.nvim",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/folke/todo-comments.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",

  -- code
  "https://github.com/Saghen/blink.lib",
  "https://github.com/Saghen/blink.cmp",
  -- "https://github.com/rafamadriz/friendly-snippets",
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
