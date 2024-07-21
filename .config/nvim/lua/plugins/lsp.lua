return {
	{
		"neovim/nvim-lspconfig",
		ft = { "python", "go", "typescript", "lua" },
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			"zeioth/garbage-day.nvim",
			"LukasPietzschmann/boo.nvim",
		},
		init = function()
			local lsp = vim.lsp
			lsp.handlers["$/progress"] = function() end
			lsp.handlers["window/logMessage"] = function() end
			lsp.handlers["window/showMessage"] = function() end
			vim.keymap.set("i", "<c-s>", function()
				vim.lsp.buf.signature_help()
			end, { buffer = true })
			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers["signature_help"], {
				border = "rounded",
				close_events = { "CursorMoved", "BufHidden", "InsertCharPre" },
			})
			vim.keymap.set("n", "gd", "<cmd>lua require('boo').boo()<CR>")
			require("garbage-day").setup({
				aggressive_mode = false,
				grace_period = (60 * 15),
				wakeup_delay = 3000,
				notifications = false,
				retries = 3,
				timeout = 1000,
			})
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
			local servers = {
				lua_ls = {
					Lua = {
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
					},
				},
				gopls = {
					gopls = {
						gofumpt = true,
						usePlaceholders = true,
						analyses = {
							fieldalignment = false,
							nilness = true,
							unusedparams = true,
							unusedwrite = true,
							useany = true,
						},
						codelenses = {
							gc_details = false,
							generate = true,
							regenerate_cgo = true,
							run_govulncheck = true,
							test = true,
							tidy = true,
							upgrade_dependency = true,
							vendor = true,
						},
						hints = {
							rangeVariableTypes = true,
							parameterNames = false,
							constantValues = true,
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							functionTypeParameters = true,
						},
					},
				},
				jedi_language_server = {},
				typst_lsp = {
					exportPdf = "onType",
					format = {
						formatting_options = nil,
						timeout_ms = nil,
					},
				},
				tsserver = {},
				html = {},
			}

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			local mason_lspconfig = require("mason-lspconfig")

			mason_lspconfig.setup({
				ensure_installed = vim.tbl_keys(servers),
			})
			mason_lspconfig.setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = servers[server_name],
					})
				end,
			})
		end,
	},
	{
		"MysticalDevil/inlay-hints.nvim",
		event = "LspAttach",
		dependencies = {
			"neovim/nvim-lspconfig",
			"felpafel/inlay-hint.nvim",
		},
		config = function()
			require("inlay-hint").setup()
			require("inlay-hints").setup()
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = { library = { "luvit-meta/library" } },
		dependencies = "neovim/nvim-lspconfig",
	},
	{
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			opts.sources = opts.sources or {}
			table.insert(opts.sources, {
				name = "lazydev",
				group_index = 0,
			})
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		ft = "typescript",
		config = function()
			require("typescript-tools").setup({
				settings = {
					complete_function_calls = false,
					include_completions_with_insert_text = false,
					code_lens = "off",
					disable_member_code_lens = false,
					jsx_close_tag = { enable = false },
					--- Inlay Hints
					tsserver_file_preferences = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = false,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayVariableTypeHintsWhenTypeMatchesName = false,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
				},
			})
		end,
	},
	{
		"luckasRanarison/clear-action.nvim",
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
				border = "rounded",
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
		event = "LspAttach",
		cmd = "Trouble",
		keys = {
			-- { "gt", "<CMD>Trouble diagnostics toggle filter.buf=0 focus=true<CR>" },
			-- { "gs", "<CMD>Trouble lsp_references toggle focus=true<CR>" },
			{ "gt", "<CMD>Trouble lsp_document_symbols toggle focus=false win.position=left filter.buf=0<CR>" },
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
		event = "LspAttach",
		config = function()
			require("inc_rename").setup({})
		end,
		keys = {
			{ "gr", ":IncRename " },
		},
	},
}
