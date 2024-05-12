return {
    {
    'jpalardy/vim-slime',
    init=function ()
      vim.g.slime_last_channel = { nil }
      -- will use `# %%` to define cells
      vim.g.slime_cell_delimiter = '\\s*#\\s*%%'
      vim.g.slime_paste_file = os.getenv("HOME") .. "/.slime_paste"

      local function next_cell()
        vim.fn.search(vim.g.slime_cell_delimiter)
      end

      local function prev_cell()
        vim.fn.search(vim.g.slime_cell_delimiter, "b")
      end

      vim.keymap.set('n', '<leader>cd', vim.cmd.SlimeSend, { noremap = true, desc = 'send line to term' })
      vim.keymap.set('n', '<leader>cv', vim.cmd.SlimeConfig, { noremap = true, desc = "Open slime configuration" })
      vim.keymap.set('x', '<leader>cs', '<Plug>SlimeRegionSend', { noremap = true, desc = 'send line to tmux' })
      vim.keymap.set('n', '<leader>cp', '<Plug>SlimeParagraphSend', { noremap = true, desc = "Send Paragraph with Slime" })
      vim.keymap.set('n', '<leader>ck', prev_cell, { noremap = true, desc = "Search backward for slime cell delimiter" })
      vim.keymap.set('n', '<leader>cj', next_cell, { noremap = true, desc = "Search forward for slime cell delimiter" })
      vim.keymap.set('n', '<leader>cc', '<Plug>SlimeSendCell', { noremap = true, desc = "Send cell to slime" })

      local slime_get_jobid = function()
        local buffers = vim.api.nvim_list_bufs()
        local terminal_buffers = { "Select terminal:\tjobid\tname", }
        local name = ""
        local jid = 1
        local chosen_terminal = 1

        for _, buf in ipairs(buffers) do
          if vim.bo[buf].buftype == 'terminal' then
            jid = vim.api.nvim_buf_get_var(buf, 'terminal_job_id')
            name = vim.api.nvim_buf_get_name(buf)
            table.insert(terminal_buffers, jid .. "\t" .. name)
          end
        end

        -- if there is more than one terminal, ask which one to use
        if #terminal_buffers > 2 then
          chosen_terminal = vim.fn.inputlist(terminal_buffers)
        else
          chosen_terminal = jid
        end

        if chosen_terminal then
          print("\n[slime] jobid chosen: ", chosen_terminal)
          return chosen_terminal
        else
          print("No terminal found")
        end
      end

      local function slime_use_tmux()
        vim.g.slime_target = "tmux"
        vim.g.slime_bracketed_paste = 1
        vim.g.slime_python_ipython = 0
        vim.g.slime_no_mappings = 1
        vim.g.slime_default_config = { socket_name = "default", target_pane = ":.2" }
        vim.g.slime_dont_ask_default = 1
      end

      local function slime_use_neovim()
        vim.g.slime_target = "neovim"
        vim.g.slime_bracketed_paste = 1
        vim.g.slime_python_ipython = 1
        vim.g.slime_no_mappings = 1
        vim.g.slime_get_jobid = slime_get_jobid
        -- vim.g.slime_default_config = nil
        -- vim.g.slime_dont_ask_default = 0
      end

     -- slime_use_neovim()
       slime_use_tmux()
      -- }}
    end
  },


	{ -- requires plugins in lua/plugins/treesitter.lua and lua/plugins/lsp.lua
		-- for complete functionality (language features)
		"quarto-dev/quarto-nvim",
		ft = { "quarto" },
		dev = false,
		opts = {
			lspFeatures = {
				languages = { "r", "python", "julia", "bash", "lua", "html", "dot", "javascript", "typescript", "ojs" },
			},
			codeRunner = {
				enabled = true,
				default_method = "slime",
			},
		},
		dependencies = {
			-- for language features in code cells
			-- configured in lua/plugins/lsp.lua and
			-- added as a nvim-cmp source in lua/plugins/completion.lua
			"jmbuhr/otter.nvim",
		},
	},

	{ -- directly open ipynb files as quarto docuements
		-- and convert back behind the scenes
		-- needs:
		-- pip install jupytext
		"GCBallesteros/jupytext.nvim",
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
			vim.keymap.set("n", "<leader>ii", ":PasteImage<cr>", { desc = "insert [i]mage from clipboard" })
		end,
	},

	{ -- preview equations
		"jbyuki/nabla.nvim",
		keys = {
			{ "<leader>qm", ':lua require"nabla".toggle_virt()<cr>', desc = "toggle [m]ath equations" },
		},
	},

	{
	"benlubas/molten-nvim",
    enable = false,
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    build = ":UpdateRemotePlugins",
    init = function()
        -- this is an example, not a default. Please see the readme for more configuration options
        vim.g.molten_output_win_max_height = 12
        vim.g.molten_auto_open_output = false
        vim.g.molten_auto_image_popup = true
    end,
    keys = {
      { "<leader>mi", ":MoltenInit<cr>", desc = "[m]olten [i]nit" },
			{
				"<leader>mv",
				":<C-u>MoltenEvaluateVisual<cr>",
				mode = "v",
				desc = "molten eval visual",
			},
			{ "<leader>mr", ":MoltenReevaluateCell<cr>", desc = "molten re-eval cell" },
		},
	},
}
