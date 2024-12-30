return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
      {
        "folke/lazydev.nvim",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local lspconfig = require("lspconfig")
      local lsp_servers = { "lua_ls", "emmet_language_server" }

      for _, lsp in ipairs(lsp_servers) do
        lspconfig[lsp].setup({
          capabilities = capabilities,
        })
      end

      -- helper function to determine if Vue 2 is used
      local function is_vue2_project()
        local package_json_path = vim.fn.getcwd() .. "/package.json"
        local file = io.open(package_json_path, "r")
        if not file then
          return false -- If no package.json exists, assume it's not a Vue 2 project.
        end

        local content = file:read("*a")
        file:close()

        -- Search for the "vue" key in dependencies with a version starting with "2"
        local vue_version = content:match('"vue"%s*:%s*"(%^?2[%d%.]*)"')
        if vue_version then
          return true
        end
        return false
      end

      -- configure the appropriate LSP based on the Vue version
      if is_vue2_project() then
        print("Detected Vue 2 project. Configuring vuels...")
        -- vue2
        lspconfig.vuels.setup({
          capabilities = capabilities,
        })
      else
        print("Configuring ts_ls, volar...")
        lspconfig.ts_ls.setup({
          capabilities = capabilities,
          init_options = {
            plugins = {
              {
                name = "@vue/typescript-plugin",
                location = "@vue/typescript-plugin",
                languages = { "javascript", "typescript", "vue" },
              },
            },
          },
          filetypes = { "javascript", "typescript", "vue" },
        })
        lspconfig.volar.setup({
          capabilities = capabilities,
        })
      end
    end,
  },
}
