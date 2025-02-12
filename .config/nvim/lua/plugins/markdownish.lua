return {
	-- {
	-- 	"MeanderingProgrammer/markdown.nvim",
	-- 	name = "render-markdown",
	-- 	ft = "markdown",
	-- 	dependencies = { "nvim-treesitter/nvim-treesitter" },
	-- 	config = function()
	-- 		require("render-markdown").setup({
	-- 			file_types = { "markdown" },
	-- 			headings = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },
	-- 			highlights = {
	-- 				heading = { backgrounds = "Normal" },
	-- 				bullet = "Normal",
	-- 				table = { head = "Normal" },
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		"OXY2DEV/markview.nvim",
		lazy = false,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
}
