return {
	{
		"3rd/image.nvim",
		config = function()
			require("image").setup({
				max_width = 80,
				max_height = 20,
			})
		end,
	},
}
