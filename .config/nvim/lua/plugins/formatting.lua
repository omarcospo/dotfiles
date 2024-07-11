return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = { { "<leader>tf", ":lua require('conform').format()<CR>" } },
	opts = {
		formatters = {
			gofumpt = {
				command = "gofumpt",
				args = { "$FILENAME" },
				stdin = false,
			},
			typstyle = {
				inherit = false,
				command = "typstfmt",
				args = { "$FILENAME" },
				stdin = false,
			},
		},
		formatters_by_ft = {
			python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
			html = { "prettier" },
			typescript = { "biome" },
			javascript = { "biome" },
			json = { "biome" },
			css = { "prettier" },
			scss = { "prettier" },
			lua = { "stylua" },
			go = { "gofumpt", "goimports-reviser", "golines" },
			markdown = { "mdformat" },
			sh = { "shellcheck" },
			typst = { "typstyle" },
		},
		notify_on_error = true,
		format_on_save = { timeout_ms = 200, lsp_fallback = false },
	},
}
