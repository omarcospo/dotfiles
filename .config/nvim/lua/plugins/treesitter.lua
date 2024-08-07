return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local treesitter = require("nvim-treesitter.configs")
			local filetypes = {
				"bash",
				"c",
				"diff",
				"html",
				"javascript",
				"svelte",
				"jsdoc",
				"json",
				"go",
				"jsonc",
				"lua",
				"luadoc",
				"luap",
				"css",
				"markdown",
				"markdown_inline",
				"printf",
				"python",
				"query",
				"regex",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
				"typst",
				"org",
			}
			---@diagnostic disable-next-line
			treesitter.setup({ ensure_installed = filetypes })
		end,
	},
}
