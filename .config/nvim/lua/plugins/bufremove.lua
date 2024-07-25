return {
	"echasnovski/mini.bufremove",
	version = false,
	event = "VeryLazy",
	config = function()
		require("mini.bufremove").setup()
		vim.keymap.set("n", "<leader>bk", function()
			require("mini.bufremove").delete()
		end)
	end,
}
