return {
	"pappasam/nvim-repl",
	init = function()
		vim.g["repl_filetype_commands"] = {
			javascript = "node",
			python = "ipython --no-autoindent",
		}
		vim.g["repl_split"] = "bottom"
		vim.g["repl_height"] = "15"
	end,
	keys = {
		{ "<leader>rt", "<cmd>ReplToggle<cr>" },
		{ "<leader>rr", "<cmd>ReplRunCell<cr>" },
		{ "<leader>rc", "<cmd>ReplClear<cr>" },
		{ "<leader>rj", "<plug>ReplSendLine" },
		{ "<leader>r", "<plug>ReplSendVisual", mode = "v" },
	},
	config = function()
		--[[ vim.keymap.set("n", "<leader>rt", "<cmd>ReplToggle<cr>", { desc = "toggle nvim-repl" })
		vim.keymap.set("n", "<leader>rr", "<cmd>ReplRunCell<cr>", { desc = "nvim-repl run cell" })
		vim.keymap.set("n", "<leader>rl", "<cmd>ReplSendLine<cr>", { desc = "nvim-repl run current cell" })
		vim.keymap.set("n", "<leader>rc", "<cmd>ReplClear<cr>", { desc = "nvim-repl clear" })
		vim.keymap.set("v", "<leader>r", "<cmd>ReplSendVisual<cr>", { desc = "nvim-repl execute the selected code" }) ]]
	end,
}
