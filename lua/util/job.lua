local log = require "logger"
local tableUtil = require "util.table"

local jobstart = vim.fn.jobstart

local M = {}
function M.start(command)
    local messages = {}
    local callback = function(job, data, event)
        if (event == "stdout" or event == "stderr") and data ~= nil then
            tableUtil.inserts(messages, data)
        else
            -- git has exited
            if data == 0 then
                log.info "Operation performed successfully!"
            else
                log.error(messages)
            end
        end
    end
    jobstart(command, { on_stdout = callback, on_stderr = callback, on_exit = callback })
end

return {
    start = M.start,
}
