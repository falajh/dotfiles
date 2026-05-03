return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				direction = "tab", -- options: "vertical" | "horizontal" | "tab" | "float"
				shade_terminals = false, -- remove shading (for clarity)
				start_in_insert = true,
			})
			vim.keymap.set("t", "<Del>", [[<C-\><C-n>]],
				{ noremap = true, silent = true, desc = "Enter Normal Mode from terminal" })
			vim.keymap.set("n", "<A-t>", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
			vim.keymap.set("t", "<A-t>", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
		end,
	},
}
