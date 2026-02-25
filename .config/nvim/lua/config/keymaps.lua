-- Remap movement keys
vim.keymap.set({ 'n', 'v', 'o' }, '^', '0', { noremap = true, desc = "Move to beginning of line" })
vim.keymap.set({ 'n', 'v', 'o' }, '0', '^', { noremap = true, desc = "Move to first non-blank character" })
vim.keymap.set({ 'i', 'c' }, '<A-h>', '<left>', { noremap = true,desc = "Move cursor left" })
vim.keymap.set({ 'i', 'c' }, '<A-l>', '<right>', { noremap = true, desc = "Move cursor right" })
vim.keymap.set({ 'i', 'c' }, '<A-k>', '<up>', { noremap = true, desc = "Move cursor up" })
vim.keymap.set({ 'i', 'c' }, '<A-j>', '<down>', { noremap = true,desc = "Move cursor down" })
vim.keymap.set('n', 'H', '5zh')
vim.keymap.set('n', 'L', '5zl')
vim.keymap.set('i', 'jj', '<Esc>', { noremap = true, desc = "Exit insert mode" })

local opts = { noremap = true, silent = true }

vim.keymap.set('i', '<Del>', '~', { noremap = true, desc = "Toggle case of character under cursor" })
vim.keymap.set('n', '<A-m>', '<C-d>zz', { noremap = true,desc = "Scroll down and center" })
vim.keymap.set('n', '<A-u>', '<C-u>zz', { noremap = true,desc = "Scroll up and center" })
vim.keymap.set('n', '<A-h>', '<C-w>h', { noremap = true , silent = true, desc = "move to left window" })
vim.keymap.set('n', '<A-k>', '<C-w>k', { noremap = true , silent = true, desc = "move to top window" })
vim.keymap.set('n', '<A-j>', '<C-w>j', { noremap = true , silent = true, desc = "move to bottom window" })
vim.keymap.set('n', '<A-l>', '<C-w>l', { noremap = true , silent = true, desc = "move to right window" })
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true,desc = "Next buffer" })
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { noremap = true, silent = true, desc = "Previous buffer" })
vim.keymap.set('n', '+', '<C-w>o', { noremap = true, silent = true , desc = "Close other windows" })

vim.keymap.set('n', '<leader>q', '<cmd>bd<CR>', { desc = "Close current buffer" })
vim.keymap.set('n', '<leader>Q', '<cmd>bd!<CR>', { desc = "Force close current buffer" })

-- V
vim.keymap.set('n', '<A-v>', '<C-v>', opts)

-- theprimeagen
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- copy
vim.keymap.set('n', '<leader>y', function()
	-- Get content from register 0 (last yank)
	local content = vim.fn.getreg('"0')
	if content == '' then
		vim.notify('Register 0 is empty', vim.log.levels.WARN)
		return
	end

	content = content:gsub("\n+$", "")
	-- Replace newlines with placeholder
	local formatted = content:gsub('\n', '<NEWLINE>')
	local histfile = vim.fn.expand('~/.cache/cliphist')

	-- Append to history file
	local file = io.open(histfile, 'a')
	if file then
		file:write(formatted .. '\n')
		file:close()
		vim.notify('Added to clipboard history', vim.log.levels.INFO)
	else
		vim.notify('Failed to write to history file', vim.log.levels.ERROR)
	end

	-- Also copy to system clipboard
	vim.fn.setreg('+', content)
end, { desc = 'Yank to clipboard history' })

-- autocommands
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ timeout = 200 }) -- 200ms highlight
	end,
})

-- lsp
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local lopts = { noremap = true, silent = true, buffer = bufnr }
		vim.keymap.set("n", "<leader>.", vim.lsp.buf.format, lopts)
		vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, lopts)
		vim.keymap.set("n", "K", function() vim.lsp.buf.hover({ border = 'rounded' }) end, lopts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, lopts)
		vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, lopts)
		vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, lopts)

		--local client = vim.lsp.get_client_by_id(args.data.client_id)
		--if client then
		--	client.server_capabilities.semanticTokensProvider = nil
		--end
	end,
})


-- spelllang
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "txt", "gitcommit" },
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.spelllang = { "en" }
	end,
})

-- quickfix
vim.keymap.set('n', '<leader>co', ':copen<CR>', { desc = 'Open quickfix list' })
vim.keymap.set('n', '<leader>cc', ':cclose<CR>', { desc = 'Close quickfix list' })
