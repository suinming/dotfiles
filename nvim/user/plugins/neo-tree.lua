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
          { source = "git_status",  display_name = get_icon "Git" .. " Git" },
        },
      },
    }
  end,
}
