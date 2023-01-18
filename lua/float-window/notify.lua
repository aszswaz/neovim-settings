local stringUtil = require "util.string"
local define = require "float-window.define"

-- Norification dialog. A read-only dialog located in the lower right corner.
local M = {}
-- The currently active window.
local QUEUE = {}
-- The active time of the window.
local DISPLAY_TIME = 10000
-- Window spacing.
local SPACING = 2

function M.create(text, style)
    style = style or define.normal
    local content = stringUtil.toLines(text)
    local width, height, x, y = M.coordinate(content)

    local winBuf = vim.api.nvim_create_buf(false, true)
    vim.fn.setbufline(winBuf, 1, content)
    vim.api.nvim_buf_set_option(winBuf, "modifiable", false)
    local winId = vim.api.nvim_open_win(winBuf, false, {
        relative = "editor",
        anchor = "SE",
        row = y,
        col = x,
        width = width,
        height = height,
        focusable = false,
        style = "minimal",
        noautocmd = false,
        bufpos = { 0, 0 },
        border = "rounded",
    })
    table.insert(QUEUE, winId)

    local winSetOption = vim.api.nvim_win_set_option
    winSetOption(winId, "wrap", true)
    winSetOption(winId, "winhl", "NormalFloat:" .. style .. ",FloatBorder:" .. style)

    vim.fn.timer_start(DISPLAY_TIME, function()
        M.close(winId, winBuf)
    end)
end

-- Closes the specified window and moves other windows down.
function M.close(winId, winBuf)
    local winGetConfig = vim.api.nvim_win_get_config
    local winConfig = winGetConfig(winId)

    vim.api.nvim_win_close(winId, false)
    vim.api.nvim_buf_delete(winBuf, {})
    table.remove(QUEUE, 1)

    -- Other dialogs move down.
    for _, otherWin in pairs(QUEUE) do
        local otherConfig = winGetConfig(otherWin)
        otherConfig.row[false] = otherConfig.row[false] + winConfig.height + SPACING
        vim.api.nvim_win_set_config(otherWin, otherConfig)
    end
end

-- Calculate the coordinates of the window.
function M.coordinate(content)
    local winGetConfig = vim.api.nvim_win_get_config

    local mLen = stringUtil.strlens(content)
    local width = math.max(math.min(60, mLen), 40)
    local height = math.max(5, math.min(30, math.ceil(mLen / width)))
    local x = vim.o.columns - 1
    local y = nil
    if #QUEUE == 0 then
        y = vim.o.lines - 3
    else
        -- If a dialog already exists, the new dialog is built on top of that dialog.
        local lastNotify = QUEUE[#QUEUE]
        lastNotify = winGetConfig(lastNotify)
        y = lastNotify.row[false] - lastNotify.height - SPACING
    end

    return width, height, x, y
end

function M.debug(message)
    M.create(message, define.debug)
end

function M.info(message)
    M.create(message, define.info)
end

function M.warn(message)
    M.create(message, define.warn)
end

function M.error(message)
    M.create(message, define.error)
end

return {
    create = M.create,
    debug = M.debug,
    info = M.info,
    warn = M.warn,
    error = M.error,
}
