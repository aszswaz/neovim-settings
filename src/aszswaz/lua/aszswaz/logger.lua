local notify = require "aszswaz.float-window.notify"
local dialog = require "aszswaz.float-window.dialog"
local util = require "aszswaz.util"

local levels = vim.log.levels

local M = {}

local LOG_QUEUE = {}
local LOG_LEVEL = {
    [levels.DEBUG] = {
        name = "DEBUG",
        highlight = "LoggerDebug",
    },
    [levels.INFO] = {
        name = "INFO",
        highlight = "LoggerInfo",
    },
    [levels.WARN] = {
        name = "WARN",
        highlight = "LoggerWarn",
    },
    [levels.ERROR] = {
        name = "ERROR",
        highlight = "LoggerError",
    },
}
local HIGHLIGHTS = {
    [LOG_LEVEL[levels.DEBUG].highlight] = {
        fg = "#66CCFF",
    },
    [LOG_LEVEL[levels.INFO].highlight] = {
        fg = "#008000",
    },
    [LOG_LEVEL[levels.WARN].highlight] = {
        fg = "#FF9F00",
    },
    [LOG_LEVEL[levels.ERROR].highlight] = {
        fg = "#FF0000",
    },
}

function M.debug(messages)
    messages = M.messageHandler(messages)
    M.putMessage(levels.DEBUG, messages)
    notify.debug(messages)
end

function M.info(messages)
    messages = M.messageHandler(messages)
    M.putMessage(levels.INFO, messages)
    notify.info(messages)
end

function M.warn(messages)
    messages = M.messageHandler(messages)
    M.putMessage(levels.WARN, messages)
    notify.warn(messages)
end

function M.error(messages)
    messages = M.messageHandler(messages)
    M.putMessage(levels.ERROR, messages)
    notify.error(messages)
end

function M.notify(msg, level)
    level = level or levels.INFO
    if levels.DEBUG == level then
        M.debug(msg)
    elseif levels.INFO == level or levels.OFF == level then
        M.info(msg)
    elseif levels.WARN == level then
        M.warn(msg)
    elseif levels.ERROR == level or levels.TRACE == level then
        M.error(msg)
    end
end

function M.messageHandler(messages)
    -- Due to the characteristics of neovim, messages may be an array of strings, and splicing them is helpful for subsequent processing.
    if vim.tbl_islist(messages) then
        return vim.fn.join(messages, "\n")
    elseif type(messages) == "string" then
        return messages
    else
        error "parameter messages must be string."
    end
end

function M.showMessages()
    local logs = {}
    for _, iterm in pairs(LOG_QUEUE) do
        local logLevel = LOG_LEVEL[iterm.level]
        table.insert(logs, {
            highlight = logLevel.highlight,
            text = string.format("%s %-5s %s", vim.fn.strftime("%Y-%m-%d %H:%M:%S", iterm.time), logLevel.name, iterm.text),
        })
    end

    for name, style in pairs(HIGHLIGHTS) do
        if util.hlNotExists(name) then
            util.setHighlight(name, style)
        end
    end

    dialog.create(logs)
end

function M.putMessage(level, message)
    local msgType = type(messages)
    local currentTime = os.time()

    if #LOG_QUEUE > 200 then
        table.remove(LOG_QUEUE, 1)
    end
    table.insert(LOG_QUEUE, { time = currentTime, level = level, text = message })
end

return {
    debug = M.debug,
    info = M.info,
    warn = M.warn,
    error = M.error,
    showMessages = M.showMessages,
    notify = M.notify,
}
