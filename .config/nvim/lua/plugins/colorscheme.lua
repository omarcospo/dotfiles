return {
	{
		"omarcospo/oxocarbon.nvim",
		version = false,
		event = "VimEnter",
		config = function()
			vim.cmd.colorscheme("oxocarbon")
			vim.opt.statusline = '%{repeat("_",winwidth("."))}'
			vim.opt.laststatus = 0
			vim.opt.showcmd = false
			vim.opt.ruler = false
			vim.opt.cmdheight = 0
			vim.opt.shortmess = "csCFSW"
			if not vim.g.neovide then
				vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
			end
		end,
	},
	{
		"xiyaowong/transparent.nvim",
		config = function()
			require("transparent").setup({
				groups = {
					"Normal",
					"NormalNC",
					"Comment",
					"Constant",
					"Special",
					"Identifier",
					"Statement",
					"PreProc",
					"Type",
					"Underlined",
					"Todo",
					"String",
					"Function",
					"Conditional",
					"Repeat",
					"Operator",
					"Structure",
					"LineNr",
					"NonText",
					"SignColumn",
					"CursorLine",
					"CursorLineNr",
					"StatusLine",
					"StatusLineNC",
					"EndOfBuffer",
					"NormalFloat",
					"FloatBorder",
					"WinSeparator",
				},
				extra_groups = {},
				exclude_groups = {},
			})
		end,
	},
}
