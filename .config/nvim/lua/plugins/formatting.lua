require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },

		c = { "clang-format" },
		h = { "clang-format" },
		java = { "clang-format" },

		javascript = { "prettier" },
		typescript = { "prettier" },
		json = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		vue = { "prettier" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})
