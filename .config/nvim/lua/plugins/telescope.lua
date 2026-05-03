return {
	{
		"nvim-telescope/telescope.nvim",
		tag = '0.1.8',
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-project.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
		},
		config = function()
			local actions = require("telescope.actions")
			local project_actions = require("telescope._extensions.project.actions")

			require("telescope").setup {
				defaults = {
					initial_mode = "normal",
					mappings = {
						i = {
							["<A-j>"] = actions.move_selection_next,
							["<A-k>"] = actions.move_selection_previous,
							["<A-l>"] = actions.select_default,
							["<A-h>"] = actions.close,
						},
						n = {
							["q"] = actions.close,
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
				extensions = {
					project = {
						on_project_selected = function(prompt_bufnr)
							project_actions.change_working_directory(prompt_bufnr, false)
							require("harpoon"):list():select(1)
						end,
						mappings = {
							n = {
								['d'] = project_actions.delete_project,
								['r'] = project_actions.rename_project,
								['c'] = project_actions.add_project,
								['C'] = project_actions.add_project_cwd,
								['f'] = project_actions.find_project_files,
								['b'] = project_actions.browse_project_files,
								['s'] = project_actions.search_in_project_files,
								['R'] = project_actions.recent_project_files,
								['w'] = project_actions.change_working_directory,
								['o'] = project_actions.next_cd_scope,
							},
						},
					}
				}
			}
			-- telescope
			require("telescope").load_extension('project')
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>e", builtin.diagnostics, { desc = "Find diagnostics" })
			vim.keymap.set("n", "<leader>i", builtin.lsp_references, { desc = "Find File" })
			vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find File" })
			vim.keymap.set("n", "<leader>F", builtin.live_grep, { desc = "Live Grep" })
			vim.keymap.set("n", "<leader>g", builtin.lsp_document_symbols, { desc = "List Types" })
			vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "List Buffers" })
			vim.api.nvim_set_keymap('n', '<leader>p', ":Telescope project<CR>", { desc = "open project" })
			-- Make <Space> work normally in insert mode
			vim.keymap.set("i", "<Space>", "<Space>")
		end,
	}
}
