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

			-- mini.statusline
			require("mini.statusline").setup({
				content = {
					-- This section defines what is shown in the active and inactive status lines
					active = function()
						local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
						local git = MiniStatusline.section_git({ trunc_width = 40 })
						local diff = MiniStatusline.section_diff({ trunc_width = 75 })
						local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
						local filename = MiniStatusline.section_filename({ trunc_width = 140 })

						return MiniStatusline.combine_groups({
							{ hl = mode_hl, strings = { mode } },
							{ hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics } },
							"%<", -- Mark general truncate point
							{ hl = "MiniStatuslineFilename", strings = { filename } },
							"%=",
						})
					end,
					-- This section defines what is shown in the inactive status line
					inactive = function()
						return MiniStatusline.combine_groups({
							{ hl = "MiniStatuslineInactive", strings = { "%f" } },
						})
					end,
				},
				use_icons = true, -- Use icons for diagnostic and git symbols
				set_vim_settings = true, -- Whether to set Vim's related options
			})
		end,
	},
	{
		"vimpostor/vim-tpipeline",
	},
}
