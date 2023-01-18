-- Dialog box. A read-only, centered floating window.
local M = {}

function M.create(message)
    local buf = vim.api.nvim_create_buf(false, true)
    vim.fn.setbufline(buf, 1, message)
    vim.api.nvim_buf_set_option(buf, "modifiable", false)

    local width = 80
    local height = 20
    local x = vim.o.columns / 2 - width / 2
    local y = vim.o.lines / 2 - height / 2

    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        col = x,
        row = y,
        width = width,
        height = height,
        border = "double",
    })
end

return { create = M.create }
