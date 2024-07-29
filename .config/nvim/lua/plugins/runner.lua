return {
	{
		"Vigemus/iron.nvim",
		ft = "python",
		config = function()
			local iron = require("iron.core")
			local view = require("iron.view")

			iron.setup({
				config = {
					scratch_repl = true,
					repl_definition = {
						sh = { command = { "zsh" } },
						python = {
							command = { vim.g.python3_host_prog },
							format = require("iron.fts.common").bracketed_paste_python,
						},
					},
					repl_open_cmd = view.split.vertical.botright("50%"),
				},
				keymaps = {
					send_motion = "<localleader>sc",
					visual_send = "<localleader>sc",
					send_file = "<localleader>sf",
					send_line = "<localleader>sl",
					send_paragraph = "<localleader>sp",
					send_until_cursor = "<localleader>su",
					send_mark = "<localleader>sm",
					mark_motion = "<localleader>mc",
					mark_visual = "<localleader>mc",
					remove_mark = "<localleader>md",
					cr = "<localleader>s<cr>",
					interrupt = "<localleader>s<localleader>",
					exit = "<localleader>sq",
					clear = "<localleader>cl",
				},
				highlight = {
					italic = true,
				},
				ignore_blank_lines = true,
			})
			vim.keymap.set("n", "<localleader>rs", "<cmd>IronRepl<cr>")
			vim.keymap.set("n", "<localleader>rr", "<cmd>IronRestart<cr>")
			vim.keymap.set("n", "<localleader>rf", "<cmd>IronFocus<cr>")
			vim.keymap.set("n", "<localleader>rh", "<cmd>IronHide<cr>")
		end,
	},
}
