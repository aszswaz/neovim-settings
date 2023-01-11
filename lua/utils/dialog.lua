local util = require "utils/util"

local timer_start = vim.fn.timer_start
local timer_stop = vim.fn.timer_stop
local setbufline = vim.fn.setbufline

local nvim_win_close = vim.api.nvim_win_close
local nvim_buf_delete = vim.api.nvim_buf_delete
local nvim_create_buf = vim.api.nvim_create_buf
local nvim_open_win = vim.api.nvim_open_win
local nvim_win_set_option = vim.api.nvim_win_set_option

local M = {}
local time = 10000
local winId = nil
local winBuf = nil
local timerId = nil

function M.close(timer)
    if timer ~= nil and timer == timerId then
        timer_stop(timer)
        timerId = nil
    end
    if winId ~= nil then
        nvim_win_close(winId, true)
        winId = nil
    end
    if winBuf ~= nil then
        nvim_buf_delete(winBuf, { force = true })
        winBuf = nil
    end
end

-- 创建一个只读对话框
function M.create_readonly_dialog(messages, style)
    M.close(timerId)

    winBuf = nvim_create_buf(false, true)
    setbufline(winBuf, 1, messages)

    local mLen = util.strlens(messages)
    local width = math.max(math.min(60, mLen), 40)
    local height = math.max(5, math.min(30, math.ceil(mLen / width)))
    local winX = vim.o.columns - 1
    local winY = vim.o.lines - 3

    winId = nvim_open_win(winBuf, false, {
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

    nvim_win_set_option(winId, "wrap", true)
    if style ~= nil then
        nvim_win_set_option(winId, "winhighlight", "NormalFloat:" .. style .. ",FloatBorder:" .. style)
    end

    timerId = timer_start(time, M.close)
end

function M.error(messages)
    M.create_readonly_dialog(messages, "ErrorMsg")
end

function M.warn(messages)
    M.create_readonly_dialog(messages, "WarningMsg")
end

function M.info(messages)
    M.create_readonly_dialog(messages, "String")
end

return M
