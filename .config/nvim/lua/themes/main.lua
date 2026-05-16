local M = {}

M.colors = {
  bg0    = "#16120e", -- fond le plus sombre (lignes inactives)
  bg1    = "#1e1812", -- fond principal
  bg2    = "#252018", -- fond surface (splits, popups)
  bg3    = "#2e2418", -- bordures, séparateurs
  bg4    = "#3a2c1c", -- sélection, visual mode

  fg0    = "#e0d0ba", -- texte très lumineux (rare)
  fg1    = "#c8b89a", -- texte principal
  fg2    = "#a09078", -- texte secondaire
  fg3    = "#7a6858", -- texte dim (numéros de ligne, etc.)
  fg4    = "#6b5c48", -- commentaires

  red    = "#c86050", -- erreurs
  orange = "#c8814a", -- keywords
  yellow = "#d4a85a", -- fonctions, identifiants
  green  = "#8faa74", -- strings
  teal   = "#7aaa90", -- types
  blue   = "#7a9ab0", -- constantes
  purple = "#a08898", -- paramètres spéciaux
  sand   = "#c49060", -- nombres
}

function M.setup()
  local c = M.colors

  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  vim.opt.background = "dark"
  vim.g.colors_name = "main"

  local function hl(group, settings)
    vim.api.nvim_set_hl(0, group, settings)
  end

  -- Editor
  hl("Normal", { fg = c.fg1, bg = "NONE" })
  hl("NormalFloat", { fg = c.fg1, bg = "NONE" })
  hl("NormalNC", { fg = c.fg2, bg = "NONE" })
  hl("SignColumn", { fg = c.fg3, bg = "NONE" })
  hl("LineNr", { fg = c.fg3, bg = "NONE" })
  hl("CursorLine", { bg = "NONE" })
  hl("CursorLineNr", { fg = c.fg0, bg = "NONE", bold = true })
  hl("ColorColumn", { bg = "NONE" })
  hl("MatchParen", { fg = c.orange, bold = true, underline = true })

  -- Borders / window frames
  hl("WinSeparator", { fg = "NONE", bg = "NONE" })
  hl("VertSplit", { fg = "NONE", bg = "NONE" })
  hl("FloatBorder", { fg = "NONE", bg = "NONE" })

  -- Selection / search
  hl("Visual", { bg = c.bg4 })
  hl("Search", { fg = "NONE", bg = c.yellow })
  hl("IncSearch", { fg = "NONE", bg = c.orange, bold = true })
  hl("Substitute", { fg = "NONE", bg = c.red })

  -- Messages / status
  hl("MsgArea", { fg = c.fg2, bg = "NONE" })
  hl("ErrorMsg", { fg = c.red, bold = true })
  hl("WarningMsg", { fg = c.yellow })

  -- Menus
  hl("Pmenu", { fg = c.fg1, bg = "NONE" })
  hl("PmenuSel", { fg = c.fg0, bg = c.bg4, bold = true })
  hl("PmenuSbar", { bg = "NONE" })
  hl("PmenuThumb", { bg = c.fg3 })

  -- Syntax
  hl("Comment", { fg = c.fg4, italic = true })
  hl("Keyword", { fg = c.orange, bold = true })
  hl("Statement", { fg = c.orange, bold = true })
  hl("Conditional", { fg = c.orange })
  hl("Repeat", { fg = c.orange })
  hl("Function", { fg = c.yellow })
  hl("Identifier", { fg = c.fg1 })
  hl("String", { fg = c.green })
  hl("Number", { fg = c.sand })
  hl("Float", { fg = c.sand })
  hl("Boolean", { fg = c.sand })
  hl("Type", { fg = c.teal })
  hl("Typedef", { fg = c.teal })
  hl("Constant", { fg = c.blue })
  hl("Special", { fg = c.purple })
  hl("PreProc", { fg = c.orange, italic = true })
  hl("Operator", { fg = c.fg2 })
  hl("Delimiter", { fg = c.fg3 })

  -- Treesitter
  hl("@variable", { fg = c.fg1 })
  hl("@variable.builtin", { fg = c.orange, italic = true })
  hl("@function", { fg = c.yellow })
  hl("@function.builtin", { fg = c.yellow, italic = true })
  hl("@function.call", { fg = c.yellow })
  hl("@method", { fg = c.yellow })
  hl("@method.call", { fg = c.yellow })
  hl("@keyword", { fg = c.orange, bold = true })
  hl("@keyword.return", { fg = c.orange, bold = true })
  hl("@string", { fg = c.green })
  hl("@string.escape", { fg = c.teal })
  hl("@number", { fg = c.sand })
  hl("@boolean", { fg = c.sand })
  hl("@type", { fg = c.teal })
  hl("@type.builtin", { fg = c.teal, italic = true })
  hl("@parameter", { fg = c.fg1, italic = true })
  hl("@comment", { fg = c.fg4, italic = true })
  hl("@punctuation", { fg = c.fg3 })
  hl("@punctuation.bracket", { fg = c.fg2 })
  hl("@operator", { fg = c.fg2 })
  hl("@tag", { fg = c.orange })
  hl("@tag.attribute", { fg = c.yellow })

  -- LSP diagnostics
  hl("DiagnosticError", { fg = c.red })
  hl("DiagnosticWarn", { fg = c.yellow })
  hl("DiagnosticInfo", { fg = c.blue })
  hl("DiagnosticHint", { fg = c.teal })
  hl("DiagnosticUnderlineError", { underline = true, sp = c.red })
  hl("DiagnosticUnderlineWarn", { underline = true, sp = c.yellow })

  -- Git signs
  hl("GitSignsAdd", { fg = c.green, bg = "NONE" })
  hl("GitSignsChange", { fg = c.yellow, bg = "NONE" })
  hl("GitSignsDelete", { fg = c.red, bg = "NONE" })

  -- Snacks / Telescope / pickers
  hl("SnacksPickerDir", { fg = c.fg3 })
  hl("SnacksPickerMatch", { fg = c.yellow, bold = true })
  hl("TelescopeBorder", { fg = "NONE" })
  hl("TelescopeNormal", { fg = c.fg1, bg = "NONE" })

  -- Transparency
  local groups = {
    "StatusLine",   -- lualine bg
    "StatusLineNC", -- bufferline bg
    -- "BufferLineFill",
    -- "BufferLineSeparator", "BufferLineSeparatorSelected"
  }
  for _, group in ipairs(groups) do
    hl(group, { bg = "NONE", ctermbg = "NONE" })
  end
end

-- Export lualine theme
function M.get_lualine_theme()
  local c = M.colors
  return {
    normal = {
      a = { fg = c.bg0, bg = c.orange, bold = true },
      b = { fg = c.fg0, bg = c.bg2 },
      c = { fg = c.fg1, bg = "NONE" },
    },
    inactive = {
      a = { fg = c.fg3, bg = c.bg1 },
      b = { fg = c.fg3, bg = c.bg1 },
      c = { fg = c.fg3, bg = "NONE" },
    },
    insert = { a = { fg = c.bg0, bg = c.green, bold = true } },
    visual = { a = { fg = c.bg0, bg = c.yellow, bold = true } },
    replace = { a = { fg = c.bg0, bg = c.red, bold = true } },
    command = { a = { fg = c.bg0, bg = c.teal, bold = true } },
  }
end

return M
