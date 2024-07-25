--- Bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
--- Configure Lazy
require("lazy").setup({ import = "plugins" }, {
	profiling = { loader = true, require = true },
	defaults = { version = false },
	checker = { enabled = false, norify = false },
	change_detection = { notify = false },
	lockfile = vim.fn.stdpath("cache") .. "/lazy-lock.json",
})
