local util = require "util"

local timerStart = vim.fn.timer_start
local timerStop = vim.fn.timer_stop
local setbufline = vim.fn.setbufline

local winClose = vim.api.nvim_win_close
local bufDelete = vim.api.nvim_buf_delete
local createBuf = vim.api.nvim_create_buf
local openWin = vim.api.nvim_open_win
local winSetOption = vim.api.nvim_win_set_option
local createAutocmd = vim.api.nvim_create_autocmd
local setHighlight = vim.api.nvim_set_hl
local winSetConfig = vim.api.nvim_win_set_config
local winGetConfig = vim.api.nvim_win_get_config
local getHighlight = vim.api.nvim_get_hl_by_name

local M = {}
local DISPLAY_TIME = 10000
-- The current active notification dialog handle.
local NOTIFYS = {}

-- Create a notification dialog.
function M.notify(msg, style)
    style = style or "DialogNormal"
    local winBuf = createBuf(false, true)
    setbufline(winBuf, 1, msg)

    local mLen = util.strlens(msg)
    local width = math.max(math.min(60, mLen), 40)
    local height = math.max(5, math.min(30, math.ceil(mLen / width)))
    local spacing = 2
    local winX = vim.o.columns - 1
    local winY = nil
    if #NOTIFYS == 0 then
        winY = vim.o.lines - 3
    else
        -- If a dialog already exists, the new dialog is built on top of that dialog.
        local lastNotify = NOTIFYS[#NOTIFYS]
        lastNotify = winGetConfig(lastNotify)
        winY = lastNotify.row[false] - lastNotify.height - spacing
    end

    local winId = openWin(winBuf, false, {
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
    table.insert(NOTIFYS, winId)

    winSetOption(winId, "wrap", true)
    winSetOption(winId, "winhl", "NormalFloat:" .. style .. ",FloatBorder:" .. style)

    -- Close the dialogs one by one after a certain amount of time.
    timerStart(DISPLAY_TIME, function()
        winClose(winId, false)
        bufDelete(winBuf, {})
        table.remove(NOTIFYS, 1)

        -- Other dialogs move down.
        for index = 1, #NOTIFYS do
            local nextWin = NOTIFYS[index]
            local winConfig = winGetConfig(nextWin)
            winConfig.row[false] = winConfig.row[false] + height + spacing
            winSetConfig(nextWin, winConfig)
        end
    end)
end

function M.debug(message)
    M.notify(message, "NotifyDebug")
end

function M.info(message)
    M.notify(message, "NotifyInfo")
end

function M.warn(message)
    M.notify(message, "NotifyWarn")
end

function M.error(message)
    M.notify(message, "NotifyError")
end

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
    setStyle = M.setStyle,
    notify = M.notify,
    debug = M.debug,
    info = M.info,
    warn = M.warn,
    error = M.error,
    central = M.central,
}
