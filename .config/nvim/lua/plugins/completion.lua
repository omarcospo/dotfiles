---@diagnostic disable: missing-fields
return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"onsails/lspkind.nvim",
		{ "FelipeLema/cmp-async-path", url = "https://codeberg.org/FelipeLema/cmp-async-path.git" },
		"dcampos/nvim-snippy",
		"dcampos/cmp-snippy",
		"honza/vim-snippets",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-calc",
		"hrsh7th/cmp-emoji",
		"dmitmel/cmp-digraphs",
	},
	config = function()
		local cmp = require("cmp")
		local lspkind = require("lspkind")
		local snippy = require("snippy")
		require("cmp").setup({
			sources = {
				{ name = "snippy", max_item_count = 5, priority = 11 },
				{ name = "nvim_lsp", max_item_count = 10, priority = 10 },
				{ name = "buffer", max_item_count = 10, priority = 8 },
				{ name = "async_path", priority = 6 },
				{ name = "calc" },
				{ name = "emoji" },
				{ name = "digraphs" },
			},
			window = {
				documentation = { border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" } },
				completion = {
					winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
					border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
				},
			},
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
					local strings = vim.split(kind.kind, "%s", { trimempty = true })
					kind.kind = (strings[1] or "") .. " "
					kind.menu = (strings[2] or "")
					return kind
				end,
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
