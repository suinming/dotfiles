return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        -- python
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.black,
        -- js
        require("none-ls.diagnostics.eslint_d"),
        --[[ null_ls.builtins.diagnostics.eslint_d, ]]
        -- require("none-ls.code_actions.eslint_d"),
      },
    })
    vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, {})
  end,
}
