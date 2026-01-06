return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/lazydev.nvim",                  opts = {} },
    "williamboman/mason-lspconfig.nvim", -- Correction : Retour au dépôt officiel
  },
  keys = {
    -- Raccourcis LSP (inchangés)
    { "<leader>ca", vim.lsp.buf.code_action,                                          desc = "Code Action",                                 mode = { "n", "v" } },
    { "gR",         "<cmd>Telescope lsp_references<CR>",                              desc = "Show LSP references",                         mode = "n" },
    { "gD",         vim.lsp.buf.declaration,                                          desc = "Go to declaration",                           mode = "n" },
    { "gd",         "<cmd>Telescope lsp_definitions<CR>",                             desc = "Show LSP definitions",                        mode = "n" },
    { "gi",         "<cmd>Telescope lsp_implementations<CR>",                         desc = "Show LSP implementations",                    mode = "n" },
    { "gt",         "<cmd>Telescope lsp_type_definitions<CR>",                        desc = "Show LSP type definitions",                   mode = "n" },
    { "gs",         vim.lsp.buf.signature_help,                                       desc = "Show LSP signature help",                     mode = "n" },
    { "<leader>rn", vim.lsp.buf.rename,                                               desc = "Smart rename",                                mode = "n" },
    { "<leader>D",  "<cmd>Telescope diagnostics bufnr=0<CR>",                         desc = "Show buffer diagnostics",                     mode = "n" },
    { "<leader>d",  vim.diagnostic.open_float,                                        desc = "Show line diagnostics",                       mode = "n" },
    { "[d",         function() vim.diagnostic.jump({ count = -1, float = true }) end, desc = "Go to previous diagnostic",                   mode = "n" },
    { "]d",         function() vim.diagnostic.jump({ count = 1, float = true }) end,  desc = "Go to next diagnostic",                       mode = "n" },
    { "K",          vim.lsp.buf.hover,                                                desc = "Show documentation for what is under cursor", mode = "n" },
    { "<leader>F",  "<cmd>lua vim.lsp.buf.format({async = true})<cr>",                desc = "Format buffer",                               mode = { "n", "x" } },
    { "<leader>rs", ":LspRestart<CR>",                                                desc = "Restart LSP",                                 mode = "n" },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- On s'assure que mason-lspconfig est bien chargé
    mason_lspconfig.setup()

    -- Liste des serveurs à configurer
    -- Note: Assurez-vous que ces serveurs sont bien installés via Mason
    local servers = {
      "cssls",
      "html",
      "lua_ls",
      "pylsp",
      "ruff",
      "rust_analyzer",
      "ts_ls",
      "yamlls",
      -- Ajoutez d'autres serveurs ici si nécessaire
    }

    -- Boucle simple et robuste pour configurer chaque serveur
    for _, server in ipairs(servers) do
      local opts = {
        capabilities = capabilities,
      }

      -- Configuration spécifique pour Lua
      if server == "lua_ls" then
        opts.settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        }
      end

      -- Configuration spécifique pour Python (PyLSP)
      if server == "pylsp" then
        opts.settings = {
          pylsp = {
            plugins = {
              pycodestyle = { enabled = true, ignore = { "E501" } },
              pylsp_mypy = { enabled = true },
            },
          },
        }
      end

      -- Configuration spécifique pour Rust
      if server == "rust_analyzer" then
        opts.settings = {
          ["rust-analyzer"] = {
            check = { command = "clippy" },
          },
        }
      end

      -- On active le serveur avec ses options
      lspconfig[server].setup(opts)
    end

    -- Configuration de l'apparence des diagnostics
    vim.diagnostic.config({
      virtual_text = false, -- Laissez false si vous utilisez tiny-inline-diagnostic
      signs = true,
      update_in_insert = false,
      underline = true,
      severity_sort = true,
    })
  end,
}
