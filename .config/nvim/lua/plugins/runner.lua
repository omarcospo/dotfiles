return {
	"michaelb/sniprun",
	version = false,
	branch = "master",
	build = "sh install.sh",
	config = function()
		require("sniprun").setup({
			selected_interpreters = { "Python3_fifo" },
			repl_enable = { "Python3_fifo" },
			display = { "VirtualText" },
			interpreter_options = {
				Python3_fifo = { interpreter = vim.g.python3_host_prog },
			},
		})
		vim.keymap.set("v", "<CR>", ":'<,'>SnipRun<CR>", { silent = true })
	end,
}
