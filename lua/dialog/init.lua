local setbufline = vim.fn.setbufline

local createBuf = vim.api.nvim_create_buf

local M = {}

-- Create a dialog centered on the screen.
function M.central(message)
    local buf = createBuf(false, true)
    setbufline(buf, 1, message)

    local width = 80
    local height = 20
    local x = vim.o.columns / 2 - width / 2
    local y = vim.o.lines / 2 - height / 2

    local win = openWin(buf, true, {
        relative = "editor",
        col = x,
        row = y,
        width = width,
        height = height,
        border = "double",
    })
end

return {
    central = M.central,
}
