return {
	"echasnovski/mini.hipatterns",
	version = false,
	lazy = true,
	config = function()
		local hipatterns = require("mini.hipatterns")
		hipatterns.setup({
			highlighters = {
				hex_color = hipatterns.gen_highlighter.hex_color(),
			},
		})
	end,
}
