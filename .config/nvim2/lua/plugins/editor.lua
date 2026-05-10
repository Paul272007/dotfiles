require('flash').setup()

require('which-key').setup({
  preset = "helix",
  spec = {
    {
      mode = { "n", "x" },
      { "<leader>c", group = "code" },
    },
  },
}) -- FIX : config doesn't work

require('gitsigns').setup()
require('todo-comments').setup()
