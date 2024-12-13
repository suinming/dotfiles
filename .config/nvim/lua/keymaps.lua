-- keybind to check diff of staged file under cursor
vim.api.nvim_set_keymap('n', '<leader>gd', ':lua ShowDiffUnderCursor()<CR>', { noremap = true, silent = true })

function ShowDiffUnderCursor()
    -- get the filename under the cursor
    local filename = vim.fn.expand("<cfile>")
    if filename ~= '' then
        vim.cmd('vertical Git diff --staged ' .. filename)
    else
        print("No filename under cursor")
    end
end
