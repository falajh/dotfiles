-- Remap movement keys
vim.keymap.set({ 'n', 'v', 'o' }, '0', '^', { noremap = true })
vim.keymap.set({ 'i', 'c' }, '<A-h>', '<left>', { noremap = true })
vim.keymap.set({ 'i', 'c' }, '<A-l>', '<right>', { noremap = true })
vim.keymap.set({ 'i', 'c' }, '<A-k>', '<up>', { noremap = true })
vim.keymap.set({ 'i', 'c' }, '<A-j>', '<down>', { noremap = true })
vim.keymap.set('n', 'H', '5zh')
vim.keymap.set('n', 'L', '5zl')
-- Press jj in insert mode to exit to normal mode
vim.keymap.set('i', 'jj', '<Esc>', { noremap = true })
--vim.keymap.set('c', 'q', 'confirm q', { noremap = true })

-- Map <Del> to <Esc> in normal, insert, and visual modes
local opts = { noremap = true, silent = true }

vim.keymap.set('i', '<Del>', '~', { noremap = true })
vim.keymap.set('n', '<A-m>', '<C-d>zz', { noremap = true })
vim.keymap.set('n', '<A-u>', '<C-u>zz', { noremap = true })
vim.keymap.set('n', '<A-h>', '<C-w>h', opts) -- move to left window
vim.keymap.set('n', '<A-k>', '<C-w>k', opts) -- move to top window
vim.keymap.set('n', '<A-j>', '<C-w>j', opts) -- move to bottom window
vim.keymap.set('n', '<A-l>', '<C-w>l', opts) -- move to right window
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '+', '<C-w>o', { noremap = true, silent = true })

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

vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ timeout = 200 }) -- 200ms highlight
	end,
})


vim.api.nvim_create_user_command('ColorizerToggle', function()
	require('nvim-highlight-colors').toggle()
end, {})


-- lsp
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local lopts = { noremap = true, silent = true, buffer = bufnr }
		vim.keymap.set({ "i", "s" }, "<A-n>", function() require("luasnip").jump(1) end, { silent = true })
		vim.keymap.set("n", "<leader>.", vim.lsp.buf.format, lopts)
		vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, lopts)
		vim.keymap.set("n", "K", function() vim.lsp.buf.hover({ border = 'rounded' }) end, lopts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, lopts)
		vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, lopts)
		vim.keymap.set("n", "<leader>c", vim.lsp.buf.code_action, lopts)

		--local client = vim.lsp.get_client_by_id(args.data.client_id)
		--if client then
		--	client.server_capabilities.semanticTokensProvider = nil
		--end
	end,
})

vim.api.nvim_create_user_command('LspInfo', ':checkhealth vim.lsp', { desc = 'Alias to `:checkhealth vim.lsp`' })

vim.api.nvim_create_user_command('LspLog', function()
	vim.cmd(string.format('tabnew %s', vim.lsp.log.get_filename()))
end, {
	desc = 'Opens the Nvim LSP client log.',
})

local complete_client = function(arg)
	return vim
		.iter(vim.lsp.get_clients())
		:map(function(client)
			return client.name
		end)
		:filter(function(name)
			return name:sub(1, #arg) == arg
		end)
		:totable()
end

local complete_config = function(arg)
	return vim
		.iter(vim.api.nvim_get_runtime_file(('lsp/%s*.lua'):format(arg), true))
		:map(function(path)
			local file_name = path:match('[^/]*.lua$')
			return file_name:sub(0, #file_name - 4)
		end)
		:totable()
end

vim.api.nvim_create_user_command('LspStart', function(info)
	local servers = info.fargs

	-- Default to enabling all servers matching the filetype of the current buffer.
	-- This assumes that they've been explicitly configured through `vim.lsp.config`,
	-- otherwise they won't be present in the private `vim.lsp.config._configs` table.
	if #servers == 0 then
		local filetype = vim.bo.filetype
		for name, _ in pairs(vim.lsp.config._configs) do
			local filetypes = vim.lsp.config[name].filetypes
			if filetypes and vim.tbl_contains(filetypes, filetype) then
				table.insert(servers, name)
			end
		end
	end

	vim.lsp.enable(servers)
end, {
	desc = 'Enable and launch a language server',
	nargs = '?',
	complete = complete_config,
})

vim.api.nvim_create_user_command('LspRestart', function(info)
	local client_names = info.fargs

	-- Default to restarting all active servers
	if #client_names == 0 then
		client_names = vim
			.iter(vim.lsp.get_clients())
			:map(function(client)
				return client.name
			end)
			:totable()
	end

	for name in vim.iter(client_names) do
		if vim.lsp.config[name] == nil then
			vim.notify(("Invalid server name '%s'"):format(name))
		else
			vim.lsp.enable(name, false)
			if info.bang then
				vim.iter(vim.lsp.get_clients({ name = name })):each(function(client)
					client:stop(true)
				end)
			end
		end
	end

	local timer = assert(vim.uv.new_timer())
	timer:start(500, 0, function()
		for name in vim.iter(client_names) do
			vim.schedule_wrap(vim.lsp.enable)(name)
		end
	end)
end, {
	desc = 'Restart the given client',
	nargs = '?',
	bang = true,
	complete = complete_client,
})

vim.api.nvim_create_user_command('LspStop', function(info)
	local client_names = info.fargs

	-- Default to disabling all servers on current buffer
	if #client_names == 0 then
		client_names = vim
			.iter(vim.lsp.get_clients())
			:map(function(client)
				return client.name
			end)
			:totable()
	end

	for name in vim.iter(client_names) do
		if vim.lsp.config[name] == nil then
			vim.notify(("Invalid server name '%s'"):format(name))
		else
			vim.lsp.enable(name, false)
			if info.bang then
				vim.iter(vim.lsp.get_clients({ name = name })):each(function(client)
					client:stop(true)
				end)
			end
		end
	end
end, {
	desc = 'Disable and stop the given client',
	nargs = '?',
	bang = true,
	complete = complete_client,
})

-- spelllang
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "txt", "gitcommit" },
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.spelllang = { "en" }
	end,
})


-- colorscheme
vim.api.nvim_create_user_command('TsColore', function()
	require('telescope.builtin').colorscheme()
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
end, {})
