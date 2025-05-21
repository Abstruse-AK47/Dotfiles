return {
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function keymap(modes, lh, rh, opts)
					vim.keymap.set(
						modes,
						lh,
						rh,
						vim.tbl_deep_extend("force", { silent = true, buffer = bufnr }, opts or {})
					)
				end

				-- Navigation
				keymap("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				keymap("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				-- Actions
				keymap({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
				keymap({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
				keymap("n", "<leader>hS", gs.stage_buffer)
				keymap("n", "<leader>ha", gs.stage_hunk)
				keymap("n", "<leader>hu", gs.undo_stage_hunk)
				keymap("n", "<leader>hR", gs.reset_buffer)
				keymap("n", "<leader>hp", gs.preview_hunk)
				keymap("n", "<leader>hb", function()
					gs.blame_line({ full = true })
				end)
				keymap("n", "<leader>hB", gs.toggle_current_line_blame)
				keymap("n", "<leader>hd", gs.diffthis)
				keymap("n", "<leader>hD", function()
					gs.diffthis("~")
				end)

				-- Text object
				keymap({ "o", "x" }, "hh", ":<C-U>Gitsigns select_hunk<CR>")
			end,
		},
	},
	{
		"NeogitOrg/neogit",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed, not both.
			"nvim-telescope/telescope.nvim", -- optional
			"ibhagwan/fzf-lua", -- optional
		},
		config = true,
	},
}
