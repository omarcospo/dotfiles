pcall(function()
  vim.loader.enable()
end)
vim.deprecate = function() end -- Disable deprecation warnings
----------------------
vim.opt.shell = "zsh"
vim.g.no_plugin_maps = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_ruby_provider = 0
vim.g.loaded_remote_plugins = 1
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_matchit = 1
vim.g.loaded_man = false
vim.g.loaded_gzip = 1
vim.g.loaded_2html_plugin = 1
vim.g.editorconfig = false
if not vim.g.vscode then
  require("config.options")
  require("plugin-manager")
  require("config.utils")
  require("config.clean")
  require("config.mappings")
  require("config.autocmds")
else
  require("config.vscode")
end
