return {
	{
		"akinsho/toggleterm.nvim",
		version = false,
		cmd = { "ToggleTerm", "TermExec" },
		opts = function()
			return {
				size = function(term)
					if term.direction == "horizontal" then
						return vim.o.lines * 0.4
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.5
					end
				end,
				shade_terminals = false,
				shade_filetypes = {},
				autochdir = true,
				terminal_mappings = true,
				persist_size = true,
				persist_mode = true,
				close_on_exit = true,
				auto_scroll = true,
				direction = "horizontal",
				float_opts = { border = "single" },
				winbar = { enabled = false },
			}
		end,
		init = function()
			vim.keymap.set("n", "<leader>v", "<CMD>ToggleTerm<CR>", { remap = true })
			vim.api.nvim_create_autocmd("TermOpen", {
				pattern = "*",
				callback = function()
					vim.opt_local.cursorline = nocursorline
					vim.opt_local.number = false
					vim.opt_local.relativenumber = false
					vim.opt_local.scrolloff = 0
					vim.keymap.set(
						{ "t", "n" },
						"<C-v>",
						"<C-\\><C-n><cmd>ToggleTerm<CR>",
						{ buffer = true, silent = true }
					)
					vim.keymap.set("t", "<c-q>", "<c-\\><c-n>")
					vim.keymap.set("t", "<esc>", "<c-\\><c-n>")
					vim.cmd("startinsert")
				end,
			})
		end,
	},
}
