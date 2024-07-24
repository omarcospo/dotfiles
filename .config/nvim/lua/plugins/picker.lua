return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("fzf-lua").setup({
			winopts = {
				on_create = function()
					vim.keymap.set("t", "<C-q>", "<C-c>", { silent = true, buffer = true })
				end,
				preview = {
					layout = "vertical",
					title = false,
					vertical = "down:70%",
				},
			},
			keymap = {
				builtin = {
					["<C-i>"] = "toggle-preview",
					["<C-d>"] = "preview-page-down",
					["<C-u>"] = "preview-page-up",
				},
			},
		})
		vim.keymap.set("n", "s", "<cmd>FzfLua blines<CR>", { silent = true })
		vim.keymap.set("n", "<leader>bb", "<cmd>FzfLua buffers<CR>", { silent = true })
		vim.keymap.set("n", "<leader>a", "<cmd>FzfLua lgrep_curbuf<CR>", { silent = true })
		vim.keymap.set("n", "<leader>s", "<cmd>FzfLua live_grep<CR>", { silent = true })
		vim.keymap.set("n", "<leader>h", "<cmd>FzfLua helptags<CR>", { silent = true })
		vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua oldfiles<CR>", { silent = true })
	end,
}
