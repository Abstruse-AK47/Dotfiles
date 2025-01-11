-- vim.g.nightflyTransparent = true
--
-- return {
-- 	{
-- 		"bluz71/vim-nightfly-guicolors",
-- 		priority = 1000, -- make sure to load this before all the other start plugins
-- 		transparent = true,
-- 		config = function()
-- 			require("nightfly").custom_colors({
-- 				styles = {
-- 					sidebars = "transparent" or "dark",
-- 					floats = "transparent" or "dark",
-- 					highlight = "transparent" or "dark",
-- 				},
-- 				-- on_colors = function(colors)
-- 				-- 	colors.bg_dark = colors.none
-- 				-- 	colors.bg_float = colors.none
-- 				-- 	colors.bg_highlight = colors.none
-- 				-- 	colors.bg_sidebar = colors.none
-- 				-- 	colors.bg_statusline = colors.none
-- 				-- 	colors.fg_float = colors.none
-- 				-- end,
-- 			})
-- 			-- load the colorscheme here
-- 			vim.cmd([[colorscheme nightfly]])
-- 		end,
-- 	},
-- }

return {
	"folke/tokyonight.nvim",
	priority = 1000,
	config = function()
		local transparent = true -- set to true if you would like to enable transparency

		local bg = "#011628"
		local bg_dark = "#011423"
		-- local bg_highlight = "#143652"
		local bg_search = "#0A64AC"
		local bg_visual = "#275378"
		local fg = "#CBE0F0"
		local fg_dark = "#B4D0E9"
		local fg_gutter = "#627E97"
		local border = "#547998"

		require("tokyonight").setup({
			style = "night",
			transparent = transparent,
			styles = {
				sidebars = transparent and "transparent" or "dark",
				floats = transparent and "transparent" or "dark",
				highlight = transparent and "transparent" or "dark",
			},
			on_colors = function(colors)
				colors.bg = bg
				colors.bg_dark = transparent and colors.none or bg_dark
				colors.bg_float = transparent and colors.none or bg_dark
				colors.bg_highlight = transparent and colors.none or bg_dark
				colors.bg_popup = bg_dark
				colors.bg_search = bg_search
				colors.bg_sidebar = transparent and colors.none or bg_dark
				colors.bg_statusline = transparent and colors.none or bg_dark
				colors.bg_visual = bg_visual
				colors.border = border
				colors.fg = fg
				colors.fg_dark = fg_dark
				colors.fg_float = transparent and colors.none or bg_dark
				colors.fg_gutter = fg_gutter
				colors.fg_sidebar = fg_dark
			end,
			on_highlights = function(highlight)
				highlight.DiagnosticVirtualTextError = { fg = "#db4b4b", bg = "NONE" }
				highlight.DiagnosticVirtualTextWarn = { fg = "#e0af68", bg = "NONE" }
				highlight.DiagnosticVirtualTextInfo = { fg = "#1abc9c", bg = "NONE" }
				highlight.DiagnosticVirtualTextHint = { fg = "#1abc9c", bg = "NONE" }
				-- remove telescope background
				highlight.TelescopeNormal = { bg = "NONE" }
				highlight.TelescopeBorder = { bg = "NONE" }
				highlight.TelescopePromptBorder = { bg = "NONE" }
				highlight.TelescopeResultsBorder = { bg = "NONE" }
				highlight.TelescopePreviewBorder = { bg = "NONE" }
			end,
		})

		vim.cmd("colorscheme tokyonight")
	end,
}
