local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- use -> to make → and <- to make ←
keymap.set("i", "<m-->", "→", { desc = "Right arrow" })
keymap.set("i", "<m-=>", "←", { desc = "Left arrow" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

--save file and exit commands
keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save File" })

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- PageUp and PageDown
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move a PageDown " }) -- PageDown
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move a PageUp" }) -- PageUp

-- Navingating searched words
keymap.set("n", "n", "nzzzv", { desc = "Moving next word" }) -- PageDown
keymap.set("n", "N", "Nzzzv", { desc = "Moving previous word" }) -- PageUp

-- window management
-- tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Tmux Navigator
keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Tmux Navigate Left" })
keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Tmux Navigate Down" })
keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Tmux Navigate Up" })
keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Tmux Navigate Right" })

--snippets

local is_code_chunk = function()
	local current, _ = require("otter.keeper").get_current_language_context()
	if current then
		return true
	else
		return false
	end
end

--- Insert code chunk of given language
--- Splits current chunk if already within a chunk
--- @param lang string
local insert_code_chunk = function(lang)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "n", true)
	local keys
	if is_code_chunk() then
		keys = [[o```<cr><cr>```{]] .. lang .. [[}<esc>o]]
	else
		keys = [[o```{]] .. lang .. [[}<cr>```<esc>O]]
	end
	keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end

local insert_r_chunk = function()
	insert_code_chunk("r")
end

local insert_py_chunk = function()
	insert_code_chunk("python")
end

local insert_title_chunk = function()
	insert_code_chunk("title")
end

-- Adding code chunk

-- normal mode
keymap.set("n", "<m-i>", insert_r_chunk, { desc = "r code chunk", silent = true })
keymap.set("n", "<cm-i>", insert_py_chunk, { desc = "python chunk", silent = true })
keymap.set("n", "<m-O>", insert_title_chunk, { desc = "python_title code chunk", silent = true })

-- insert mode
keymap.set("i", "<m-<>", "<-", { desc = "assign" })
keymap.set("i", "<m-n>", "|>", { desc = "pipe" })

--noice nvim
keymap.set("n", "<leader>nd", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss Noice Message" })

keymap.set("n", "<leader>/", "<cmd>NoiceDismiss<CR>"", { desc = "Dismiss Noice Message" })

