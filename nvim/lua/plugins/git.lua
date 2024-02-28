return {
  {
    "tpope/vim-fugitive",
    lazy = false,
  },
  {
    "tpope/vim-unimpaired",
    lazy = false,
  },
  {
    "polarmutex/git-worktree.nvim",
    config = function()
      vim.keymap.set(
        "n",
        "<leader>wl",
        "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees() <CR>",
        {}
      )
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
      vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
      vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", {})
    end,
  },
}
