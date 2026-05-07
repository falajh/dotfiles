return {
	'saghen/blink.cmp',
	-- optional: provides snippets for the snippet source
	dependencies = {
		{ "rafamadriz/friendly-snippets", },
		{ "L3MON4D3/LuaSnip",             version = 'v2.*', },
	},

	version = '1.*',
	---@module 'blink.cmp'
	---@diagnostic disable-next-line: undefined-doc-name
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = 'default',
			["<Tab>"] = { 'select_next', 'fallback' },
			["<S-Tab>"] = { 'select_prev', 'fallback' },
			["<CR>"] = { 'accept', 'fallback' },
			['<C-b>'] = { function(cmp) cmp.show({ providers = { 'snippets' } }) end },

		},
		cmdline = {
			enabled = true,
			keymap = {
				['<S-CR>'] = { 'accept_and_enter', 'fallback' },
			},
			completion = {
				ghost_text = {
					enabled = true
				},
				menu = {
					auto_show = true
				},
				list = {
					selection = {
						preselect = false,
					},
				},
			},
		},
		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = 'mono'
		},
		completion = {
			--keyword = { range = 'default' },
			menu = {
				-- Don't automatically show the completion menu
				auto_show = true,

				-- nvim-cmp style menu
				draw = {
					columns = {
						{ "kind_icon", "label",       gap = 1 },
						{ "kind",      "source_name", gap = 1 }
					},
				}
			},
			documentation = {
				auto_show = true,
				window = {
					border = 'rounded',
				},
			},
		},
		signature = {
			enabled = true,
			window = {
				border = 'rounded',
			}
		},
		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer' },
			providers = {
				path = {
					module = 'blink.cmp.sources.path',
					score_offset = 3,
					enabled = true,
					fallbacks = { 'buffer' },
					opts = {
						trailing_slash = true,
						label_trailing_slash = true,
						get_cwd = function(context) return vim.fn.expand(('#%d:p:h'):format(context.bufnr)) end,
						show_hidden_files_by_default = true,
						-- Treat `/path` as starting from the current working directory (cwd) instead of the root of your filesystem
						ignore_root_slash = false,
					},
				},
			},
		},
		snippets = {
			preset = 'luasnip', -- preset = 'default'
		},

		fuzzy = { implementation = "prefer_rust_with_warning" }
	},
	opts_extend = { "sources.default" },
	config = function(_, opts)
		require("luasnip.loaders.from_vscode").lazy_load()
		require('blink.cmp').setup(opts)
	end,
}
