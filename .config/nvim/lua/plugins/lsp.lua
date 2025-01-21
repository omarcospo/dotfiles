return {
	{
		"neovim/nvim-lspconfig",
		version = false,
		dependencies = {
			{ "LukasPietzschmann/boo.nvim" },
		},
		init = function()
			vim.keymap.set("n", "gd", "<cmd>lua require('boo').boo()<CR>")
			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.INFO] = "",
						[vim.diagnostic.severity.HINT] = "",
					},
				},
			})
		end,
		config = function()
			local lsp = require("lspconfig")
			lsp.pyright.setup({
				cmd = { vim.fn.expand("~/.local/python/bin/pyright-langserver"), "--stdio" },
				settings = {
					python = {
						pythonPath = vim.g.python3_host_prog,
						analysis = {
							logLevel = "Error",
						},
					},
				},
			})
		end,
	},
	{
		"luckasRanarison/clear-action.nvim",
		version = false,
		event = "LspAttach",
		opts = {
			signs = {
				icons = {
					quickfix = "󰒓 ",
					refactor = " ",
					source = " ",
					combined = " ",
				},
			},
			popup = {
				enable = true,
				border = "single",
				hide_cursor = true,
				hide_client = true,
			},
			mappings = {
				code_action = "ga",
				apply_first = "gf",
				quickfix = "gq",
			},
		},
	},
	{
		"folke/trouble.nvim",
		version = false,
		event = "LspAttach",
		cmd = "Trouble",
		keys = {
			{ "tt", "<CMD>Trouble lsp_document_symbols toggle focus=false win.position=left filter.buf=0<CR>" },
		},
		opts = {
			auto_close = true,
			auto_preview = true,
			auto_refresh = true,
			auto_jump = true,
			focus = true,
			restore = true,
			follow = true,
			indent_guides = false,
			max_items = 200,
			multiline = false,
			warn_no_results = false,
			open_no_results = false,
			icons = {
				indent = { middle = "", last = "", top = "", ws = "" },
			},
		},
	},
	{
		"smjonas/inc-rename.nvim",
		version = false,
		event = "LspAttach",
		config = function()
			require("inc_rename").setup({})
		end,
		keys = {
			{ "gr", ":IncRename " },
		},
	},
}
