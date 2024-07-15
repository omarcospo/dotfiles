return {
	"smoka7/hop.nvim",
	version = false,
	cmd = { "HopChar1" },
	opts = {
		keys = "etovxqpdygfblzhckisuran",
		current_line_only = false,
	},
	keys = {
		{ "f", "<CMD>HopWord<CR>" },
		{ "s", "<CMD>HopPattern<CR>" },
	},
	config = function()
		require("hop").setup({})
	end,
}
