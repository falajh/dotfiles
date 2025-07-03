return {
	"github/copilot.vim",
	config = function()
		--vim.g.copilot_no_tab_map = true
		vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
		vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Next()', { silent = true, expr = true })
		vim.api.nvim_set_keymap("i", "<C-k>", 'copilot#Prev()', { silent = true, expr = true })
		vim.api.nvim_set_keymap("i", "<C-c>", 'copilot#Dismiss()', { silent = true, expr = true })
	end,
}
