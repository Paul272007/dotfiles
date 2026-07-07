require("flash").setup()

require("which-key").setup({
	preset = "helix",
	spec = {
		{
			mode = { "n", "x" },
			{ "<leader>b", group = "buffers" },
			{ "<leader>c", group = "code" },
			{ "<leader>f", group = "find" },
			{ "<leader>g", group = "git" },
			{ "<leader>n", group = "notifications" },
			{ "<leader>s", group = "search" },
		},
	},
})

require("gitsigns").setup()
require("todo-comments").setup()
require("tabout").setup({
	ignore_beginning = true,
})
