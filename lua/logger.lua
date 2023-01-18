local notify = require "float-window.notify"

local M = {}

local MESSAGES = {}

local levels = vim.log.levels

function M.debug(messages)
    M.putMessage(levels.DEBUG, M.format("DEBUG", messages))
    notify.debug(messages)
end

function M.info(messages)
    M.putMessage(levels.INFO, M.format("INFO", messages))
    notify.info(messages)
end

function M.warn(messages)
    M.putMessage(levels.WARN, M.format("WARN", messages))
    notify.warn(messages)
end

function M.error(messages)
    M.putMessage(levels.ERROR, M.format("ERROR", messages))
    notify.error(messages)
end

function M.format(level, messages)
    local time = vim.fn.strftime "%Y-%m-%d %H:%M:%S"
    local logs = {}

    if type(messages) == "table" then
        for _, iterm in pairs(messages) do
            table.insert(logs, level .. " " .. time .. " " .. iterm)
        end
    else
        table.insert(logs, messages)
    end

    return logs
end

function M.showMessages()
    local logs = {}
    for _, iterm in pairs(MESSAGES) do
        for _, message in pairs(iterm.messages) do
            table.insert(logs, message)
        end
    end
end

function M.putMessage(level, messages)
    if #MESSAGES > 200 then
        table.remove(MESSAGES, 1)
    end
    table.insert(MESSAGES, { level = level, messages = messages })
end

return {
    debug = M.debug,
    info = M.info,
    warn = M.warn,
    error = M.error,
    showMessages = M.showMessages,
}
