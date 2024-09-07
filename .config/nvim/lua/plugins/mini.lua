return {
	{
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			-- mini.files
			require("mini.files").setup({
				windows = {
					preview = true,
					width_preview = 80,
				},
			})
			vim.keymap.set("n", "<leader>e", "<cmd>lua MiniFiles.open() <CR>", {})

			-- mini.completion
			require("mini.completion").setup({})
			local imap_expr = function(lhs, rhs)
				vim.keymap.set("i", lhs, rhs, { expr = true })
			end
			imap_expr("<C-j>", [[pumvisible() ? "\<C-n>" : "\<C-j>"]])
			imap_expr("<C-k>", [[pumvisible() ? "\<C-p>" : "\<C-k>"]])

			-- mini.icon
			require("mini.icons").setup({})

			-- mini.notify
			require("mini.notify").setup({})

			-- mini.git
			require("mini.git").setup({})

			-- mini.diff
			require("mini.diff").setup({
				view = {
					style = "sign",
				},
			})
		end,
	},
}
