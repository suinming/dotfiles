return {
  "nvim-neo-tree/neo-tree.nvim",
  config = function()
    local get_icon = require("astronvim.utils").get_icon
    require("neo-tree").setup {
      -- show the tab
      source_selector = {
        winbar = true,
        content_layout = "center",
        sources = {
          { source = "filesystem",  display_name = get_icon "FolderClosed" .. " File" },
          { source = "buffers",     display_name = get_icon "DefaultFile" .. " Bufs" },
          { source = "git_status",  display_name = get_icon "Git" .. " Git" },
          { source = "diagnostics", display_name = get_icon "Diagnostic" .. " Diagnostic" },
        },
      },
      filesystem = {
        window = {
          mappings = {
            ["<leader>p"] = "image_wezterm", -- " or another map
          },
        },
        commands = {
          image_wezterm = function(state)
            local node = state.tree:get_node()
            if node.type == "file" then require("image_preview").PreviewImage(node.path) end
          end,
        },
      },
    }
  end,
}
