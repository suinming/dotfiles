local state = {
  floating = {
    buf = -1,
    win = -1,
  }
}

local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  -- calculate the position to center the window
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- create a buffer
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- no file, scratch buffer
  end

  -- define window configuration
  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal", -- no borders or extra UI elements
    border = "rounded",
  }

  -- create the floating window
  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

local job_id = 0
local toggle_terminal = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
  job_id = vim.bo[state.floating.buf].channel
end

-- leave terminal mode
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

-- toggle terminal
vim.keymap.set({ "t", "n" }, "<leader>tt", toggle_terminal)

-- send `git add --all && git commit` command to nvim terminal
vim.keymap.set("n", "<space>gcc", function()
  -- toggle terminal
  toggle_terminal()
  -- use job_id to send the terminal command
  vim.fn.chansend(job_id, { "git add --all && git commit\r\n" })
end)
