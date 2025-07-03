return {
	{
		"nvim-telescope/telescope.nvim",
		tag = '0.1.8',
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
		},
		config = function()

			local actions = require("telescope.actions")
			-- Telescope setup with key mappings
			require("telescope").setup {
				defaults = {
					mappings = {
						i = {
							["<A-j>"] = actions.move_selection_next,
							["<A-k>"] = actions.move_selection_previous,
							["<A-l>"] = actions.select_default,
							["<A-h>"] = actions.close,
						},
						n = {
							["j"] = actions.move_selection_next,
							["k"] = actions.move_selection_previous,
							["h"] = actions.select_default,
							["l"] = actions.close,
						},
					},
					file_ignore_patterns = {
						"node_modules"
					},
				},
			}
			-- telescope
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>e", builtin.diagnostics, { desc = "Find diagnostics" })
			vim.keymap.set("n", "<leader>i", builtin.lsp_references, { desc = "Find File" })
			vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find File" })
			vim.keymap.set("n", "<leader>F", builtin.live_grep, { desc = "Live Grep" })
			vim.keymap.set("n", "<leader>g", builtin.lsp_document_symbols, { desc = "Lest Types" })
			vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "List Buffers" })


			-- Make <Space> work normally in insert mode
			vim.keymap.set("i", "<Space>", "<Space>")

end,
  }
}

