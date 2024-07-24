return {
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
}
