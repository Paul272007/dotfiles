return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui", -- L'interface graphique (fenêtres, variables, console...)
    "nvim-neotest/nvim-nio", -- Dépendance requise pour dap-ui
    "jay-babu/mason-nvim-dap.nvim", -- Installe automatiquement les débogueurs
  },
  keys = {
    { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<F10>", function() require("dap").step_over() end, desc = "Step Over" },
    { "<F11>", function() require("dap").step_into() end, desc = "Step Into" },
    { "<F12>", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Start/Continue Debugging" },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    require("mason-nvim-dap").setup({
      automatic_installation = true,
      ensure_installed = { "python", "js" }, -- Installe debugpy (python) et js-debug-adapter (node/chrome)
      handlers = {}, 
    })

    dapui.setup()

    -- Ouvre l'interface automatiquement quand on lance le débug
    dap.listeners.before.attach.dapui_config = function() dapui.open() end
    dap.listeners.before.launch.dapui_config = function() dapui.open() end
    dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
    dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
  end,
}
