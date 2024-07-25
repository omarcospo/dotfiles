return {
	"folke/zen-mode.nvim",
	version = false,
	cmd = "ZenMode",
	init = function()
		vim.keymap.set("n", "<leader>tt", "<CMD>ZenMode<CR>")
	end,
}
