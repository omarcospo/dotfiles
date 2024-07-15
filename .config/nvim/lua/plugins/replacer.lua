return {
	"chrisgrieser/nvim-rip-substitute",
	cmd = "RipSubstitute",
	opts = {
		popupWin = {
			title = "Replace",
			border = "rounded",
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
}
