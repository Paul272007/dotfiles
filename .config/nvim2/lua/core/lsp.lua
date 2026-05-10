local config = vim.lsp.config
local enable = vim.lsp.enable

config("clangd", {
	cmd = { "clangd" },
	filetypes = { "c", "h" },
})

config("lua_ls", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
})

enable({ "clangd", "lua_ls" })
