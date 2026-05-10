require('bufferline').setup() -- TODO : configure

require('lualine').setup({})  -- TODO : configure

require('notify').setup()
require('noice').setup()      -- TODO : configure
require('mini.icons').setup() -- TODO : configure

require('snacks').setup({
  bigfile = { enabled = true },
  dashboard = { enabled = true },
  indent = { enabled = true },
  input = { enabled = true },
  notifier = { enabled = true },
  quickfix = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
  picker = {
    enabled = true,
    sources = {
      explorer = {
        hidden = true,
        ignored = false,
        exclude = { ".git", "node_modules", ".cache", ".DS_Store", "target", "dist", ".idea", "out" },
      }
    }
  },
})
