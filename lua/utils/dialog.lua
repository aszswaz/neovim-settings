require "utils/util"

local dialogs = {}
local time = 5000
dialog = {}

dialog.close = function(timer)
    vim.api.nvim_win_close(dialogs[1].winId, true)
    vim.api.nvim_buf_delete(dialogs[1].winBuf, { force = true })
    table.remove(dialogs, 1)
end

-- Create a dialog.
dialog.create = function(messages, style)
    local winBuf = vim.api.nvim_create_buf(false, true)
    vim.fn.setbufline(winBuf, 1, messages)

    local mLen = string:strlens(messages)
    local width = math.max(math.min(60, mLen), 40)
    local height = math.max(5, math.min(30, math.ceil(mLen / width)))
    local winX = vim.o.columns - 1
    local winY = vim.o.lines - 3

    local winId = vim.api.nvim_open_win(winBuf, false, {
        relative = "editor",
        anchor = "SE",
        row = winY,
        col = winX,
        width = width,
        height = height,
        focusable = false,
        style = "minimal",
        noautocmd = false,
        bufpos = { 0, 0 },
        border = "rounded",
    })

    vim.api.nvim_win_set_option(winId, "wrap", true)
    if style ~= nil then
        vim.api.nvim_win_set_option(winId, "winhighlight", "NormalFloat:" .. style .. ",FloatBorder:" .. style)
    end

    table.insert(dialogs, { winId = winId, winBuf = winBuf })
    vim.fn.timer_start(time, dialog.close)
end

dialog.error = function(messages)
    dialog.create(messages, "ErrorMsg")
end

dialog.warn = function(messages)
    dialog.create(messages, "WarningMsg")
end

dialog.info = function(messages)
    dialog.create(messages, "String")
end
