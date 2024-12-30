require("config.lazy")

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.swapfile = false

-- source current file
vim.keymap.set("n", "<space>x", "<cmd>source %<CR>")

-- highlight when yanking (copying) text
--  try it with `yap` in normal mode
--  see `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- remove line number in nvim terminal
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

-- open small nvim terminal at the bottom
local job_id = 0
vim.keymap.set("n", "<space>st", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J") -- put terminal at the bottom
  vim.api.nvim_win_set_height(0, 5)
  job_id = vim.bo.channel
end)

-- send command to nvim terminal
vim.keymap.set("n", "<space>cmd", function()
  -- example: send ls -al command
  vim.fn.chansend(job_id, { "ls -al\r\n" })
end)
