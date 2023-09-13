return {
  "karb94/neoscroll.nvim",
  event = "VeryLazy",
  config = function()
    require("neoscroll").setup {
      -- only C-u and C-d will emit the animation
      mappings = { "<C-u>", "<C-d>" },
    }
  end,
}
