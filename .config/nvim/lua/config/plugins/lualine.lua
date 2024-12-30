return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local lsp_detect = function()
      local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
      if #clients > 0 then
        local names = {}
        for _, client in ipairs(clients) do
          table.insert(names, client.name)
        end
        return table.concat(names, ", ")
      end
      return nil
    end
    require("lualine").setup({
      options = {
        theme = "rose-pine",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          "branch",
          "diff",
          {
            "diagnostics",
            -- Table of diagnostic sources, available sources are:
            --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
            -- or a function that returns a table as such:
            --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
            sources = { "nvim_diagnostic", "coc" },

            -- Displays diagnostics for the defined severity types
            sections = { "error", "warn", "info", "hint" },

            diagnostics_color = {
              -- Same values as the general color option can be used here.
              error = "DiagnosticError", -- Changes diagnostics' error color.
              warn = "DiagnosticWarn", -- Changes diagnostics' warn color.
              info = "DiagnosticInfo", -- Changes diagnostics' info color.
              hint = "DiagnosticHint", -- Changes diagnostics' hint color.
            },
            symbols = { error = "E", warn = "W", info = "I", hint = "H" },
            colored = true, -- Displays diagnostics status in color if set to true.
            update_in_insert = false, -- Update diagnostics in insert mode.
            always_visible = false, -- Show diagnostics even if there are none.
          },
        },
        lualine_c = {
          {
            "filename",
            file_status = true, -- displays file status (readonly status, modified status)
            path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
          },
        },
        lualine_x = {
          lsp_detect,
        },
        lualine_y = { "selectioncount" },
        lualine_z = { "%l/%L" },
      },
    })
  end,
}
