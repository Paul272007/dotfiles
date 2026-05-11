local M = {}

M.colors = {
  --   bg0    = "#16120e", -- fond le plus sombre (lignes inactives)
  --   bg1    = "#1e1812", -- fond principal
  --   bg2    = "#252018", -- fond surface (splits, popups)
  --   bg3    = "#2e2418", -- bordures, séparateurs

  -- TRANSPARENT
  bg0    = "NONE",    -- fond le plus sombre (lignes inactives)
  bg1    = "NONE",    -- fond principal
  bg2    = "NONE",    -- fond surface (splits, popups)
  bg3    = "NONE",    -- bordures, séparateurs
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
  hl("Normal", { fg = c.fg1, bg = c.bg1 })
  hl("NormalFloat", { fg = c.fg1, bg = c.bg2 })
  hl("NormalNC", { fg = c.fg2, bg = c.bg0 })
  hl("SignColumn", { fg = c.fg3, bg = c.bg1 })
  hl("LineNr", { fg = c.fg3, bg = c.bg1 })
  hl("CursorLine", { bg = c.bg2 })
  hl("CursorLineNr", { fg = c.yellow, bg = c.bg2, bold = true })
  hl("ColorColumn", { bg = c.bg2 })
  hl("MatchParen", { fg = c.yellow, bold = true, underline = true })

  -- Bordures : discrètes, pas agressives
  hl("WinSeparator", { fg = c.bg3, bg = c.bg1 })
  hl("VertSplit", { fg = c.bg3, bg = c.bg1 })
  hl("FloatBorder", { fg = c.bg3, bg = c.bg2 })

  -- Sélection / recherche
  hl("Visual", { bg = c.bg4 })
  hl("Search", { fg = c.bg0, bg = c.yellow })
  hl("IncSearch", { fg = c.bg0, bg = c.orange, bold = true })
  hl("Substitute", { fg = c.bg0, bg = c.red })

  -- Messages / statut
  hl("MsgArea", { fg = c.fg2, bg = c.bg1 })
  hl("ErrorMsg", { fg = c.red, bold = true })
  hl("WarningMsg", { fg = c.yellow })

  -- Menus
  hl("Pmenu", { fg = c.fg1, bg = c.bg2 })
  hl("PmenuSel", { fg = c.fg0, bg = c.bg4, bold = true })
  hl("PmenuSbar", { bg = c.bg3 })
  hl("PmenuThumb", { bg = c.fg3 })

  -- Syntaxe
  hl("Comment", { fg = c.fg4, italic = true })
  hl("Keyword", { fg = c.orange, bold = true })
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
  hl("GitSignsAdd", { fg = c.green, bg = c.bg1 })
  hl("GitSignsChange", { fg = c.yellow, bg = c.bg1 })
  hl("GitSignsDelete", { fg = c.red, bg = c.bg1 })

  -- Snacks / Telescope / pickers
  hl("SnacksPickerDir", { fg = c.fg3 })
  hl("SnacksPickerMatch", { fg = c.yellow, bold = true })
  hl("TelescopeBorder", { fg = c.bg3 })
  hl("TelescopeNormal", { fg = c.fg1, bg = c.bg2 })

  -- Lualine (défini ici en plus du setup lualine ci-dessous)
  for _, mode in ipairs({ "normal", "insert", "visual", "replace", "command", "inactive" }) do
    hl("lualine_a_" .. mode, { fg = c.bg0, bg = c.orange, bold = true })
    hl("lualine_b_" .. mode, { fg = c.fg1, bg = c.bg3 })
    hl("lualine_c_" .. mode, { fg = c.fg2, bg = c.bg2 })
  end
  hl("lualine_a_normal", { fg = c.bg0, bg = c.orange, bold = true })
  hl("lualine_a_insert", { fg = c.bg0, bg = c.green, bold = true })
  hl("lualine_a_visual", { fg = c.bg0, bg = c.yellow, bold = true })
  hl("lualine_a_replace", { fg = c.bg0, bg = c.red, bold = true })
  hl("lualine_a_command", { fg = c.bg0, bg = c.teal, bold = true })
  hl("lualine_a_inactive", { fg = c.fg3, bg = c.bg2 })
  hl("lualine_b_normal", { fg = c.fg1, bg = c.bg3 })
  hl("lualine_c_normal", { fg = c.fg2, bg = c.bg2 })
end

return M
