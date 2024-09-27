return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local treesitter = require("nvim-treesitter.configs")
			local filetypes = {
				"yaml",
				"xml",
				"vimdoc",
				"vim",
				"typst",
				"typescript",
				"tsx",
				"toml",
				"svelte",
				"regex",
				"query",
				"python",
				"printf",
				"org",
				"markdown_inline",
				"markdown",
				"luap",
				"luadoc",
				"lua",
				"jsonc",
				"json",
				"jsdoc",
				"javascript",
				"hyprlang",
				"htmldjango",
				"html",
				"go",
				"diff",
				"css",
				"c",
				"bash",
			}
			---@diagnostic disable-next-line
			treesitter.setup({
				ensure_installed = filetypes,
				sync_install = false,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		version = false,
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true,
					enable_rename = true,
				},
			})
		end,
	},
	{
		"Jay-Madden/auto-fix-return.nvim",
		config = function()
			require("auto-fix-return").setup({})
		end,
	},
}
