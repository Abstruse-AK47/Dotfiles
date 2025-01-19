return {
	{
		"jpalardy/vim-slime",
		init = function()
			vim.g.slime_last_channel = { nil }
			-- will use `# %%` to define cells
			vim.g.slime_cell_delimiter = "\\s*#\\s*%%"
			vim.g.slime_paste_file = os.getenv("HOME") .. "/.slime_paste"

			local function next_cell()
				vim.fn.search(vim.g.slime_cell_delimiter)
			end

			local function prev_cell()
				vim.fn.search(vim.g.slime_cell_delimiter, "b")
			end

			vim.keymap.set("n", "<leader>cd", vim.cmd.SlimeSend, { noremap = true, desc = "send line to term" })
			vim.keymap.set(
				"n",
				"<leader>cv",
				vim.cmd.SlimeConfig,
				{ noremap = true, desc = "Open slime configuration" }
			)
			vim.keymap.set("n", "<leader>cs", "<Plug>SlimeRegionSend", { noremap = true, desc = "send line to tmux" })
			vim.keymap.set(
				"n",
				"<leader>cp",
				"<Plug>SlimeParagraphSend",
				{ noremap = true, desc = "Send Paragraph with Slime" }
			)
			vim.keymap.set(
				"n",
				"<leader>ck",
				prev_cell,
				{ noremap = true, desc = "Search backward for slime cell delimiter" }
			)
			vim.keymap.set(
				"n",
				"<leader>cj",
				next_cell,
				{ noremap = true, desc = "Search forward for slime cell delimiter" }
			)
			vim.keymap.set("n", "<leader>cc", "<Plug>SlimeSendCell", { noremap = true, desc = "Send cell to slime" })
			-- local slime_get_jobid = function()
			-- 	local buffers = vim.api.nvim_list_bufs()
			-- 	local terminal_buffers = { "Select terminal:\tjobid\tname" }
			-- 	local name = ""
			-- 	local jid = 1
			-- 	local chosen_terminal = 1
			--
			-- 	for _, buf in ipairs(buffers) do
			-- 		if vim.bo[buf].buftype == "terminal" then
			-- 			jid = vim.api.nvim_buf_get_var(buf, "terminal_job_id")
			-- 			name = vim.api.nvim_buf_get_name(buf)
			-- 			table.insert(terminal_buffers, jid .. "\t" .. name)
			-- 		end
			-- 	end
			--
			-- 	-- if there is more than one terminal, ask which one to use
			-- 	if #terminal_buffers > 2 then
			-- 		chosen_terminal = vim.fn.inputlist(terminal_buffers)
			-- 	else
			-- 		chosen_terminal = jid
			-- 	end
			--
			-- 	if chosen_terminal then
			-- 		print("\n[slime] jobid chosen: ", chosen_terminal)
			-- 		return chosen_terminal
			-- 	else
			-- 		print("No terminal found")
			-- 	end
			-- end
			--
			local function slime_use_tmux()
				vim.g.slime_target = "tmux"
				vim.g.slime_bracketed_paste = 1
				vim.g.slime_python_ipython = 0
				vim.g.slime_no_mappings = 1
				vim.g.slime_default_config = { socket_name = "default", target_pane = ":.2" }
				vim.g.slime_dont_ask_default = 1
			end

			--      local function slime_use_neovim()
			--        vim.g.slime_target = "neovim"
			--        vim.g.slime_bracketed_paste = 1
			--        vim.g.slime_python_ipython = 1
			--        vim.g.slime_no_mappings = 1
			--        vim.g.slime_get_jobid = slime_get_jobid
			--        -- vim.g.slime_default_config = nil
			--        -- vim.g.slime_dont_ask_default = 0
			--      end

			-- slime_use_neovim()
			slime_use_tmux()
			-- }}
		end,
	},

	{ -- requires plugins in lua/plugins/treesitter.lua and lua/plugins/lsp.lua
		-- for complete functionality (language features)
		"quarto-dev/quarto-nvim",
		ft = { "quarto" },
		dev = false,
		closePreviewOnExit = true,
		opts = {
			lspFeatures = {
				enable = true,
				chunks = "curly",
				languages = nil,
				diagnostics = {
					enabled = true,
					triggers = { "BufWritePost" },
				},
				completion = {
					enable = true,
				},
			},
			codeRunner = {
				default_method = "molten",
				never_run = { "yaml" },
			},
		},
		dependencies = {
			-- for language features in code cells
			-- configured in lua/plugins/lsp.lua and
			-- added as a nvim-cmp source in lua/plugins/completion.lua
			"jmbuhr/otter.nvim",
			"hrsh7th/nvim-cmp",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
	},

	{ -- directly open ipynb files as quarto docuements
		-- and convert back behind the scenes
		-- needs:
		-- pip install jupytext
		"GCballesteros/jupytext.nvim",
		opts = {
			custom_language_formatting = {
				python = {
					extension = "qmd",
					style = "quarto",
					force_ft = "quarto", -- you can set whatever filetype you want here
				},
				r = {
					extension = "qmd",
					style = "quarto",
					force_ft = "quarto", -- you can set whatever filetype you want here
				},
			},
		},
	},

	{ -- paste an image from the clipboard or drag-and-drop
		"HakonHarnes/img-clip.nvim",
		event = "BufEnter",
		ft = { "markdown", "quarto", "latex" },
		opts = {
			default = {
				dir_path = "img",
			},
			filetypes = {
				markdown = {
					url_encode_path = true,
					template = "![$CURSOR]($FILE_PATH)",
					drag_and_drop = {
						download_images = false,
					},
				},
				quarto = {
					url_encode_path = true,
					template = "![$CURSOR]($FILE_PATH)",
					drag_and_drop = {
						download_images = false,
					},
				},
			},
		},
		config = function(_, opts)
			require("img-clip").setup(opts)
			vim.keymap.set("n", "<leader>ii", ":PasteImage<cr>", { desc = "insert image from clipboard" })
		end,
	},

	{ -- preview equations
		"jbyuki/nabla.nvim",
		keys = {
			{ "<leader>qm", ':lua require"nabla".toggle_virt()<cr>', desc = "toggle math equations" },
		},
	},

	{
		"3rd/image.nvim",
		dependencies = { "https://github.com/leafo/magick" },
		config = function()
			require("image").setup({
				-- backend = "ueberzug",
				max_width = 80,
				max_height = 20,
			})
		end,
	},

	{
		"benlubas/molten-nvim",
		enable = true,
		build = ":UpdateRemotePlugins",
		dependencies = "willothy/wezterm.nvim",
		init = function()
			vim.g.molten_image_provider = "image.nvim"
			--vim.g.molten_open_cmd = "wsl-open" -- "/mnt/c/Program Files/Mozilla Firefox/firefox.exe"
			vim.g.molten_output_win_max_height = 50
			vim.g.molten_output_win_max_width = 500
			vim.g.molten_use_border_highlights = true
			vim.g.molten_auto_open_output = false
			vim.g.molten_auto_image_popup = false
			vim.g.molten_virt_text_output = true
			vim.g.molten_virt_lines_off_by_1 = true
			vim.g.molten_auto_open_html_in_browser = false
			local runner = require("quarto.runner")
			vim.keymap.set("n", "<leader>mc", runner.run_cell, { desc = "run cell", silent = true })
			vim.keymap.set("n", "<leader>ma", runner.run_above, { desc = "run cell and above", silent = true })
			vim.keymap.set("n", "<leader>mA", runner.run_all, { desc = "run all cells", silent = true })
			vim.keymap.set("n", "<leader>mL", runner.run_line, { desc = "run line", silent = true })
			vim.keymap.set("v", "<leader>my", runner.run_range, { desc = "run visual range", silent = true })
			vim.keymap.set("n", "<leader>mC", function()
				runner.run_all(true)
			end, { desc = "run all cells of all languages", silent = true })
		end,
		keys = {
			{ "<leader>mi", ":MoltenInit<cr>", desc = "Init" },
			{ "<leader>mv", ":<C-u>MoltenEvaluateVisual<cr>", mode = "v", desc = "Eval visual" },
			{ "<leader>mr", ":MoltenReevaluateCell<cr>", desc = "Re-eval cell" },
			{ "<leader>mh", ":MoltenHideOutput<cr>", desc = "Hide output" },
			{ "<leader>me", ":MoltenEvaluateOperator<cr>", desc = "Evaluate Operator", silent = true },
			{ "<leader>mq", ":noautocmd MoltenEnterOutput<cr>", desc = "Open Output Window", silent = true },
			{ "<leader>ms", ":MoltenSave<cr>", desc = "Save kernel", silent = true },
			{ "<leader>ml", ":MoltenLoad<cr>", desc = "Load kernel", silent = true },
			{ "<leader>mo", ":!wsl-open output.jpg<cr>", desc = "Open Image", silent = true },
			{ "<leader>md", ":!rm -rf output.jpg<cr>", desc = "Remove Image", silent = true },
			{ "<leader>mb", ":MoltenOpenInBrowser<cr>", desc = "Open in browser", silent = true },
		},
	},
}
