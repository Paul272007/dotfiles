return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>fe",
        function()
          Snacks.explorer({
            cwd = LazyVim.root(),
            layout = { layout = { position = "right" } },
          })
        end,
        desc = "Explorer Snacks (root dir)",
      },
      {
        "<leader>fE",
        function()
          Snacks.explorer({
            layout = { layout = { position = "right" } },
          })
        end,
        desc = "Explorer Snacks (cwd)",
      },
    },
    opts = {
      picker = {
        sources = {
          explorer = {
            -- formatters = {
            --   file = { filename_only = true },
            --   severity = { pos = "right" },
            -- },
            hidden = true,
            ignored = false,
            exclude = { ".git", "node_modules", ".cache", ".DS_Store", "target", "dist", ".idea" },
          },
        },
      },
    },
  },
}
