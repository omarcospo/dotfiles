return {
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			search = {
				multi_window = false,
				wrap = true,
			},
			jump = {
				nohlsearch = true,
				autojump = true,
			},
		},
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
  },
	},
	{
		"chrisgrieser/nvim-rip-substitute",
		cmd = "RipSubstitute",
		opts = {
			popupWin = {
				border = "rounded",
				position = "top",
			},
		},
		keys = {
			{
				"<leader>e",
				function()
					require("rip-substitute").sub()
				end,
				mode = { "n", "x" },
				desc = " rip substitute",
			},
		},
	},
	{
		"phaazon/hop.nvim",
		version = false,
		cmd = { "HopChar1" },
		opts = { keys = "etovxqpdygfblzhckisuran" },
		keys = {
			{
				"f",
				function()
					require("hop").hint_char1({ current_line_only = false })
				end,
			},
		},
	},
}
