return {
	"tzachar/highlight-undo.nvim",
	event = "VeryLazy",
	opts = {
		hlgroup = "CurSearch",
		duration = 150,
		keymaps = {
			{ "n", "u", "undo", {} },
			{ "n", "<C-r>", "redo", {} },
		},
	},
	config = function(_, opts)
		require("highlight-undo").setup(opts)
		vim.api.nvim_create_autocmd("TextYankPost", {
			desc = "Highlight yanked text",
			pattern = "*",
			callback = function()
				vim.highlight.on_yank()
			end,
		})
	end,
}
