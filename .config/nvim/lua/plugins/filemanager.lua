return {
	-- local sendEsc = "<C-\\><C-n>i<Esc>"
	{
		"is0n/fm-nvim",
		keys = {
			{ "<Leader>ff", "<CMD>Lf<CR>" },
		},
		config = function()
			require("fm-nvim").setup({
				on_close = {},
				on_open = {
					function()
						vim.keymap.set("t", "<C-q>", "q", { silent = true, buffer = true })
					end,
				},
				ui = {
					default = "float",
					float = {
						border = "rounded",
						height = 0.9,
						width = 0.7,
					},
				},
				mappings = {
					vert_split = "<C-v>",
					horz_split = "<C-h>",
					tabedit = "<C-t>",
					edit = "<C-e>",
					ESC = "<ESC>",
				},
			})
		end,
	},
	{
		"VebbNix/lf-vim",
	},
}
