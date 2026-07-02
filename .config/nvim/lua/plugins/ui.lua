local colors = require("themes.main").colors
vim.opt.mousemoveevent = true

-- Icons in bufferline
require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

require("bufferline").setup({
  options = {
    close_command = function(n)
      Snacks.bufdelete(n)
    end,
    right_mouse_command = function(n)
      Snacks.bufdelete(n)
    end,
    left_mouse_command = "buffer %d", -- switch to buffer on click
    middle_mouse_command = nil,       -- disable middle click
    diagnostics = "nvim_lsp",         -- ?
    -- diagnostics_indicator = function(count, level)
    --   local icon = level:match("error") and " " or " "
    --   return " " .. icon .. count
    -- end,
    always_show_bufferline = true, -- show even when only one file is opened
    show_buffer_icons = false,     -- do not show icons
    -- color_icons = true,
    hover = {
      enabled = true,
      delay = 200,
      reveal = { "close" },
    },
    sort_by = "insert_at_end", -- put new buffers at the end
    indicator = {              -- underline current buffer
      style = "underline",
    },
  },

  highlights = {
    background = { -- inactive tabs
      fg = colors.fg3,
      bg = colors.bg1,
    },
    buffer_selected = { -- active tab
      fg = colors.fg0,
      bg = colors.bg2,
      bold = true,
      italic = true,
    },
    indicator_selected = {
      fg = colors.bg2,
      bg = colors.bg2,
    },
    -- Special colors for diagnostics
    hint = {
      bg = colors.bg1,
    },
    info = {
      bg = colors.bg1,
    },
    warning = {
      bg = colors.bg1,
    },
    error = {
      bg = colors.bg1,
    },
    hint_selected = {
      fg = colors.teal,
      bg = colors.bg2,
    },
    info_selected = {
      fg = colors.blue,
      bg = colors.bg2,
    },
    warning_selected = {
      fg = colors.yellow,
      bg = colors.bg2,
    },
    error_selected = {
      fg = colors.red,
      bg = colors.bg2,
    },
    -- Close button & separator & modified indicator bg fits tab bg
    separator = {
      fg = colors.bg1,
    },
    separator_visible = {
      fg = colors.bg1,
    },
    separator_selected = {
      fg = colors.bg2,
    },
    -- diagnostic = {
    --   bg = colors.bg1,
    -- },
    -- diagnostic_selected = {
    --   bg = colors.bg2,
    -- },
    close_button = {
      bg = colors.bg1,
    },
    close_button_selected = {
      bg = colors.bg2,
    },
    modified = {
      fg = colors.green,
      bg = colors.bg1,
    },
    modified_selected = {
      fg = colors.green,
      bg = colors.bg2,
    },
  },
})

-- TODO : add hour and move position from z to y
require("lualine").setup({
  options = {
    theme = require("themes.main").get_lualine_theme(),
    globalstatus = true, -- one lualine for all windows
    component_separators = { left = "╱", right = "╱" },
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = {
      {
        "filename",
        symbols = {
          modified = "[+]",
          readonly = " 󰌾",
          newfile = " 󰝒",
          unnamed = "[No name]",
        },
        padding = { left = 1, right = 1 },
      },
      {
        function()
          local ok, node = pcall(vim.treesitter.get_node)
          if not ok or not node then
            return ""
          end

          local function find_name(n)
            if not n then
              return nil
            end
            local type = n:type()
            if
                type == "identifier"
                or type == "name"
                or type == "field_identifier"
                or type == "type_identifier"
            then
              return vim.treesitter.get_node_text(n, 0)
            end
            for child in n:iter_children() do
              local c_type = child:type()
              -- Exclude the "bodies" of structures/functions to avoid finding internal variables
              if
                  not (
                    c_type:match("list")
                    or c_type:match("block")
                    or c_type:match("body")
                    or c_type:match("statement")
                    or c_type == "compound_statement"
                  )
              then
                local res = find_name(child)
                if res then
                  return res
                end
              end
            end
            return nil
          end

          local current = node
          while current do
            local type = current:type()
            local is_context = type:match("function")
                or type:match("method")
                or type:match("class")
                or type:match("struct")
                or type:match("enum")
                or type:match("union")
                or type:match("interface")
                or type:match("type_definition")
                or type == "subprogram"

            if is_context then
              local name = find_name(current)
              if name then
                local icon = " 󰊕 " -- Default: function
                if type:match("class") or type:match("struct") or type:match("interface") then
                  icon = " 󰠱 "
                elseif type:match("enum") then
                  icon = " 󰦨 "
                elseif type:match("union") then
                  icon = " 󰙅 "
                end
                return icon .. name
              end
            end
            current = current:parent()
          end
          return ""
        end,
        color = { fg = colors.yellow },
        padding = { left = 0, right = 1 },
      },
    },
    lualine_x = { "searchcount", "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
}) -- TODO : configure theme

require("notify").setup({
  background_colour = "#000000",
})
require("noice").setup({
  presets = {
    bottom_search = true,
  },
  views = {
    cmdline_popup = {
      position = {
        row = 5,
        col = "50%",
      },
      size = {
        width = 60,
        height = "auto",
      },
    },
    popupmenu = {
      relative = "editor",
      position = {
        row = 8,
        col = "50%",
      },
      size = {
        width = 60,
        height = 10,
      },
      border = {
        style = "rounded",
        padding = { 0, 1 },
      },
      win_options = {
        winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
      },
    },
  },
}) -- TODO : configure bar height and completion

require("snacks").setup({
  explorer = { enabled = true, replace_netrw = true },
  bigfile = { enabled = true },
  lazygit = { enabled = true },
  dashboard = {
    enabled = true,
    sections = {
      { section = "header" },
      { section = "keys",         gap = 1,                padding = 1 },
      { section = "recent_files", title = "Recent Files", indent = 2, padding = 1 },
      { section = "projects",     title = "Projects",     indent = 2, padding = 1 },
    },
  },
  indent = { enabled = true },
  input = { enabled = true },
  notifier = { enabled = true },
  quickfix = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
  picker = {
    enabled = true,
    ui_select = true,
    sources = {
      explorer = {
        hidden = true,
        ignored = false,
        exclude = { ".git", "node_modules", ".cache", ".DS_Store", "target", "dist", ".idea", "out" },
      },
    },
  },
})

-- require("smear_cursor").setup({
--   smear_insert_mode = false,
-- })
