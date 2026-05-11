require('bufferline').setup({
  options = {
    close_command = function(n) Snacks.bufdelete(n) end,
    right_mouse_command = function(n) Snacks.bufdelete(n) end,
    left_mouse_command = "buffer %d", -- switch to buffer on click
    middle_mouse_command = nil,       -- disable middle click
    diagnostics = 'nvim_lsp',         -- ?
    always_show_bufferline = false,
    separator_style = 'slope',
    show_buffer_icons = true, -- show icons
    color_icons = true,       -- icons are colored -- FIX : does not work
    hover = {                 -- FIX : does not work
      enabled = true,
      delay = 200,
      reveal = { 'close' }
    },
    sort_by = 'insert_at_end', -- put new buffers at the end
  },
})                             -- TODO : configure theme

require('lualine').setup({})   -- TODO : configure theme

require('notify').setup()
require('noice').setup() -- TODO : configure bar height and completion
require('mini.icons').setup()

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
