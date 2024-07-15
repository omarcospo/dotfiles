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
}
return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		opts = { ensure_installed = filetypes },
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = filetypes,
				callback = function(event)
					vim.cmd("TSBufEnable highlight")
				end,
			})
		end,
	},
}
