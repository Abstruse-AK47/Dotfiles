return {
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		keys = {
			{ "<leader>oo", "<cmd>ObsidianOpen<cr>", desc = "Obsidian Open" },
			{ "<leader>on", "<cmd>ObsidianNew<cr>", desc = "Obdsidian New Note" },
			{ "<leader>ot", "<cmd>ObsidianTags<cr>", desc = "Search Tags" },
		},
		event = {
			--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
			--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
			"BufReadPre " .. vim.fn.expand("/mnt/d/Vault/**/*.md"),
			"BufNewFile " .. vim.fn.expand("/mnt/d/Vault/**/*.md"),
		},
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",

			-- see below for full list of optional dependencies 👇
		},
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("obsidian").setup({
				ui = { enable = false },
				workspaces = {
					{
						name = "Idk",
						path = "/mnt/d/Vault/Idk",
					},
				},
				mappings = {
					-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
					["gf"] = {
						action = function()
							return require("obsidian").util.gf_passthrough()
						end,
						opts = { noremap = false, expr = true, buffer = true },
					},
					-- create and toggle checkboxes
					["<cr>"] = {
						action = function()
							local line = vim.api.nvim_get_current_line()
							if line:match("%s*- %[") then
								require("obsidian").util.toggle_checkbox()
							elseif line:match("%s*-") then
								vim.cmd([[s/-/- [ ]/]])
								vim.cmd.nohlsearch()
							end
						end,
						opts = { buffer = true },
					},
				},
				-- Optional, customize how names/IDs for new notes are created.
				note_id_func = function(title)
					-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
					-- In this case a note with the title 'My new note' will be given an ID that looks
					-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
					local suffix = ""
					if title ~= nil then
						-- If title is given, transform it into valid file name.
						suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
					else
						-- If title is nil, just add 4 random uppercase letters to the suffix.
						for _ = 1, 4 do
							suffix = suffix .. string.char(math.random(65, 90))
						end
					end
					return tostring(os.time()) .. "-" .. suffix
				end,
				daily_notes = {
					-- Optional, if you keep daily notes in a separate directory.
					folder = "Daily",
					-- Optional, if you want to change the date format for the ID of daily notes.
					date_format = "%Y-%m-%d",
					-- Optional, if you want to change the date format of the default alias of daily notes.
					alias_format = "%B %-d, %Y",
					-- Optional, default tags to add to each new daily note created.
					default_tags = { "daily-notes" },
					-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
					template = nil,
				},
			})

			vim.wo.conceallevel = 1
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons", opt = true },
		opts = {
			latex = { enabled = false },
			win_options = { conceallevel = { rendered = 2 } },
			on = {
				attach = function()
					require("nabla").enable_virt({ autogen = true })
				end,
			},
			-- code = { sign = false },
			checkbox = {
				unchecked = { icon = "✘ " },
				checked = { icon = "✔ " },
				custom = {
					important = { raw = "[~]", rendered = "󰓎 ", highlight = "DiagnosticWarn" },
				},
			},
			heading = {
				backgrounds = { "none" },
			},
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install && git restore .",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
		keys = {
			{
				"<leader>mp",
				ft = "markdown",
				"<cmd>MarkdownPreviewToggle<cr>",
				desc = "Markdown Preview",
			},
		},
	},

	{
		"bullets-vim/bullets.vim",
		config = function()
			-- Disable deleting the last empty bullet when pressing <cr> or 'o'
			-- default = 1
			vim.g.bullets_delete_last_bullet_if_empty = 1
			vim.g.bullets_line_spacing = 2

			-- (Optional) Add other configurations here
			-- For example, enabling/disabling mappings
			-- vim.g.bullets_set_mappings = 1
		end,
	},
}
