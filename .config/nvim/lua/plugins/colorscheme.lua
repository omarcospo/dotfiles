return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				overrides = {
					StatusLine = { bg = "#151515" },
					NormalFloat = { bg = "NONE" },
					FloatBorder = { bg = "NONE" },
					WinSeparator = { bg = "NONE" },
					SignColumn = { bg = "NONE" },
				},
				dim_inactive = false,
			})
			vim.cmd("colorscheme gruvbox")
		end,
	},
}
