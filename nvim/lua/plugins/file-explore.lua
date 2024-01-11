return {
	{
		"ThePrimeagen/harpoon",
		config = function()
			local keymap = vim.keymap
			-- menu
			keymap.set("n", "<C-e>", "<cmd>lua require('harpoon.ui').toggle_quick_menu() <CR>", {})
			-- add file
			keymap.set("n", "<leader>a", "<cmd>lua require('harpoon.mark').add_file() <CR>", {})
			-- nav file
			keymap.set("n", "<leader>s", "<cmd>lua require('harpoon.ui').nav_file(1) <CR>", {})
			keymap.set("n", "<leader>d", "<cmd>lua require('harpoon.ui').nav_file(2) <CR>", {})
			keymap.set("n", "<leader>f", "<cmd>lua require('harpoon.ui').nav_file(3) <CR>", {})
			keymap.set("n", "<leader>j", "<cmd>lua require('harpoon.ui').nav_file(4) <CR>", {})
			keymap.set("n", "<leader>k", "<cmd>lua require('harpoon.ui').nav_file(5) <CR>", {})
			keymap.set("n", "<leader>l", "<cmd>lua require('harpoon.ui').nav_file(6) <CR>", {})
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				-- show the tab
				source_selector = {
					winbar = true,
					content_layout = "center",
					sources = {
						{ source = "filesystem" },
						-- { source = "git_status", display_name = " Git" },
					},
				},
			})
			vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", {})
			vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})
		end,
	},
	{
		"stevearc/oil.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup()
			vim.keymap.set("n", "<leader>O", "<CMD>Oil<CR>", {})
		end,
	},
}
