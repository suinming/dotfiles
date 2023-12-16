return {
  -- add the plugins with less configuration
  {
    "mattn/emmet-vim",
    event = "VeryLazy",
  },
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
  },
  {
    "polarmutex/git-worktree.nvim",
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        -- change = { text = "C" },
        delete = { text = "-" },
        topdelete = { text = "TD" },
        changedelete = { text = "CD" },
        untracked = { text = "UT" },
      },
    },
    event = "User AstroGitFile",
  },
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      require("luasnip.loaders.from_vscode").lazy_load { paths = { "./lua/user/snippets" } } -- load snippets paths
    end,
  },
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    config = function()
      require("neoscroll").setup {
        -- only C-u and C-d will emit the animation
        mappings = { "<C-u>", "<C-d>" },
      }
    end,
  },
}
