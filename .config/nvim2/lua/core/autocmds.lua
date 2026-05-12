local augroup = vim.api.nvim_create_augroup

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("my.lsp", {}),
  callback = function(ev)
    -- local client =
    assert(vim.lsp.get_client_by_id(ev.data.client_id))

    -- blink.cmp handles completion, we don't need to enable the built-in one
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank", { clear = true }),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell", { clear = true }),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Do not open comment line when creating new line under comment
-- opt.formatoptions:remove({ "r", "o" })
vim.cmd([[autocmd FileType * set formatoptions-=ro]])
-- Chaque lettre correspond à un comportement spécifique de Neovim :
-- r : Ajoute automatiquement le symbole de commentaire après avoir appuyé sur Entrée en mode Insertion.
-- o : Ajoute automatiquement le symbole de commentaire après avoir appuyé sur o ou O en mode Normal.
