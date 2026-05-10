require('mini.pairs').setup()

require('mini.ai').setup({})

require('lazydev').setup()

require('trouble').setup()

require('blink.cmp').setup({
  keymap = {
    preset = 'default',
    ['<CR>'] = { 'accept', 'fallback' },
  },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = 'mono'
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        fallbacks = { "lsp" },
      },
    },
  },
  -- completion = {
  --   documentation = {
  --     window = { border = 'rounded' }
  --   }
  -- }
})

require('neogen').setup({})
