vim.opt.title = true -- set terminal title
vim.opt.cmdheight = 0
vim.opt.laststatus = 0
vim.opt.showcmd = false
vim.opt.ruler = false
vim.opt.inccommand = "split"
--- Session
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
vim.opt.autochdir = true
vim.opt.swapfile = false
vim.g.big_file = { size = 1024 * 100, lines = 10000 } -- For files bigger than this, disable 'treesitter' (+100kb).
vim.g.autoread = true
vim.opt.showtabline = 0
--- Split
vim.opt.splitright = true --- put new vertical splits to right
vim.opt.splitbelow = true --- put new horizontal splits below current
vim.opt.splitkeep = "screen"
--- Mouse
vim.g.mousemoveement = true
---- Typing
vim.opt.updatetime = 250 --- completion faster
vim.opt.backspace:append({ "nostop" }) -- Don't stop backspace at insert.
---- History
vim.opt.history = 100 -- Number of commands to remember in a history table (per buffer).
--- Wraping
vim.opt.wrap = false -- Disable wrapping of lines longer than the width of window.
vim.opt.colorcolumn = "80" -- PEP8 like character limit vertical bar.
--- Indentation
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true --- spaces to tab
vim.opt.smartcase = true --- don't ignore case with capitals
vim.opt.smartindent = true --- insert indents automatically
vim.opt.preserveindent = true
--- Status Line
--- Copy/Paste
vim.opt.clipboard = "unnamedplus" --- copy/paste to system clipboard
vim.opt.copyindent = true -- Copy the previous indentation on autoindenting.
vim.opt.virtualedit = "block" -- Allow going past end of line in visual block mode.
--- Scrolling
vim.opt.lazyredraw = false --- faster scrolling
vim.opt.scrolloff = 1000 -- Number of lines to leave before/after the cursor when scrolling. Setting a high value keep the cursor centered.
vim.opt.sidescrolloff = 8 -- Same but for side scrolling.
vim.opt.smoothscroll = true
vim.opt.mousescroll = "ver:1,hor:0" -- Disables hozirontal scroll in neovim.
--- Highlighting
vim.opt.synmaxcol = 240 --- max column for syntax highlight Indentation - Width of a tab
vim.opt.conceallevel = 3 --- hide markup
--- Gutter Signs
vim.opt.signcolumn = "yes"
vim.opt.numberwidth = 3
vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ", --- disable `~` on nonexistent lines.
  stl = "─",
  stlnc = "─",
}
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
--- Line Numbers
vim.opt.number = true --- show line numbers Window vim.opt.splitbelow = true --- put new windows below current
--- Undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.config/nvim/.undo")
--- Backups
vim.opt.backup = false --- this is recommended by coc
vim.opt.writebackup = false --- this is recommended by coc
--- CursosLine
vim.opt.cursorline = false
vim.opt.showmode = false -- Dont show mode since we have a statusline
--- Neovide
vim.opt.linespace = 0
if vim.g.neovide then
  --- Fonts
  vim.opt.guifont = "IosevkaTerm_Nerd_Font:h15"
  vim.g.neovide_theme = "dark"
  vim.g.neovide_fullscreen = true
  --- Cursor and mouse
  vim.g.neovide_cursor_trail_size = 0.4
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_unlink_border_highlights = true
  --- Scroll
  vim.g.neovide_scroll_animation_length = 0.1
  vim.g.neovide_scroll_animation_far_lines = 5
  --- Window Padding
  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_left = 0
  --- Floating
  vim.g.neovide_floating_shadow = false
  vim.g.neovide_floating_blur_amount_y = 0.0
  vim.g.neovide_floating_blur_amount_x = 0.0
  --- Keymaps
  --- Paste like terminal
  vim.keymap.set("n", "<sc-v>", 'l"+P', { noremap = true })
  vim.keymap.set("v", "<sc-v>", '"+P', { noremap = true })
  vim.keymap.set("c", "<sc-v>", '<C-o>l<C-o>"+<C-o>P<C-o>l', { noremap = true })
  vim.keymap.set("t", "<sc-v>", '<C-\\><C-n>"+Pi', { noremap = true }) --- Scaling vim.g.neovide_scale_factor = 1.0
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
vim.opt.selection = "old" -- Don't select the newline symbol when using <End> on visual mode.
-- clean mappings
vim.o.timeoutlen = 500 --- keychord delay timeout
---- Set <leader> key to <SPACE>
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.filetype.add({
  filename = { [".zshrc"] = "sh" },
})
