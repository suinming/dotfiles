local overrides = require "custom.configs.overrides"
---@type NvPluginSpec[]
local plugins = {
  -- Override plugin definition options
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  -- Install a plugin
  -- harpoon
  {
    "theprimeagen/harpoon",
  },
  -- fugitive
  {
    "tpope/vim-fugitive",
    lazy = false,
  },
  -- emmet
  {
    "mattn/emmet-vim",
    event = "VeryLazy",
  },
  -- surround
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
}
return plugins
