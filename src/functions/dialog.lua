local winId = nil
local winBuf = nil
local time = 5000
dialog = {}

dialog.close = function(timer)
    print(timer)
    if winId ~= nil then
        vim.api.nvim_win_close(winId, true)
        winId = nil
    end
    if winBuf ~= nil then
        vim.api.nvim_buf_delete(winBuf, { force = true })
        winBuf = nil
    end
end

-- Create a dialog.
dialog.create = function(messages, style)
    if winId ~= nil then
        return
    end

    winBuf = vim.api.nvim_create_buf(false, true)
    vim.fn.setbufline(winBuf, 1, messages)

    local mLen = string:strlens(messages)
    local width = math.max(math.min(60, mLen), 40)
    local height = math.max(5, math.min(30, math.ceil(mLen / width)))
    local winX = vim.o.columns - 1
    local winY = vim.o.lines - 3

    winId = vim.api.nvim_open_win(winBuf, false, {
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
