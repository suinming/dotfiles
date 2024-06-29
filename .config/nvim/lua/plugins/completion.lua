return {
	{
		"L3MON4D3/LuaSnip",
		lazy = false,
		dependencies = {
			"rafamadriz/friendly-snippets",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{
		"hrsh7th/cmp-nvim-lsp",
		lazy = false,
		config = true,
	},
	{
		"hrsh7th/nvim-cmp",
		lazy = false,
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			cmp.setup({
				window = {
					documentation = cmp.config.window.bordered(),
					completion = cmp.config.window.bordered(),
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-j>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-k>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "otter" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
	-- {
	-- 	"echasnovski/mini.completion",
	-- 	version = false,
	-- 	config = function()
	-- 		require("mini.completion").setup({
	-- 			mappings = {
	-- 				force_twostep = "",
	-- 				force_fallback = "",
	-- 			},
	-- 		})
	-- 		vim.keymap.set("i", "<C-j>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
	-- 		vim.keymap.set("i", "<C-k>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
	-- 	end,
	-- },
	{
		"tmsvg/pear-tree",
		lazy = false,
	},
	{
		"mattn/emmet-vim",
		lazy = false,
	},
}
