local win_id = 0
local win_buf = 0
local time = 5000

function DialogClose(timer)
    if win_id ~= 0 then
        vim.api.nvim_win_close(win_id, true)
        win_id = 0
    end
    if win_buf ~= 0 then
        vim.api.nvim_buf_delete(win_buf, { force = true })
        win_buf = 0
    end
end

function DialogCreate(messages, style)
    if win_buf ~= 0 then
        return
    end
    if messages == nil then
    end

    win_buf = vim.api.nvim_create_buf(false, true)
    vim.fn.setbufline(win_buf, 1, messages)

    local width = 40
    local height = 5
    local win_x = vim.o.columns - 1
    local win_y = vim.o.lines - 3

    win_id = vim.api.nvim_open_win(win_buf, false, {
        relative = "editor",
        anchor = "SE",
        row = win_y,
        col = win_x,
        width = width,
        height = height,
        focusable = false,
        style = "minimal",
        noautocmd = false,
        bufpos = { 0, 0 },
        border = "rounded",
    })

    vim.api.nvim_win_set_option(win_id, "wrap", true)
    if style ~= nil then
        vim.api.nvim_win_set_option(win_id, "winhighlight", "NormalFloat:" .. style .. ",FloatBorder:" .. style)
    end
    vim.fn.timer_start(time, DialogClose)
end

function DialogError(messages)
    DialogCreate(messages, "ErrorMsg")
end

function DialogWarn(messages)
    DialogCreate(messages, "WarningMsg")
end
