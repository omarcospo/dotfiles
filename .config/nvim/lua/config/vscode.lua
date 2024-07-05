--- Indentation
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true --- spaces to tab
vim.opt.smartcase = true --- don't ignore case with capitals
vim.opt.smartindent = true --- insert indents automatically
vim.opt.preserveindent = true
--- Copy/Paste
vim.opt.clipboard = "unnamedplus" --- copy/paste to system clipboard
vim.opt.copyindent = true -- Copy the previous indentation on autoindenting.
vim.opt.virtualedit = "block" -- Allow going past end of line in visual block mode.

vim.g.mapleader = " "
vim.g.maplocalleader = " "
local function map(mode, key, action)
  vim.keymap.set(mode, key, ":call VSCodeNotify('" .. action .. "')<CR>")
end
map("n", "<leader><leader>", "workbench.action.showCommands")
--- File
map("n", "<leader>fs", "workbench.action.files.save")
map({ "n", "x" }, "<leader>wj", "workbench.action.navigateDown")
map({ "n", "x" }, "<leader>wk", "workbench.action.navigateUp")
map({ "n", "x" }, "<leader>wh", "workbench.action.navigateLeft")
map({ "n", "x" }, "<leader>wl", "workbench.action.navigateRight")
---- Goto begin and end of line
vim.keymap.set("n", "<C-l>", "$")
vim.keymap.set("n", "<C-h>", "0")
---- Move lines
vim.keymap.set("n", "<C-j>", "<cmd>m .+1<cr>==")
vim.keymap.set("n", "<C-k>", "<cmd>m .-2<cr>==")
vim.keymap.set("v", "<C-j>", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "<C-k>", ":m '<-2<cr>gv=gv")

vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
