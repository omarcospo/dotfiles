return {
	"stevearc/conform.nvim",
	version = false,
	dependencies = {
		"williamboman/mason.nvim",
		"zapling/mason-conform.nvim",
	},
	config = function()
		require("conform").setup({
			format_on_save = {
				timeout_ms = 500000,
				lsp_fallback = true,
			},
			formatters = {
				gofumpt = {
					command = "gofumpt",
					args = { "$FILENAME" },
					stdin = false,
				},
				typstfmt = {
					inherit = false,
					command = "typstfmt",
					args = { "$FILENAME" },
					stdin = false,
				},
				djlint = {
					inherit = false,
					command = "djlint",
					args = {
						"--reformat",
						"--format-css",
						"--format-js",
						--"--indent-css",
						--"1",
						--"--indent-js",
						--"1",
						"--max-line-length",
						"80",
						"--indent",
						"0",
						-- "--quiet",
						"$FILENAME",
					},
					stdin = false,
				},
			},
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				html = { "prettier" },
				htmldjango = { "djlint" },
				typescript = { "biome" },
				javascript = { "biome" },
				json = { "biome" },
				css = { "prettier" },
				scss = { "prettier" },
				go = { "gofumpt", "goimports-reviser", "golines" },
				markdown = { "mdformat" },
				sh = { "shellcheck" },
				typst = { "typstfmt" },
			},
		})
		require("mason-conform").setup()
		-- Create an autocmd for Svelte files
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.svelte",
			callback = function()
				vim.cmd("silent !prettier --plugin prettier-plugin-svelte --write " .. vim.fn.expand("%"))
			end,
		})
	end,
}
