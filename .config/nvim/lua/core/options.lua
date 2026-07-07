local opt = vim.opt
local g = vim.g

-- Global
g.mapleader = " "
g.autoformat = true

-- disable clipboard if in SSH
opt.clipboard = vim.env.SSH_CONNECTION and "" or "unnamedplus" -- system clipboard
opt.autowrite = true -- write automatically when using certain commands
opt.confirm = true -- confirm before quitting modified buffer
opt.cursorline = true -- highlight current line
opt.mouse = "a" -- enable mouse
opt.smoothscroll = true -- smooth scroll
opt.spelllang = { "en", "fr" } -- languages to use to check spelling
opt.signcolumn = "yes" -- always show sign column
opt.wrap = false
opt.termguicolors = true -- fix some bugs

opt.number = true -- print line number
opt.relativenumber = true -- numbers are relative to cursor
opt.termguicolors = true -- enable true colors
opt.list = true -- show invisible characters such as tabs, spaces...
opt.splitbelow = true -- open new windows below current one
opt.splitright = true -- open new windows right of current one
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.ruler = false -- disable default ruler
opt.inccommand = "split" -- split screen to see changes of current command on the entire file

-- Indentation
opt.expandtab = true -- indent using spaces
opt.shiftwidth = 2 -- indent size
opt.tabstop = 2 -- size of a tab
opt.smartindent = true -- automatically insert indents
opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}

-- Search
-- opt.ignorecase = true -- ignore case when searching in lowercase
-- opt.smartcase = true -- do not ignore case when uppercase is given

-- Autocompletion (show menu even when there is only one option and do not select first option automatically)
opt.completeopt = { "menu", "menuone", "noselect" }

-- Ensure cache directory exists
vim.fn.mkdir(vim.fn.stdpath("cache"), "p")
