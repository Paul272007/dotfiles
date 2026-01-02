local opt = vim.opt -- raccourci pour un peu plus de concision

-- numéros de ligne
opt.number = true -- affiche le numéro absolu de la ligne active lorsque que relativenumber est activé

-- tabs & indentation
opt.tabstop = 2       -- 2 espaces pour les tabulations
opt.shiftwidth = 2    -- 2 espaces pour la taille des indentations
opt.expandtab = true  -- change les tabulations en espaces (don't feed the troll please ;) )
opt.autoindent = true -- on garde l'indentation actuelle à la prochaine ligne
opt.softtabstop = 2   -- 1 appui sur Tab = 2 espaces (et Backspace efface 2 espaces)

-- recherche
opt.ignorecase = true -- ignore la casse quand on recherche
opt.smartcase = true  -- sauf quand on fait une recherche avec des majuscules, on rebascule en sensible à la casse
opt.hlsearch = true   -- surlignage de toutes les occurences de la recherche en cours

-- ligne du curseur
opt.cursorline = true -- surlignage de la ligne active

-- apparence

-- termguicolors est nécessaire pour que les thèmes modernes fonctionnent
opt.termguicolors = true
opt.background = "dark" -- fond noir
opt.signcolumn = "yes"  -- affiche une colonne en plus à gauche pour afficher les signes (évite de décaler le texte)

-- retour
opt.backspace = "indent,eol,start" -- on autorise l'utilisation de retour quand on indente, à la fin de ligne ou au début

-- presse papier
opt.clipboard = "unnamedplus" -- on utilise le presse papier du système par défaut

-- split des fenêtres
opt.splitright = true     -- le split vertical d'une fenêtre s'affiche à droite
opt.splitbelow = true     -- le split horizontal d'une fenêtre s'affiche en bas

opt.swapfile = false      -- on supprime le pénible fichier de swap (aucune idée de ce que c'est)

opt.undofile = true       -- on autorise l'undo à l'infini (même quand on revient sur un fichier qu'on avait fermé)

opt.iskeyword:append("-") -- on traite les mots avec des - comme un seul mot

-- affichage des caractères spéciaux
opt.list = true
opt.listchars:append({ nbsp = "␣", trail = "•", precedes = "«", extends = "»", tab = "> " })

-- les lsp inutiles (je crois)
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Filtre les messages dépréciés inutiles qui polluent l'interface
local default_log_handler = vim.lsp.handlers["window/logMessage"]
vim.lsp.handlers["window/logMessage"] = function(err, result, ctx, config)
  if result and result.message and result.message:find("deprecated") then
    return
  end
  return default_log_handler(err, result, ctx, config)
end

-- Désactive le warning spécifique de dépréciation Lua
vim.deprecate = function() end

vim.o.exrc = true -- Permet à Neovim de lire un fichier .nvim.lua dans le dossier courant
