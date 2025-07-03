return {
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({
				default_file_explorer = true,
				view_options = {
					show_hidden = true,
				},
				columns = {
					-- "icon",
					-- "permissions",
					-- "size",
					-- "mtime",
				},

			})
			vim.keymap.set("n", "<leader>o", "<CMD>Oil<CR>", { desc = "Open parent directory in Oil" })
		end
	},
	{ "a-h/templ", lazy = true },
}
