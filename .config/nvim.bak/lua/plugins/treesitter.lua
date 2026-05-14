return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    indent = {
      enable = true,
      disable = { "c", "cpp" }, -- Fix C & C++ indentation bug
    },
  },
}
