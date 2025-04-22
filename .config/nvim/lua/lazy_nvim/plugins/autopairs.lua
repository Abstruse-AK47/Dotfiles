return {
	{
		"windwp/nvim-autopairs",
		event = { "InsertEnter" },
		dependencies = {
			"hrsh7th/nvim-cmp",
		},
		config = function()
			-- import nvim-autopairs
			local autopairs = require("nvim-autopairs")

			-- configure autopairs
			autopairs.setup({
				check_ts = true, -- enable treesitter
				ts_config = {
					lua = { "string" }, -- don't add pairs in lua string treesitter nodes
					javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
					java = false, -- don't check treesitter on java
				},
			})

			-- import nvim-autopairs completion functionality
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")

			-- import nvim-cmp plugin (completions plugin)
			local cmp = require("cmp")

			-- make autopairs and completion work together
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
	{
		"kylechui/nvim-surround",
		event = { "BufReadPre", "BufNewFile" },
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = true,
	},
	{
		"polirritmico/simple-boolean-toggle.nvim",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" }, -- For lazy loading
		keys = {
			{
				"<leader>tb",
				":lua require('simple-boolean-toggle').toggle_builtins()<Cr>",
				desc = "Boolean Toggle: On/Off",
			},
		},
		opts = {
			extend_booleans = {
				-- Use only Title Case, upper and lower cases are auto-generated
				{ "High", "Low" },
				-- Manually define upper and lower case variants for auto-generation
				-- { "Something", "Nothing", { uppercase = true, lowercase = false } },
				-- Or match only one case:
				-- { "foO", "bAR", { uppercase = false, lowercase = false } },
			},
		},
	},
}
