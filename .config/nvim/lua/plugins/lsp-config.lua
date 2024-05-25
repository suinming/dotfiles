function RenameWithQuickfix()
  local position_params = vim.lsp.util.make_position_params()
  local new_name = vim.fn.input("New Name > ")

  position_params.newName = new_name

  vim.lsp.buf_request(0, "textDocument/rename", position_params, function(err, method, result, ...)
    vim.lsp.handlers["textDocument/rename"](err, method, result, ...)

    local entries = {}
    if result.changes then
      for uri, edits in pairs(result.changes) do
        local bufnr = vim.uri_to_bufnr(uri)

        for _, edit in ipairs(edits) do
          local start_line = edit.range.start.line + 1
          local line = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, start_line, false)[1]

          table.insert(entries, {
            bufnr = bufnr,
            lnum = start_line,
            col = edit.range.start.character + 1,
            text = line,
          })
        end
      end
    end

    vim.fn.setqflist(entries, "r")
  end)
end

return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      lspconfig.tsserver.setup({
        capabilites = capabilities,
      })
      -- js
      lspconfig.volar.setup({
        capabilities = capabilities,
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
        init_options = {
          typescript = {
            tsdk =
            "/home/suinming/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib",
          },
        },
      })
      --[[ lspconfig.vuels.setup({
				capabilities = capabilities,
			}) ]]
      lspconfig.html.setup({
        capabilites = capabilities,
      })
      lspconfig.lua_ls.setup({
        capabilites = capabilities,
      })
      -- python
      lspconfig.ruff_lsp.setup({
        capabilites = capabilities,
      })
      -- sql
      lspconfig.sqls.setup({
        capabilites = capabilities,
      })
      -- md
      lspconfig.marksman.setup({
        capabilites = capabilities,
      })
      -- yaml
      lspconfig.yamlls.setup({
        capabilites = capabilities,
      })
      -- docker
      lspconfig.dockerls.setup({
        capabilites = capabilities,
      })
      lspconfig.docker_compose_language_service.setup({
        capabilites = capabilities,
      })
      -- keymap
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
      --[[ vim.keymap.set("n", "<leader>lr", RenameWithQuickfix) ]]
    end,
  },
  {
    "folke/trouble.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- setup the signs in the gutter
      local signs = {
        Error = " ",
        Warn = " ",
        Hint = "",
        Info = "",
      }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end
      -- keymap
      vim.keymap.set("n", "<leader>tt", function()
        require("trouble").toggle()
      end)
      vim.keymap.set("n", "<leader>tw", function()
        require("trouble").toggle("workspace_diagnostics")
      end)
      vim.keymap.set("n", "<leader>td", function()
        require("trouble").toggle("document_diagnostics")
      end)
      vim.keymap.set("n", "<leader>tq", function()
        require("trouble").toggle("quickfix")
      end)
      vim.keymap.set("n", "<leader>tl", function()
        require("trouble").toggle("loclist")
      end)
      vim.keymap.set("n", "tR", function()
        require("trouble").toggle("lsp_references")
      end)
      vim.diagnostic.config({
        virtual_text = true,
        underline = false,
      })
    end,
  },
  {
    -- for lsp features in code cells / embedded code
    "jmbuhr/otter.nvim",
    dev = false,
    dependencies = {
      {
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
        "hrsh7th/nvim-cmp",
      },
    },
    opts = {
      buffers = {
        set_filetype = true,
        write_to_disk = false,
      },
      handle_leading_whitespace = true,
    },
  },
}
