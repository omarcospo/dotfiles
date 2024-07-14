return {
	{
		"MeanderingProgrammer/markdown.nvim",
		name = "render-markdown",
		ft = "markdown",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("render-markdown").setup({
				file_types = { "markdown" },
				headings = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },
				highlights = {
					heading = { backgrounds = "Normal" },
					bullet = "Normal",
					table = { head = "Normal" },
				},
			})
		end,
	},
	{
		"jmbuhr/otter.nvim",
		ft = "markdown",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {},
		config = function()
			require("otter").setup({ set_filetype = true })
			vim.g.markdown_fenced_languages = { "python" }
		end,
	},
}
