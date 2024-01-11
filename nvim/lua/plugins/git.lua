return {
  {
    "tpope/vim-fugitive",
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
}
