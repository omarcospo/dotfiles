return {
	"stevearc/conform.nvim",
	event = "BufReadPre",
	dependencies = {
		"williamboman/mason.nvim",
		"zapling/mason-conform.nvim",
	},
	config = function()
		require("conform").setup({
			format_on_save = {
				timeout_ms = 200,
				lsp_fallback = false,
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
			},
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
				html = { "prettier" },
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
	end,
}
