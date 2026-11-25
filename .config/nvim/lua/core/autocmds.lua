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

-- local center_group = vim.api.nvim_create_augroup("CenterCursor", { clear = true })
-- replace cursor at the center of the screen when moving more than 3 lines
-- vim.api.nvim_create_autocmd("CursorMoved", {
-- 	group = center_group,
-- 	callback = function()
-- 		if math.abs(vim.fn.line(".") - vim.fn.line("w0") - (vim.b.last_line or 0)) > 3 then
-- 			vim.cmd("normal! zz")
-- 		end
-- 		vim.b.last_line = vim.fn.line(".") - vim.fn.line("w0")
-- 	end,
-- })

-- Do not open comment line when creating new line under comment
-- opt.formatoptions:remove({ "r", "o" })
vim.cmd([[autocmd FileType * set formatoptions-=ro]])
-- Each letter controls a specific Neovim comment behavior:
-- r : Automatically insert the comment leader after pressing Enter in Insert mode.
-- o : Automatically insert the comment leader after pressing o or O in Normal mode.
