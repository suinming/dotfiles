return {
  n = {
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
    -- git-worktree
    ["<leader>wl"] = { "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees() <CR>", desc = "git worktree list" },
    --TODO: vim-fugitive still need to figure out the best way
    ["<leader>G"] = { "<cmd>Gvdiffsplit! <CR>", desc = "3-way diff" },
    ["<leader>rj"] = { "<cmd>diffget //2 <CR>", desc = "get target branch" },
    ["<leader>rk"] = { "<cmd>diffget //3 <CR>", desc = "get merge branch" },
  },
  v = {},
  t = {},
}
