return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
				ensure_installed = {
					"c",
          "cpp",
					"typescript",
					"javascript",
          "vue",
          "css",
					"jsdoc",
					"python",
          "sql",
					"lua",
					"xml",
					"http",
					"json",
					"nginx",
					"dockerfile",
          "yaml",
          "bash",
				},
			})
		end,
	},
}
