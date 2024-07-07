return {
  "mistweaverco/kulala.nvim",
  config = function()
    require("kulala").setup({
      debug = false,      -- Enable debug mode
      default_view = "body", -- body or headers
    })
    vim.keymap.set("n", "<leader>kr", "<cmd>lua require('kulala').run() <CR>", {})
  end,
}
