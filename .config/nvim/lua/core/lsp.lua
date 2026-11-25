local config = vim.lsp.config

-- Add Mason bin directory to PATH if present
local mason_bin = vim.fn.expand("~/.local/share/nvim/mason/bin")
if vim.fn.isdirectory(mason_bin) == 1 and not string.find(vim.env.PATH, mason_bin, 1, true) then
	vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
end

-- Dynamically resolve global TypeScript library path
local function get_typescript_lib()
	local candidates = {
		vim.fn.expand("~/.local/share/nvim/mason/packages/vue-language-server/node_modules/typescript/lib"),
		vim.fn.expand("~/.local/share/nvim/mason/packages/vtsls/node_modules/@vtsls/language-server/node_modules/typescript/lib"),
		vim.fn.expand("~/.local/lib/node_modules/typescript/lib"),
		vim.fn.trim(vim.fn.system("npm root -g")) .. "/typescript/lib",
	}
	for _, path in ipairs(candidates) do
		if vim.fn.filereadable(path .. "/tsserver.js") == 1 then
			return path
		end
	end
	return nil
end

local global_ts_lib = get_typescript_lib()

config("clangd", {
	cmd = { "clangd" },
	filetypes = { "c", "h", "cpp", "hpp" },
	root_markers = { ".git" },
})

config("neocmakelsp", {
	cmd = { "neocmakelsp", "stdio" },
	filetypes = { "cmake" },
	root_markers = { ".git" },
})

config("lua_ls", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
	settings = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enabled = false },
			diagnostics = { globals = { "vim" } },
		},
	},
})

config("intelephense", {
	cmd = { "intelephense", "--stdio" },
	filetypes = { "php" },
	root_markers = { "composer.json", ".git" },
})

config("pyright", {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" },
})

config("rust_analyzer", {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = { "Cargo.toml", ".git" },
})

config("bashls", {
	cmd = { "bash-language-server", "start" },
	filetypes = { "bash", "sh" },
	root_markers = { ".git" },
})

config("cssls", {
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css" },
	root_markers = { ".git" },
})

config("html", {
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = { "html" },
	root_markers = { ".git" },
})

config("ts_ls", {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
	init_options = global_ts_lib and {
		tsserver = {
			path = global_ts_lib .. "/tsserver.js", -- Direct path to tsserver.js
		},
	} or nil,
})

config("volar", {
	cmd = { "vue-language-server", "--stdio" },
	filetypes = { "vue" },
	root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
	init_options = {
		typescript = {
			tsdk = global_ts_lib,
		},
		vue = {
			hybridMode = false,
		},
	},
})

config("jdtls", {
	cmd = { "jdtls" },
	filetypes = { "java" },
	root_markers = { "pom.xml", "build.gradle", "build.gradle.kts", ".git" },
})

-- Enable all configured LSP servers
vim.lsp.enable({
	"clangd",
	"neocmakelsp",
	"lua_ls",
	"intelephense",
	"pyright",
	"rust_analyzer",
	"bashls",
	"cssls",
	"html",
	"ts_ls",
	"volar",
	"jdtls",
})

-- Diagnostic configuration
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
	virtual_text = {
		spacing = 4,
		prefix = "●",
	},
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = signs.Error,
			[vim.diagnostic.severity.WARN] = signs.Warn,
			[vim.diagnostic.severity.HINT] = signs.Hint,
			[vim.diagnostic.severity.INFO] = signs.Info,
		},
	},
})
