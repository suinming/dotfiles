return {
	"mistweaverco/kulala.nvim",
	config = function()
		require("lazy").setup({
			-- HTTP REST-Client Interface
			{ "mistweaverco/kulala.nvim" },
		})
		vim.keymap.set("n", "<leader>kr", "<cmd>lua require('kulala').run() <CR>", {})
	end,
}
