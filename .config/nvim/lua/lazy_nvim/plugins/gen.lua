-- Custom Parameters (with defaults)
return {
	"David-Kunz/gen.nvim",
	opts = {
		model = "deepseek-coder:6.7b", -- The default model to use.
		host = "localhost", -- The host running the Ollama service.
		port = "11434", -- The port on which the Ollama service is listening.
		display_mode = "float", -- The display mode. Can be "float" or "split".
		show_prompt = false, -- Shows the Prompt submitted to Ollama.
		show_model = true, -- Displays which model you are using at the beginning of your chat session.
		no_auto_close = false, -- Never closes the window automatically.
		prompt = "",
		init = function(options)
			pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
		end,
		-- Function to initialize Ollama
		command = function(options)
			return "curl --silent --no-buffer -X POST http://"
				.. options.host
				.. ":"
				.. options.port
				.. "/api/chat -d $body"
		end,
		-- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
		-- This can also be a command string.
		-- The executed command must return a JSON object with { response, context }
		-- (context property is optional).
		-- list_models = '<omitted lua function>', -- Retrieves a list of model names
		debug = false, -- Prints errors and the command which is run.
	},
	config = function()
		local prompts = require("gen").prompts

		prompts["Code Check"] = {
			mmodel = "deepseek-coder:6.7b",
			display_mode = "float", -- The display mode. Can be "float" or "split".
			prompt = "You are a fullstack developer, with knowledge in good practices of programming, architecture, and software engineering. It will help to improve the code by promoting improvements and providing code examples to be inserted.\n$text",
			replace = false,
			show_model = true, -- Displays which model you are using at the beginning of your chat session.
			no_auto_close = false, -- Never closes the window automatically.
		}

		prompts["Change Code"] = {
			model = "deepseek-coder:6.7b",
			prompt = "change the following code as said.",
			display_mode = "float", -- The display mode. Can be "float" or "split".
			replace = true,
			extract = "```$filetype\n(.-)```",
			no_auto_close = false,
		}

		vim.keymap.set("n", "<leader>gm", ":Gen<CR>", { desc = "main menu" })
		vim.keymap.set("v", "<leader>ge", ":Gen Enhance_Grammar_Spelling<CR>", { desc = "Enhance Grammar Spelling" })
		vim.keymap.set({ "n", "v" }, "<leader>ga", ":Gen Ask<CR>", { desc = "Ask" })
		vim.keymap.set({ "n", "v" }, "<leader>gc", ":Gen Change<CR>", { desc = "Change" })
		vim.keymap.set({ "n", "v" }, "<leader>gcc", ":Gen Change_Code<CR>", { desc = " Change Code" })
		vim.keymap.set({ "n", "v" }, "<leader>gce", ":Gen Enhance_Code<CR>", { desc = "Enhance code" })
		vim.keymap.set({ "n", "v" }, "<leader>gcw", ":Gen Enhance_Wording<CR>", { desc = "Enhace Wording" })
		vim.keymap.set({ "n", "v" }, "<leader>gcg", ":Gen Enhance_Grammar_Spelling<CR>", { desc = "Enhance Grammar" })
		vim.keymap.set({ "n", "v" }, "<leader>gg", ":Gen Generate<CR>", { desc = "Generate" })
		vim.keymap.set({ "n", "v" }, "<leader>gr", ":Gen Review_Code<CR>", { desc = "Review Code" })
		vim.keymap.set({ "n", "v" }, "<leader>gs", ":Gen Summarize<CR>", { desc = "Summarize" })
	end,
}
