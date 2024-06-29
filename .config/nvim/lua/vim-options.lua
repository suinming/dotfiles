vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set clipboard=unnamedplus")
vim.cmd("set clipboard+=unnamed")

-- global
vim.g.mapleader = " "

-- keymap
-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")
vim.wo.number = true

-- options
vim.opt.relativenumber = true
vim.opt.swapfile = false

-- set up ufo.nvim linenumber
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- gf cmd
vim.cmd("set path=.,src,@")
vim.cmd("set suffixesadd=.js,.jsx,.vue")
vim.cmd("set isfname+=@-@")
vim.cmd("set includeexpr=substitute(v:fname,'^@/','src/','')")

-- obsidian.nvim
vim.opt.conceallevel = 1

-- pear-tree
vim.g.pear_tree_pairs = {
  ["("] = { closer = ")" },
  ["["] = { closer = "]" },
  ["{"] = { closer = "}" },
  ["'"] = { closer = "'" },
  ['"'] = { closer = '"' },
  ['<!--'] = { closer = '-->' },
  ['/*'] = { closer = '*/' },
}
vim.g.pear_tree_smart_openers = 1
vim.g.pear_tree_smart_closers = 1
vim.g.pear_tree_smart_backspace = 1

-- molten
--[[ vim.g.python3_host_prog=vim.fn.expand("./pyenv/versions/stock-price-scraper/bin/python3") ]]

-- kulala
vim.filetype.add({
  extension = {
    ['http'] = 'http',
  },
})
vim.opt.splitright = true
