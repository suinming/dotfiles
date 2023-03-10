-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

	-- packer 
	use 'wbthomason/packer.nvim'

	-- telescope
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.0',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

    -- bookmark
    use {'MattesGroeger/vim-bookmarks'}

	-- carbon-fox color scheme
	use "EdenEast/nightfox.nvim" -- Packer

	-- treesitter
	use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
			use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}	local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,
	}

	-- harpoon
	use('theprimeagen/harpoon')

	-- fugitive
	use('tpope/vim-fugitive')

	-- LSP
	use {
		'VonHeikemen/lsp-zero.nvim',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-buffer'},
			{'hrsh7th/cmp-path'},
			{'saadparwaiz1/cmp_luasnip'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-nvim-lua'},

			-- Snippets
			{'L3MON4D3/LuaSnip'},
			-- Snippet Collection (Optional)
			{'rafamadriz/friendly-snippets'},
		}
	}

    -- nvim comment
    use "terrortylor/nvim-comment"

    -- emmet
    use "mattn/emmet-vim"

    -- prettier
    use{"prettier/vim-prettier"}

    -- nvim autopairs
    use "windwp/nvim-autopairs"

    -- nvim xkbswitch
    use "lyokha/vim-xkbswitch"

end)
