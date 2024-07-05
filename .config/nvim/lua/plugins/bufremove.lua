return {
	"echasnovski/mini.bufremove",
	event = "BufReadPost",
	config = function()
		require("mini.bufremove").setup()
		vim.keymap.set("n", "<leader>bk", function()
			require("mini.bufremove").delete()
		end)
	end,
}
