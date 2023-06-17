return {
  "chentoast/marks.nvim",
  event = "VeryLazy",
  config = function()
    require("marks").setup {
      default_mappings = true,
      signs = true,
      mappings = {
        set_next = "mm",
        next = "mn",
        prev = "mp",
        delete_line = "dmm",
      },
    }
  end,
}
