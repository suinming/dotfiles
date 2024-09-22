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
			local capabilities = require("mini.completion").completefunc_lsp()
			local lspconfig = require("lspconfig")
			local util = require("lspconfig.util")
			local mason_registry = require("mason-registry")
			local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
				.. "/node_modules/@vue/language-server"
			-- js, ts
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				init_options = {
					plugins = {
						{
							name = "@vue/typescript-plugin",
							location = vue_language_server_path,
							languages = { "vue" },
						},
					},
				},
			})
			-- vue
			local function get_vue_version()
				local root_dir = util.find_git_ancestor(vim.fn.getcwd()) or vim.fn.getcwd()
				local package_json = root_dir .. "/package.json"

				if vim.fn.filereadable(package_json) == 1 then
					local package_data = vim.fn.json_decode(vim.fn.readfile(package_json))
					local vue_version = package_data["dependencies"] and package_data["dependencies"]["vue"]
						or package_data["devDependencies"] and package_data["devDependencies"]["vue"]

					if vue_version then
						-- Strip any non-numeric characters like ^ or ~ from the version string
						local cleaned_version = vim.fn.matchstr(vue_version, [[\v\d+]])
						local version = tonumber(cleaned_version)
						return version
					end
				end
				return nil
			end

			local vue_version = get_vue_version()

			if vue_version == 3 then
				-- use volar for vue 3
				lspconfig.volar.setup({
					capabilities = capabilities,
					init_options = {
						vue = {
							hybridMode = false,
						},
					},
				})
			else
				-- use vetur (vuels) for vue 2
				lspconfig.vuels.setup({
					capabilities = capabilities,
					filetypes = { "vue" },
					root_dir = lspconfig.util.root_pattern("package.json", ".git"),
				})
			end
			-- lua
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
