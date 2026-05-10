local opt = vim.opt
local g = vim.g
local o = vim.o

-- Global
g.mapleader = " "
g.autoformat = true
-- g.snacks_animate = true

-- opt.autowrite = true
-- disable clipboard if in SSH
opt.clipboard = vim.env.SSH_CONNECTION and "" or "unnamedplus" -- system clipboard
opt.confirm = true -- confirm before quitting modified buffer
opt.cursorline = false -- highlight current line
opt.mouse = "a"
opt.smoothscroll = true
opt.spelllang = { 'en', 'fr' }
opt.signcolumn = "yes" -- always show sign column
opt.wrap = false

opt.number = true -- print line number
opt.relativenumber = true
opt.termguicolors = true
-- opt.ruler = false -- disable default ruler

-- Indentation
opt.expandtab = true -- indent using spaces
opt.shiftwidth = 2 -- indent size
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
opt.ignorecase = true
opt.smartcase = true -- do not ignore case when uppercase is given
opt.tabstop = 2
-- opt.inccommand = "nosplit"

-- Autocompletion
opt.complete:append('o')
opt.completeopt = { 'menuone', 'noselect' }
o.autocomplete = true
