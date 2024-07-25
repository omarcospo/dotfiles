vim.opt.title = true
vim.opt.cmdheight = 0
vim.opt.laststatus = 0
vim.opt.showcmd = false
vim.opt.ruler = false
vim.opt.inccommand = "split"
--- Session
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
vim.opt.autochdir = true
vim.opt.swapfile = false
vim.g.big_file = { size = 1024 * 100, lines = 10000 }
vim.g.autoread = true
vim.opt.showtabline = 0
--- Split
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
--- Mouse
vim.g.mousemoveement = true
---- Typing
vim.opt.updatetime = 250
vim.opt.backspace:append({ "nostop" })
---- History
vim.opt.history = 100
--- Wraping
vim.opt.wrap = false
vim.opt.colorcolumn = "80"
--- Indentation
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.preserveindent = true
--- Status Line
--- Copy/Paste
vim.opt.clipboard = "unnamedplus"
vim.opt.copyindent = true
vim.opt.virtualedit = "block"
--- Scrolling
vim.opt.lazyredraw = false
vim.opt.scrolloff = 1000
vim.opt.sidescrolloff = 8
vim.opt.smoothscroll = true
vim.opt.mousescroll = "ver:1,hor:0"
--- Highlighting
vim.opt.synmaxcol = 240
vim.opt.conceallevel = 3
--- Gutter Signs
vim.opt.signcolumn = "yes"
vim.opt.numberwidth = 3
vim.opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
	stl = "─",
	stlnc = "─",
}
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
--- Line Numbers
vim.opt.number = true
--- Undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.config/nvim/.undo")
--- Backups
vim.opt.backup = false
vim.opt.writebackup = false
--- CursosLine
vim.opt.cursorline = false
vim.opt.showmode = false
--- Neovide
vim.opt.linespace = 0
if vim.g.neovide then
	vim.opt.guifont = "Iosevka_Nerd_Font:h15"
	vim.g.neovide_theme = "dark"
	-- vim.g.neovide_fullscreen = true

	vim.g.neovide_cursor_trail_size = 0.4
	vim.g.neovide_hide_mouse_when_typing = true
	vim.g.neovide_unlink_border_highlights = true

	vim.g.neovide_scroll_animation_length = 0.1
	vim.g.neovide_scroll_animation_far_lines = 5

	vim.g.neovide_padding_top = 0
	vim.g.neovide_padding_bottom = 0
	vim.g.neovide_padding_right = 0
	vim.g.neovide_padding_left = 0

	vim.g.neovide_floating_shadow = false
	vim.g.neovide_floating_blur_amount_y = 0.0
	vim.g.neovide_floating_blur_amount_x = 0.0

	vim.keymap.set("n", "<sc-v>", 'l"+P', { noremap = true })
	vim.keymap.set("v", "<sc-v>", '"+P', { noremap = true })
	vim.keymap.set("c", "<sc-v>", '<C-o>l<C-o>"+<C-o>P<C-o>l', { noremap = true })
	vim.keymap.set("t", "<sc-v>", '<C-\\><C-n>"+Pi', { noremap = true })
	local change_scale_factor = function(delta)
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
		vim.cmd("redraw!")
	end
	vim.keymap.set("n", "<C-=>", function()
		change_scale_factor(1.05)
	end)
	vim.keymap.set("n", "<C-->", function()
		change_scale_factor(1 / 1.05)
	end)
end
---- Python
vim.g.python3_host_prog = vim.fn.expand("~/.local/python/bin/python")
---- Other filetypes
vim.filetype.add({ extension = { typ = "typst" } })
---- End of line
vim.opt.selection = "old"
-- clean mappings
vim.o.timeoutlen = 500
---- Set <leader> key to <SPACE>
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.filetype.add({ filename = { [".zshrc"] = "sh", ["config"] = "json" } })
