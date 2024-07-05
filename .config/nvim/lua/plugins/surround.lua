return {
	"echasnovski/mini.surround",
	event = "BufReadPost",
	config = function()
		require("mini.surround").setup()
	end,
}
