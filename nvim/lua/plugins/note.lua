return {
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "digitalMind",
          path = "~/repo/digitalMind/",
        },
      },
      notes_subdir = "notes",
      templates = {
        subdir = "templates",
      },
      completion = {
        -- Where to put new notes. Valid options are
        --  * "current_dir" - put new notes in same directory as the current buffer.
        --  * "notes_subdir" - put new notes in the default notes subdirectory.
        new_notes_location = "notes_subdir",
      },
      -- Optional, boolean or a function that takes a filename and returns a boolean.
      -- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
      disable_frontmatter = true,
      -- Specify how to handle attachments.
      attachments = {
        img_folder = "imgs",
        -- A function that determines the text to insert in the note when pasting an image.
        -- It takes two arguments, the `obsidian.Client` and a plenary `Path` to the image file.
        -- This is the default implementation.
        ---@param client obsidian.Client
        ---@param path Path the absolute path to the image file
        ---@return string
        img_text_func = function(client, path)
          local link_path
          local vault_relative_path = client:vault_relative_path(path)
          if vault_relative_path ~= nil then
            -- Use relative path if the image is saved in the vault dir.
            link_path = vault_relative_path
          else
            -- Otherwise use the absolute path.
            link_path = tostring(path)
          end
          local display_name = vim.fs.basename(link_path)
          return string.format("![%s](%s)", display_name, link_path)
        end,
      },
    },
    keys = {
      { "<leader>on", "<cmd>ObsidianNew<CR>",      desc = "create new Note" },
      { "<leader>ot", "<cmd>ObsidianTemplate<CR>", desc = "insert template" },
      {
        "<leader>of",
        "<cmd>ObsidianSearch<CR>",
      },
      {
        "<leader>op",
        "<cmd>ObsidianPasteImg<CR>",
      },
    },
  },
  {
    "JellyApple102/flote.nvim",
    config = function()
      require("flote").setup({
        q_to_quit = true,
        window_style = "minimal",
        window_border = "solid",
        window_title = true,
        notes_dir = vim.fn.stdpath("cache") .. "/flote",
        files = {
          global = "flote-global.md",
          cwd = function()
            return vim.fn.getcwd()
          end,
          file_name = function(cwd)
            local base_name = vim.fs.basename(cwd)
            local parent_base_name = vim.fs.basename(vim.fs.dirname(cwd))
            return parent_base_name .. "_" .. base_name .. ".md"
          end,
        },
      })
      vim.keymap.set("n", "<leader>fl", "<cmd>Flote<CR>", {})
      vim.keymap.set("n", "<leader>fg", "<cmd>Flote global<CR>", {})
    end,
  },
}
