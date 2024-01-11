return {
	"pappasam/nvim-repl",
	init = function()
		vim.g["repl_filetype_commands"] = {
			javascript = "node",
			python = "ipython --no-autoindent",
		}
	end,
	keys = {
		{ "<leader>rt", "<cmd>ReplToggle<cr>", desc = "Toggle nvim-repl" },
		{ "<leader>rr", "<cmd>ReplRunCell<cr>", desc = "nvim-repl run cell" },
		{ "<leader>rl", "<cmd>ReplSendLine<cr>", desc = "nvim-repl run current line" },
		{ "<leader>rc", "<cmd>ReplClear<cr>", desc = "clear nvim-repl" },
	},
}
