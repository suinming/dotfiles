return {
	{
		"benlubas/molten-nvim",
		version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
		dependencies = { "3rd/image.nvim" },
		build = ":UpdateRemotePlugins",
		init = function()
			-- these are examples, not defaults. Please see the readme
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_output_win_max_height = 20
		end,
	},
	{
		"vhyrro/luarocks.nvim",
		priority = 1001, -- this plugin needs to run before anything else
		opts = {
			rocks = { "magick" },
		},
	},
	{
		-- see the image.nvim readme for more information about configuring this plugin
		"3rd/image.nvim",
		dependencies = { "luarocks.nvim" },
		opts = {
			backend = "ueberzug", -- whatever backend you would like to use
			max_width = 100,
			max_height = 12,
			max_height_window_percentage = math.huge,
			max_width_window_percentage = math.huge,
			window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
			window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
		},
	},
	{ -- requires plugins in lua/plugins/treesitter.lua and lua/plugins/lsp.lua
		-- for complete functionality (language features)
		"quarto-dev/quarto-nvim",
		ft = { "quarto" },
		dev = false,
		dependencies = {
			-- for language features in code cells
			-- configured in lua/plugins/lsp.lua and
			-- added as a nvim-cmp source in lua/plugins/completion.lua
			"jmbuhr/otter.nvim",
		},
		config = function()
			local quarto = require("quarto")
			quarto.setup({
				lspFeatures = {
					languages = { "python", "r", "rust" },
					chunks = "all",
					diagnostics = {
						enabled = true,
						triggers = { "BufWritePost" },
					},
					completion = {
						enabled = true,
					},
				},
				keymap = {
					hover = "K",
					definition = "gd",
					rename = "<leader>rn",
					references = "gr",
					format = "<leader>lf",
				},
				codeRunner = {
					enabled = true,
					default_method = "molten",
				},
			})
			local runner = require("quarto.runner")
			vim.keymap.set("n", "<leader>rc", runner.run_cell, { desc = "run cell", silent = true })
			vim.keymap.set("n", "<leader>ra", runner.run_above, { desc = "run cell and above", silent = true })
			vim.keymap.set("n", "<leader>rA", runner.run_all, { desc = "run all cells", silent = true })
			vim.keymap.set("n", "<leader>rl", runner.run_line, { desc = "run line", silent = true })
			vim.keymap.set("v", "<leader>r", runner.run_range, { desc = "run visual range", silent = true })
			vim.keymap.set("n", "<leader>RA", function()
				runner.run_all(true)
			end, { desc = "run all cells of all languages", silent = true })
		end,
	},
}
