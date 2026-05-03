return {
	{
		"HiPhish/rainbow-delimiters.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		branch = 'main',
		lazy = false,
		build = ':TSUpdate',
		config = function()
			vim.api.nvim_create_autocmd('FileType', {
				callback = function()
					-- Enable treesitter highlighting and disable regex syntax
					pcall(vim.treesitter.start)
					-- Enable treesitter-based indentation
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
			vim.api.nvim_set_hl(0, "@variable.javascript", { link = "Identifier" })
			vim.api.nvim_set_hl(0, "@lsp.type.variable", { link = "Identifier" })
			vim.api.nvim_set_hl(0, "@lsp.typemod.variable.declaration", { link = "Identifier" })
			vim.api.nvim_set_hl(0, "@lsp.typemod.variable.readonly", { link = "Identifier" })
			vim.api.nvim_set_hl(0, "@lsp.typemod.variable.local", { link = "Identifier" })
			vim.api.nvim_set_hl(0, "@lsp.typemod.variable.local.write", { link = "Identifier" })
			vim.api.nvim_set_hl(0, "@lsp.mod.local", { link = "Identifier" })
			vim.api.nvim_set_hl(0, "@lsp.typemod.variable.defaultLibrary", { link = "@variable.builtin" })
		end
	}
}
