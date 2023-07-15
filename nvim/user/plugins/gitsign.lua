return {
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
}
