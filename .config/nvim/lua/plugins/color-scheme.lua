return {
	"Mofiqul/dracula.nvim",
	config = function()
		local opt = {
			-- customize dracula color palette
			colors = {
				bg = "none", --"#000000",
				fg = "#F8F8F2",
				selection = "#111111", -- CursorLine
				menu = "#090A11",
				visual = "#333355"
			},
			-- show the '~' characters after the end of buffers
			show_end_of_buffer = false, -- default false
			-- use transparent background
			transparent_bg = false, -- default false
			-- set custom lualine background color
			lualine_bg_color = "#04050B", -- default nil
			-- set italic comment
			italic_comment = true, -- default false
			-- overrides the default highlights with table see `:h synIDattr`
			overrides = {},
			-- You can use overrides as table like this
			-- overrides = {
			--   NonText = { fg = "white" }, -- set NonText fg to white
			--   NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
			--   Nothing = {} -- clear highlight of Nothing
			-- },
			-- Or you can also use it like a function to get color from theme
			-- overrides = function (colors)
			--   return {
			--     NonText = { fg = colors.white }, -- set NonText fg to white of theme
			--   }
			-- end,
		}
		require("dracula").setup(opt)
		vim.cmd.colorscheme "dracula"
		vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FFD700", bold = true })
		--vim.api.nvim_set_hl(0, "LineNr", { fg = "#ff79c6" })

		-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		--vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
	end
}
