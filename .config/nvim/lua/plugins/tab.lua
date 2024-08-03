return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					separator_style = "slope",
					sort_by = "relative_directory",
					show_close_icon = true,
					show_buffer_close_icons = false,
				},
			})
		end,
	},
	{
		"sontungexpt/sttusline",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		event = { "BufEnter" },
		config = function(_, opts)
			require("sttusline").setup({
				statusline_color = "StatusLine",
				laststatus = 3,
				disabled = {
					filetypes = {
						-- "NvimTree",
						"lazy",
					},
					buftypes = {
						"terminal",
					},
				},
				components = {
					"filename",
					"git-branch",
					"%=",
					"diagnostics",
					"lsps-formatters",
				},
			})
		end,
	},
}
