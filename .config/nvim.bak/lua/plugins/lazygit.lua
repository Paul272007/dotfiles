return {
  "kdheepak/lazygit.nvim",
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  -- dépendance optionnelle pour l'apparence
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  -- Raccourci clavier pour l'ouvrir
  keys = {
    { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Ouvrir l'interface Lazygit" },
  },
}
