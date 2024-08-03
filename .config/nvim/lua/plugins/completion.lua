---@diagnostic disable: missing-fields
local border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
local highlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None"
return {
	"hrsh7th/nvim-cmp",
	version = false,
	event = "InsertEnter",
	dependencies = {
		"onsails/lspkind.nvim",
		{ "FelipeLema/cmp-async-path", url = "https://codeberg.org/FelipeLema/cmp-async-path.git" },
		"hrsh7th/cmp-buffer",
		"honza/vim-snippets",
		"dcampos/nvim-snippy",
		"dcampos/cmp-snippy",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-calc",
	},
	config = function()
		local cmp = require("cmp")
		local snippy = require("snippy")
		local lspkind = require("lspkind")
		require("cmp").setup({
			sources = {
				{ name = "snippy", priority = 1, group_index = 1, max_item_count = 4 },
				{ name = "nvim_lsp", priority = 2, max_item_count = 10 },
				{ name = "buffer", priority = 1, keyword_length = 3, max_item_count = 3 },
				{ name = "async_path", max_item_count = 6 },
				{ name = "calc", max_item_count = 1 },
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
			experimental = {
				ghost_text = {
					hl_group = "Comment",
				},
			},
		})
	end,
}
