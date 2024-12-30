return {
  {
    "echasnovski/mini.nvim",
    config = function()
      local icons = require("mini.icons")
      icons.setup({})

      -- local statusline = require "mini.statusline"
      -- statusline.setup {}

      local git = require("mini.git")
      git.setup({})

      local diff = require("mini.diff")
      diff.setup({})

      local files = require("mini.files")
      files.setup({
        windows = {
          preview = true,
          width_preview = 80,
        },
      })
      vim.keymap.set("n", "<leader>e", "<cmd>lua MiniFiles.open() <CR>", {})
    end,
  },
}
