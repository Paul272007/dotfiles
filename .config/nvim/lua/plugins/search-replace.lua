return {
  "MagicDuck/grug-far.nvim",
  config = function()
    require("grug-far").setup({})
  end,
  keys = {
    {
      "<leader>sr",
      function()
        require("grug-far").open({ transient = true })
      end,
      desc = "Search and Replace (Project wide)",
    },
    {
      "<leader>sw",
      function()
        require("grug-far").open({ transient = true, prefills = { search = vim.fn.expand("<cword>") } })
      end,
      desc = "Search and Replace current Word",
    },
  },
}
