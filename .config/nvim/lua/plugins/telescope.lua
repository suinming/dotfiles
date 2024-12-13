return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim", "debugloop/telescope-undo.nvim" },
    config = function()
      local actions = require("telescope.actions")
      local builtin = require("telescope.builtin")

      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
        pickers = {
          find_files = {
            theme = "ivy",
          },
          live_grep = {
            theme = "ivy",
          },
        },
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-n>"] = false,
              ["<C-p>"] = false,
            },
          },
          layout_config = {
            horizontal = {
              preview_width = 0.5,
              results_width = 0.5,
            },
          },
        },
      })
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fw", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>pw", function()
        local word = vim.fn.expand("<cword>")
        builtin.grep_string({ search = word })
      end)
      vim.keymap.set("n", "<leader>pW", function()
        local word = vim.fn.expand("<cWORD>")
        builtin.grep_string({ search = word })
      end)
      require("telescope").load_extension("ui-select")
      require("telescope").load_extension("undo")
      vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
    end,
  },
}
