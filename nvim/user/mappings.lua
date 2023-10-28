-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- make the file executable
    ["<leader>x"] = { "<cmd>!chmod +x %<CR>", desc = "make the file executable" },
    -- harpoon
    ["<leader>a"] = {
      "<cmd>lua require('harpoon.mark').add_file() <CR>",
      desc = "mark the file to harpoon menu",
    },
    ["<C-e>"] = { "<cmd>lua require('harpoon.ui').toggle_quick_menu() <CR>", desc = "toggle harpoon menu" },
    ["<leader>s"] = { "<cmd>lua require('harpoon.ui').nav_file(1) <CR>", desc = "switch to 1" },
    ["<leader>d"] = { "<cmd>lua require('harpoon.ui').nav_file(2) <CR>", desc = "switch to 2" },
    ["<leader>f"] = { "<cmd>lua require('harpoon.ui').nav_file(3) <CR>", desc = "switch to 3" },
    ["<leader>j"] = { "<cmd>lua require('harpoon.ui').nav_file(4) <CR>", desc = "switch to 4" },
    ["<leader>k"] = { "<cmd>lua require('harpoon.ui').nav_file(5) <CR>", desc = "switch to 5" },
    ["<leader>l"] = { "<cmd>lua require('harpoon.ui').nav_file(6) <CR>", desc = "switch to 6" },
    ["<leader>G"] = { "<cmd>Gvdiffsplit! <CR>", desc = "3-way diff" },
    ["<leader>rj"] = { "<cmd>diffget //2 <CR>", desc = "get target branch" },
    ["<leader>rk"] = { "<cmd>diffget //3 <CR>", desc = "get merge branch" },
    -- telescope image preview
    ["<leader>fp"] = {
      function() require("telescope").extensions.media_files.media_files() end,
      desc = "telescope image preview",
    },
  },
  v = {
    -- move the code block
    -- ["J"] = { "<cmd>m '>+1<CR>gv=gv", desc = "move the code block down" },
    -- ["K"] = { "<cmd>m '<-2<CR>gv=gv", desc = "move the code block up" },
  },
  t = {
    -- setting a mapping to false will disable it
    ["<esc>"] = false,
  },
}
