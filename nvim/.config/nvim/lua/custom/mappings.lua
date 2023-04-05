---@type MappingsTable
local M = {}

-- more keybinds!
M.suinming = {
  n = {
    ["<leader>x"] = { "<cmd>!chmod +x %<CR>", "make the file executable", opts = { silent = true } },
  },
  v = {
    ["J"] = { ":m '>+1<CR>gv=gv", "move the block of code downward" },
    ["K"] = { ":m '>-2<CR>gv=gv", "move the block of code upward" },
  },
}

M.harpoon = {
  n = {
    ["<leader><leader>"] = { ":lua require('harpoon.mark').add_file() <CR>", "mark the file to harpoon menu" },
    ["<C-e>"] = { ":lua require('harpoon.ui').toggle_quick_menu() <CR>", "toggle harpoon menu" },
    ["<leader>a"] = { ":lua require('harpoon.ui').nav_file(1) <CR>", "switch to 1" },
    ["<leader>s"] = { ":lua require('harpoon.ui').nav_file(2) <CR>", "switch to 2" },
    ["<leader>d"] = { ":lua require('harpoon.ui').nav_file(3) <CR>", "switch to 3" },
    ["<leader>f"] = { ":lua require('harpoon.ui').nav_file(4) <CR>", "switch to 4" },
    ["<leader>e"] = { ":lua require('harpoon.ui').nav_file(5) <CR>", "switch to 5" },
    ["<leader>r"] = { ":lua require('harpoon.ui').nav_file(6) <CR>", "switch to 6" },
  },
}

return M
