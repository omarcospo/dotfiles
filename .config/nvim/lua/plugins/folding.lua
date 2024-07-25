return {
	{
		"kevinhwang91/nvim-ufo",
		event = { "VeryLazy" },
		dependencies = { "kevinhwang91/promise-async" },
		init = function()
			vim.opt.foldenable = true -- Enable fold for nvim-ufo.
			vim.opt.foldlevel = 99 -- set highest foldlevel for nvim-ufo.
			vim.opt.foldlevelstart = 99 -- Start with all code unfolded.
			vim.opt.foldcolumn = "0"
		end,
		opts = {
			preview = {
				mappings = {
					scrollB = "<C-b>",
					scrollF = "<C-f>",
					scrollU = "<C-u>",
					scrollD = "<C-d>",
				},
			},
			provider_selector = function(_, filetype, buftype)
				local function handleFallbackException(bufnr, err, providerName)
					if type(err) == "string" and err:match("UfoFallbackException") then
						return require("ufo").getFolds(bufnr, providerName)
					else
						return require("promise").reject(err)
					end
				end

				-- only use indent until a file is opened
				return (filetype == "" or buftype == "nofile") and "indent"
					or function(bufnr)
						return require("ufo")
							.getFolds(bufnr, "lsp")
							:catch(function(err)
								return handleFallbackException(bufnr, err, "treesitter")
							end)
							:catch(function(err)
								return handleFallbackException(bufnr, err, "indent")
							end)
					end
			end,
		},
	},
	{
		"domharries/foldnav.nvim",
		version = "*",
		config = function()
			vim.g.foldnav = { flash = { enabled = true } }
		end,
		keys = {
			{ "gk", "<CMD>lua require('foldnav').goto_prev_start()<CR>" },
			{ "gj", "<CMD>lua require('foldnav').goto_next()<CR>" },
		},
	},
}
