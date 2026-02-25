vim.o.mouse = ""
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.g.mapleader = " "
--vim.opt.signcolumn = "no"
vim.o.list = true
vim.opt.listchars = {
	tab = '│ ',
	lead = '·',
	trail = '·',
	--space = '·',
	eol = '󱞣',
}
vim.o.scrolloff = 8
vim.o.sidescroll = 1
vim.o.sidescrolloff = 8
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.termguicolors = true
vim.o.cursorline = true
vim.o.spell = true
vim.o.spelllang = "en_us"
vim.o.wrap = true
vim.o.confirm = true


require("config.keymaps")
require("config.usercommands")
require("config.lazy")
require("config.lsp")


vim.diagnostic.config({
	--	virtual_lines =true,
	virtual_text = true, -- show inline text (under the line)
	signs = false,     -- show in sign column
	underline = true, -- underline the error in code
	update_in_insert = false,
	float = {
		border = 'rounded',
		source = true,
	}
})


-- line number
vim.opt.number = true
vim.opt.relativenumber = true

-- Smart relative line numbers
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
	callback = function()
		vim.opt.relativenumber = false
	end,
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
	callback = function()
		vim.opt.relativenumber = true
	end,
})

-- Set colorscheme
vim.cmd.colorscheme "dracula"
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FFD700", bold = true })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#ff79c6" }) -- green
vim.api.nvim_set_hl(0, "SpellBad", { undercurl = false, underline = false })
vim.api.nvim_set_hl(0, "SpellCap", { undercurl = false, underline = false })
vim.api.nvim_set_hl(0, "SpellLocal", { undercurl = false, underline = false })
vim.api.nvim_set_hl(0, "SpellRare", { undercurl = false, underline = false })

--vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
--vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
--vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
