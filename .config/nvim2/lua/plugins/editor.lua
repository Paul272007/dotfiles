require('flash').setup()

require('which-key').setup({
  preset = "helix",
  spec = {
    {
      mode = { "n", "x" },
      { "<leader>c", group = "code" },
      { "<leader>g", group = "git" },
    },
  },
})

require('gitsigns').setup()
require('todo-comments').setup()
