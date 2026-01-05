-- On définit notre touche leader sur espace
vim.g.mapleader = " "

-- Raccourci pour la fonction set
local keymap = vim.keymap.set

-- on efface le surlignage de la recherche
keymap("n", "<leader>nh", ":nohl<CR>", { desc = "Effacer le surlignage de la recherche", noremap = true, silent = true })

-- I déplace le texte sélectionné vers le haut en mode visuel (activé avec v)
keymap("v", "<S-i>", ":m .-2<CR>==",
  { desc = "Déplace le texte sélectionné vers le haut en mode visuel", noremap = true, silent = true })
-- K déplace le texte sélectionné vers le bas en mode visuel (activé avec v)
keymap("v", "<S-k>", ":m .+1<CR>==",
  { desc = "Déplace le texte sélectionné vers le bas en mode visuel", noremap = true, silent = true })

-- I déplace le texte sélectionné vers le haut en mode visuel bloc (activé avec V)
keymap("x", "<S-i>", ":move '<-2<CR>gv-gv",
  { desc = "Déplace le texte sélectionné vers le haut en mode visuel bloc", noremap = true, silent = true })
-- K déplace le texte sélectionné vers le bas en mode visuel (activé avec V)
keymap("x", "<S-k>", ":move '>+1<CR>gv-gv",
  { desc = "Déplace le texte sélectionné vers le bas en mode visuel bloc", noremap = true, silent = true })

-- Changement de fenêtre (split) avec Ctrl + déplacement uniquement au lieu de Ctrl-w + déplacement
keymap("n", "<C-h>", "<C-w>h", { desc = "Déplace le curseur dans la fenêtre de gauche" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Déplace le curseur dans la fenêtre du bas" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Déplace le curseur dans la fenêtre du haut" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Déplace le curseur dans la fenêtre droite" })

-- Navigation entre les buffers
-- keymap("n", "<S-l>", ":bnext<CR>", opts)
-- keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true })
keymap('n', '<S-Tab>', ':bprev<CR>', { noremap = true, silent = true })
keymap('n', '<Del>', ':bdelete<CR>', { desc = 'Fermer le buffer', noremap = true, silent = true })
keymap('n', '<leader>bd', ':bdelete!<CR>', { desc = 'Fermer le buffer', noremap = true, silent = true })

-- Sortir du mode terminal
keymap('t', '<Esc>', '<C-\\><C-n>', { desc = "Quitter le mode terminal" })

-- compiler et exécuter le fichier actuel (C)
keymap("n", "<F5>", ':w<CR>:term zc run %<CR>', { desc = "Compile et exécute le code source en C avec zc." })

-- Désactiver PageUp et PageDown en mode insertion (éviter les erreurs de frappe)
keymap("i", "<PageUp>", "<Nop>", { desc = "Disable PageUp" })
keymap("i", "<PageDown>", "<Nop>", { desc = "Disable PageDown" })

keymap("n", "<leader>rn", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })

-- Dans votre fichier de keymaps (par exemple lua/config/keymaps.lua)
keymap("n", "<leader>ct", "<cmd>Copilot toggle<CR>", { desc = "Toggle Copilot" })

keymap("n", "<leader>;", "mqA;<esc>`q", { desc = "Ajouter ';' à la fin de la ligne" })
keymap("n", "<leader>,", "mqA,<esc>`q", { desc = "Ajouter ',' à la fin de la ligne" })
