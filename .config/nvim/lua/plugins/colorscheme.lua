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
}
