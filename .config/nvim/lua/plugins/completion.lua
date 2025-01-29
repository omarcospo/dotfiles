return {
	{
		"saghen/blink.cmp",
		lazy = false,
		dependencies = "rafamadriz/friendly-snippets",
		version = "*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = "default",
				["<C-k>"] = { "select_prev", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },
				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },
				["<C-f>"] = { "select_and_accept" },
				["<Tab>"] = { "snippet_forward", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "fallback" },
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "Nerd Font",
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			completion = {
				menu = {
					min_width = 10,
					max_height = 10,
					border = "rounded",
					winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
					draw = { align_to = "cursor" },
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 500,
					window = {
						min_width = 10,
						max_width = 100,
						max_height = 20,
						border = "rounded",
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder,EndOfBuffer:BlinkCmpDoc",
					},
				},
			},
			signature = { enabled = true },
		},
		opts_extend = { "sources.default" },
	},
}
