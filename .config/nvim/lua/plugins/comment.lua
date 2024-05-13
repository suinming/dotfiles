return {
	{
		"numToStr/Comment.nvim",
		opts = {},
		lazy = false,
		config = function()
			require("Comment").setup({
				---LHS of toggle mappings in NORMAL mode
				toggler = {
					line = "fk",
					block = "fj",
				},
				---LHS of operator-pending mappings in NORMAL and VISUAL mode
				opleader = {
					line = "fk",
					block = "fj",
				},
			})
		end,
	},
	{
		"folke/todo-comments.nvim",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
}
