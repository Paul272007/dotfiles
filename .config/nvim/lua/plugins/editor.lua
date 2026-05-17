require("flash").setup()

require("which-key").setup({
  preset = "helix",
  spec = {
    {
      mode = { "n", "x" },
      { "<leader>c", group = "code" },
      { "<leader>f", group = "find" },
      { "<leader>g", group = "git" },
      { "<leader>s", group = "search" },
      { "<leader>n", group = "notifications" },
    },
  },
})

require("gitsigns").setup()
require("todo-comments").setup()
