local map = vim.keymap.set

-- Disable page up and down keys when in insert mode
map("i", "<PageUp>", "<Nop>", { desc = "Disable PageUp" })
map("i", "<PageDown>", "<Nop>", { desc = "Disable PageDown" })
-- better indenting
map("x", "<", "<gv")
map("x", ">", ">gv")
-- move lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
-- Clear search on esc
map({ "n" }, "<esc>", function()
  vim.cmd("noh")
end, { desc = "Clear search highlights" })
-- Function to append character at the end of the line
map("n", "<leader>a", function()
  local char = vim.fn.nr2char(vim.fn.getchar())
  if char:match("[%z\27]") then return end
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()
  vim.api.nvim_set_current_line(line .. char)
  vim.api.nvim_win_set_cursor(0, cursor)
end, { desc = "Append character at end of line" })

---- Buffers
-- move between buffers
map("n", "<PageDown>", ":bnext<CR>", { desc = "Switch to next buffer", noremap = true, silent = true })
map("n", "<PageUp>", ":bprev<CR>", { desc = "Switch to previous buffer", noremap = true, silent = true })
map("n", "<tab>", ":bnext<CR>", { desc = "Switch to next buffer", noremap = true, silent = true })
map("n", "<S-tab>", ":bprev<CR>", { desc = "Switch to previous buffer", noremap = true, silent = true })
-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

---- Terminal mode
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Quit terminal mode" })

---- Code
map('n', '<leader>cd', vim.diagnostic.open_float, { desc = "Show line diagnostics" })
map("n", "<leader>cz", ":w<CR>:term zc run %<CR>", { desc = "Compile and execute C/C++ file" })
map("n", "<leader>cq", ":w<CR>:term zc run -q %<CR>", { desc = "Compile and execute C/C++ file quietly" })
map("n", "<leader>cl", "vip:norm I- <cr>", { desc = "Transform paragraph into bullet list" })
map("n", "<leader>cn", ":lua require('neogen').generate()<cr>", { desc = "Générer Doc (@brief)" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
map("n", "<leader>co", function()
  vim.lsp.buf.code_action({ apply = true, context = { only = { "source.organizeImports" }, diagnostics = {} } })
end, { desc = "Organize imports" })
map("n", "<leader>ch", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clangd_client = vim.lsp.get_clients({ bufnr = bufnr, name = "clangd" })[1]
  if clangd_client then
    vim.lsp.buf_request(bufnr, "textDocument/switchSourceHeader", { uri = vim.uri_from_bufnr(bufnr) },
      function(_, result)
        if result then
          vim.api.nvim_command("edit " .. vim.uri_to_fname(result))
        end
      end)
  else
    vim.notify("clangd client not found", vim.log.levels.WARN)
  end
end, { desc = "Switch source/header" })

---- Snacks
-- picker and buffers
map("n", "<leader><space>", function() Snacks.picker.smart() end, { desc = "Smart find files" })
map("n", "<leader>q", function() Snacks.bufdelete() end, { desc = "Delete current buffer" })
map("n", "<leader>bo", function() Snacks.bufdelete.other() end, { desc = "Delete other buffers" })
map("n", "<leader>,", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>:", function() Snacks.picker.command_history() end, { desc = "Command history" })
map("n", "<leader>e", function() Snacks.explorer({ layout = { layout = { position = "right" } }, }) end,
  { desc = "File Explorer" })

-- find
map("n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "Find project" })
map("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent" })
map("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Find file" })
map("n", "<leader>fg", function() Snacks.picker.git_files() end, { desc = "Find git file" })
map("n", "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,
  { desc = "Find config file" })

-- git
map("n", "<leader>gb", function() Snacks.picker.git_branches() end, { desc = "Git branches" })
map("n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "Git log" })
map("n", "<leader>gL", function() Snacks.picker.git_log_line() end, { desc = "Git log line" })
map("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git status" })
map("n", "<leader>gS", function() Snacks.picker.git_stash() end, { desc = "Git stash" })
map("n", "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "Git diff (hunks)" })
map("n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git log file" })
map("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "Lazygit" })
map({ "n", "v" }, "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git browse" })

-- TODO : gh

-- grep / search
map("n", "<leader>/", function() Snacks.picker.grep() end, { desc = "Grep in workspace" })
map("n", "<leader>sb", function() Snacks.picker.lines() end, { desc = "Grep buffer lines" })
map("n", "<leader>sB", function() Snacks.picker.grep_buffers() end, { desc = "Grep lines in open buffers" })
map({ "n", "x" }, "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "Visual selection or word" })
map("n", "<leader>s\"", function() Snacks.picker.registers() end, { desc = "Search registers" })
map("n", "<leader>s/", function() Snacks.picker.search_history() end, { desc = "Search search history" })
map("n", "<leader>sa", function() Snacks.picker.autocmds() end, { desc = "Search autocommands" })
map("n", "<leader>sc", function() Snacks.picker.commands() end, { desc = "Search commands" })
map("n", "<leader>sC", function() Snacks.picker.colorschemes() end, { desc = "Search colorschemes" })
map("n", "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "Search diagnostics" })
map("n", "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, { desc = "Search buffer diagnostics" })
map("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "Search help pages" })
map("n", "<leader>sH", function() Snacks.picker.highlights() end, { desc = "Search highlights" })
map("n", "<leader>si", function() Snacks.picker.icons() end, { desc = "Search icons" })
map("n", "<leader>sj", function() Snacks.picker.jumps() end, { desc = "Search jumps" }) -- TODO : what's that ?
map("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Search keymaps" })
map("n", "<leader>sl", function() Snacks.picker.loclist() end, { desc = "Search location list" })
map("n", "<leader>sm", function() Snacks.picker.marks() end, { desc = "Search marks" })
map("n", "<leader>sM", function() Snacks.picker.man() end, { desc = "Search man pages" })
map("n", "<leader>sn", function() Snacks.picker.notifications() end, { desc = "Search notifications history" })
map("n", "<leader>sq", function() Snacks.picker.qflist() end, { desc = "Search quickfix list" })
-- map("n", "<leader>sr", function() Snacks.picker.resume() end, { desc = "Search resume" })
map("n", "<leader>su", function() Snacks.picker.undo() end, { desc = "Search undo history" })

-- LSP
map("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "Search LSP symbols" })
map("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "Search workspace LSP symbols" })
map("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto definition" })
map("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Goto declaration" })
map("n", "gr", function() Snacks.picker.lsp_references() end, { nowait = true, desc = "References" })
map("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Goto implementation" })
map("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto type definition" })
map("n", "gai", function() Snacks.picker.lsp_incoming_calls() end, { desc = "Calls incoming" })
map("n", "gao", function() Snacks.picker.lsp_outgoing_calls() end, { desc = "Calls outgoing" })

-- other snacks stuff
map("n", "<leader>z", function() Snacks.zen() end, { desc = "Toggle zen mode" })
map("n", "<leader>Z", function() Snacks.zen.zoom() end, { desc = "Toggle zoom" }) -- TODO : ???
map("n", "<leader>.", function() Snacks.scratch() end, { desc = "Toggle scratch buffer" })
map("n", "<leader>s.", function() Snacks.scratch.select() end, { desc = "Select scratch buffer" })
map("n", "<leader>ns", function() Snacks.notifier.show_history() end, { desc = "Notification history" })
map("n", "<leader>nh", function() Snacks.notifier.hide() end, { desc = "Dismiss all notifications" })
