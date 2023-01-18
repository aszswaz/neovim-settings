local notify = require "float-window.notify"
local dialog = require "float-window.dialog"

local timerStart = vim.fn.timer_start

function testNotify01()
    local STYLES = {
        DialogNormal = notify.create,
        NotifyDebug = notify.debug,
        NotifyInfo = notify.info,
        NotifyWarn = notify.warn,
        NotifyError = notify.error,
    }

    local index = 0
    for key, value in pairs(STYLES) do
        timerStart(500 * index, function()
            value(key)
        end)
        index = index + 1
    end
end

function testNotify02()
    local demo = {
        demo = "Hello World",
    }
    notify.create(vim.inspect(demo))
end

function testDialog01()
    dialog.create()
end
