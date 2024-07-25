return {
	"cappyzawa/trim.nvim",
	version = false,
	event = "BufWrite",
	opts = {
		trim_on_write = true,
		trim_trailing = true,
		trim_last_line = true,
		trim_first_line = true,
	},
}
