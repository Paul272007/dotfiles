require("mini.pairs").setup()

local ai = require("mini.ai")
ai.setup({
	n_lines = 500,
	custom_textobjects = {
		-- f : Function (requires Treesitter)
		f = ai.gen_spec.treesitter({
			a = "@function.outer",
			i = "@function.inner",
		}),

		-- g : Entire buffer
		g = function()
			local tot_lines = vim.fn.line("$")
			return {
				from = { line = 1, col = 1 },
				to = { line = tot_lines, col = math.max(vim.fn.getline(tot_lines):len(), 1) },
			}
		end,
	},
})

require("lazydev").setup()

require("trouble").setup()

require("blink.cmp").setup({
	keymap = {
		preset = "default",
		["<CR>"] = { "accept", "fallback" },
	},
	snippets = {
		preset = "default",
	},
	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "mono",
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer", "lazydev" },
		providers = {
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				fallbacks = { "lsp" },
			},
		},
	},
	cmdline = {
		enabled = false,
	},
	-- completion = {
	--   documentation = {
	--     window = { border = 'rounded' }
	--   }
	-- }
})

require("neogen").setup({})
