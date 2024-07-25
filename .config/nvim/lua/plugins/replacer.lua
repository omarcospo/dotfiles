return {
	{
		"chrisgrieser/nvim-rip-substitute",
		cmd = "RipSubstitute",
		opts = {
			popupWin = {
				title = "Replace",
				border = "single",
				position = "top",
			},
		},
		keys = {
			{
				"<leader>e",
				function()
					require("rip-substitute").sub()
				end,
				mode = { "n", "x" },
			},
		},
	},
	{
		"MagicDuck/grug-far.nvim",
		keys = {
			{
				"<leader>r",
				function()
					require("grug-far").grug_far({ transient = true })
				end,
				mode = { "n", "x" },
			},
		},
		config = function()
			require("grug-far").setup({
				keymaps = {
					replace = { n = "<C-Return>" },
					close = { n = "q" },
					refresh = { n = "r" },
				},
			})
		end,
	},
}
