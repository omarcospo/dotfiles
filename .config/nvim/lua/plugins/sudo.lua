return {
	"lambdalisue/vim-suda",
	version = false,
	cmd = { "SudaRead", "SudaWrite" },
	init = function()
		vim.g.suda_smart_edit = 1
	end,
}
