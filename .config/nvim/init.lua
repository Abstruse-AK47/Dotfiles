vim.g.mapleader = " "

vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 0

function ToggleStatusLine()
	if vim.o.laststatus == 0 then
		vim.o.laststatus = 2
	else
		vim.o.laststatus = 0
	end
end

-- Map a key to toggle the status line (e.g., <leader>tl)
vim.api.nvim_set_keymap("n", "<leader>il", ":lua ToggleStatusLine()<CR>", { noremap = true, silent = true })

function ToggleTabLine()
	if vim.o.showtabline == 0 then
		vim.o.showtabline = 2
	else
		vim.o.showtabline = 0
	end
end

-- Map a key to toggle the tab bar (e.g., <leader>tt)
vim.api.nvim_set_keymap("n", "<leader>it", ":lua ToggleTabLine()<CR>", { noremap = true, silent = true })

require("lazy_nvim.lazy")
require("lazy_nvim.core")
