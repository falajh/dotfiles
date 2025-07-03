return {
	'saghen/blink.cmp',
	-- optional: provides snippets for the snippet source
	dependencies = {
		{
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		{
			"L3MON4D3/LuaSnip",
			dependencies = { "rafamadriz/friendly-snippets" },
			version = 'v2.*',
		},
	},

	-- use a release tag to download pre-built binaries
	version = '1.*',
	-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- build = 'cargo build --release',
	-- If you use nix, you can build from source using latest nightly rust with:
	-- build = 'nix run .#build-plugin',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
		-- 'super-tab' for mappings similar to vscode (tab to accept)
		-- 'enter' for enter to accept
		-- 'none' for no mappings
		--
		-- All presets have the following mappings:
		-- C-space: Open menu or open docs if already open
		-- C-n/C-p or Up/Down: Select next/previous item
		-- C-e: Hide menu
		-- C-k: Toggle signature help (if signature.enabled = true)
		--
		-- See :h blink-cmp-config-keymap for defining your own keymap
		keymap = {
			preset = 'default',

			["<Tab>"] = { 'select_next', 'fallback' },
			["<S-Tab>"] = { 'select_prev', 'fallback' },
			["<CR>"] = { 'accept', 'fallback' },
			['<C-b>'] = { function(cmp) cmp.show({ providers = { 'snippets' } }) end }

		},

		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = 'mono'
		},

		-- (Default) Only show the documentation popup when manually triggered
		completion = {
			--keyword = { range = 'default' },
			menu = {
				-- Don't automatically show the completion menu
				auto_show = true,

				-- nvim-cmp style menu
				draw = {
					columns = {
						{ "kind_icon", "label", gap = 1 },
						{ "kind", "source_name", gap = 1 }
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
		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
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
						show_hidden_files_by_default = false,
						-- Treat `/path` as starting from the current working directory (cwd) instead of the root of your filesystem
						ignore_root_slash = false,
					},
				},
			},
		},
		snippets = {
			preset = 'luasnip', -- preset = 'default'
		},

		-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
		-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
		-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
		--
		-- See the fuzzy documentation for more information
		fuzzy = { implementation = "prefer_rust_with_warning" }
	},
	opts_extend = { "sources.default" },
	config = function(_, opts)
		require("luasnip.loaders.from_vscode").lazy_load()
		require('blink.cmp').setup(opts)
	end,
}
