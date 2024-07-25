---@diagnostic disable: missing-fields
local border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
local highlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None"
return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		{ "FelipeLema/cmp-async-path", url = "https://codeberg.org/FelipeLema/cmp-async-path.git" },
		"hrsh7th/cmp-buffer",
		"honza/vim-snippets",
		"dcampos/nvim-snippy",
		"dcampos/cmp-snippy",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-calc",
		"dmitmel/cmp-digraphs",
	},
	config = function()
		local cmp = require("cmp")
		local snippy = require("snippy")
		require("cmp").setup({
			sources = {
				{ name = "snippy", max_item_count = 4, priority = 11 },
				{ name = "nvim_lsp", max_item_count = 4, priority = 10 },
				{ name = "buffer", max_item_count = 4, priority = 8 },
				{ name = "async_path", priority = 4 },
				{ name = "calc" },
				{ name = "digraphs", max_item_count = 4 },
			},
			window = {
				documentation = { border = border, winhighlight = highlight },
				completion = { winhighlight = highlight, border = border },
			},
			snippet = {
				expand = function(args)
					require("snippy").expand_snippet(args.body)
				end,
			},
			matching = {
				disallow_fuzzy_matching = false,
				disallow_fullfuzzy_matching = false,
				disallow_partial_fuzzy_matching = false,
				disallow_partial_matching = false,
				disallow_prefix_unmatching = false,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.close(),
				["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if snippy.can_expand_or_advance() then
						snippy.expand_or_advance()
					else
						vim.api.nvim_put({ "\t" }, "c", false, true)
					end
				end, { "i", "s" }),
			}),
		})
	end,
}
