return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status")

    --[[ Fonction pour la couleur (Bleu = Actif, Gris = Inactif)
    local function copilot_color()
      local ok, client = pcall(require, "copilot.client")
      -- On vérifie s'il est actif sur le buffer courant
      if ok and not client.is_disabled() then
        return { fg = "#62d6e6" } -- Bleu brillant
      end
      return { fg = "#565f89" }   -- Gris sombre
    end

    --[[ Fonction de statut améliorée
    local function copilot_status()
      -- Vérifie si copilot.lua est chargé
      local ok, copilot_api = pcall(require, "copilot.api")
      if not ok then
        return "" -- Icône barrée si le plugin n'est pas chargé
      end

      -- Récupère le statut de Copilot
      local status = copilot_api.status.data
      -- Affiche l'icône selon le statut
      if status and status.status then
        if status.status == "Normal" or status.status == "InProgress" then
          return " " -- Icône Robot (nécessite Nerd Font)
        elseif status.status == "Warning" then
          return " " -- Icône Robot avec warning
        else
          return " " -- Icône Robot barré ou endormi (optionnel)
        end
      end

      -- Par défaut, affiche l'icône barrée
      return " " -- Icône Robot barré ou endormi (optionnel)
    end

    -- Fonction pour la couleur de l'icône
    local function copilot_color()
      local ok, copilot_api = pcall(require, "copilot.api")
      if not ok then return { fg = "#565f89" } end

      local status_data = copilot_api.status.data
      if status_data.status == "Normal" then
        return { fg = "#62d6e6" } -- Bleu brillant (Actif)
      elseif status_data.status == "InProgress" then
        return { fg = "#ff9e64" } -- Orange (Chargement)
      elseif status_data.status == "Warning" then
        return { fg = "#f7768e" } -- Rouge (Erreur)
      else
        return { fg = "#565f89" } -- Gris (Désactivé)
      end
    end
    ]]

    lualine.setup({
      options = {
        icons_enabled = true,
        theme = "tokyonight",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true, -- Je conseille 'true' pour avoir une seule barre en bas fixe
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          { "encoding" },
          { "fileformat" },
          { "filetype" },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end,
}
