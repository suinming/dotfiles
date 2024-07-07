return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		opts = {
			inlay_hints = { enabled = true },
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			lspconfig.tsserver.setup({
				capabilites = capabilities,
			})
			lspconfig.volar.setup({
				capabilities = capabilities,
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
				init_options = {
					vue = {
						hybridMode = false,
					},
				},
			})
			lspconfig.html.setup({
				capabilites = capabilities,
			})
			lspconfig.lua_ls.setup({
				capabilites = capabilities,
			})
			-- python
			lspconfig.pyright.setup({
				capabilites = capabilities,
			})
			-- sql
			lspconfig.sqls.setup({
				capabilites = capabilities,
			})
			-- md
			lspconfig.marksman.setup({
				capabilites = capabilities,
			})
			-- yaml
			lspconfig.yamlls.setup({
				capabilites = capabilities,
			})
			-- docker
			lspconfig.dockerls.setup({
				capabilites = capabilities,
			})
			lspconfig.docker_compose_language_service.setup({
				capabilites = capabilities,
			})
			-- c
			lspconfig.clangd.setup({
				capabilites = capabilities,
			})
			-- keymap
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
		end,
	},
	{
		"folke/trouble.nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- setup the signs in the gutter
			local signs = {
				Error = " ",
				Warn = " ",
				Hint = "",
				Info = "",
			}
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end
			-- keymap
			vim.keymap.set("n", "<leader>tt", function()
				require("trouble").toggle()
			end)
			vim.keymap.set("n", "<leader>tw", function()
				require("trouble").toggle("workspace_diagnostics")
			end)
			vim.keymap.set("n", "<leader>td", function()
				require("trouble").toggle("document_diagnostics")
			end)
			vim.keymap.set("n", "<leader>tq", function()
				require("trouble").toggle("quickfix")
			end)
			vim.keymap.set("n", "<leader>tl", function()
				require("trouble").toggle("loclist")
			end)
			vim.keymap.set("n", "tR", function()
				require("trouble").toggle("lsp_references")
			end)
			vim.diagnostic.config({
				virtual_text = true,
				underline = false,
			})
		end,
	},
	{
		-- for lsp features in code cells / embedded code
		"jmbuhr/otter.nvim",
		dev = false,
		dependencies = {
			{
				"neovim/nvim-lspconfig",
				"nvim-treesitter/nvim-treesitter",
				"hrsh7th/nvim-cmp",
			},
		},
		opts = {
			buffers = {
				set_filetype = true,
				write_to_disk = false,
			},
			handle_leading_whitespace = true,
		},
	},
}
