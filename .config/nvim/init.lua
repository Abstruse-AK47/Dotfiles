vim.g.mapleader = " "

-- setting vim main clipboard
vim.opt.clipboard = "unnamedplus"

-- setting cmd height
vim.opt.cmdheight = 0

-- for find
vim.opt.wildmenu = true

-- for notify
vim.opt.termguicolors = true

--Intializing plugins
require("lazy_nvim.lazy")
require("lazy_nvim.core")

-- function to ToggleStatusLine
function ToggleStatusLine()
	if vim.o.laststatus == 0 then
		vim.o.laststatus = 2
		require("lualine").setup() -- Setup lualine
	else
		vim.o.laststatus = 0
	end
end

-- Map a key to toggle the status line (e.g., <leader>tl)
vim.api.nvim_set_keymap("n", "<leader>il", ":lua ToggleStatusLine()<CR>", { noremap = true, silent = true })

-- Function to Toggle TabLine
function ToggleTabLine()
	if vim.o.showtabline == 0 then
		vim.o.showtabline = 2
	else
		vim.o.showtabline = 0
	end
end

-- Map a key to toggle the tab bar (e.g., <leader>tt)
vim.api.nvim_set_keymap("n", "<leader>it", ":lua ToggleTabLine()<CR>", { noremap = true, silent = true })
--

-- for treesitter--code folding
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldenable = false

-- Apply settings after lazy_nvim is loaded
vim.defer_fn(function()
	-- Ensure both status line and tab line are off by default after plugins load
	vim.o.laststatus = 0 -- Status line is off by default
	vim.o.showtabline = 0 -- Tab bar is off by default
end, 100)

-- Neovide settings
vim.g.neovide_opacity = 0.8
vim.g.neovide_normal_opacity = 0.8
vim.o.guifont = "Agave Nerd Font:h12"
