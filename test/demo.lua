local notify = require "dialog.notify"
local job = require "util.job"
local util = require "util"

local has = vim.fn.has

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

function testJob()
    local script01 = [[
        echo "Hello World"
        echo "Hello World" 1>&2
        exit 0
    ]]
    local script02 = [[
        echo "Hello World"
        echo "Hello World" 1>&2
        exit 1
    ]]

    job.start("bash -c '" .. script01 .. "'")
    job.start("bash -c '" .. script02 .. "'")
end

function testRegKey()
    local keyConfig = {
        {
            mode = { "i" },
            -- key = "<C-h>",
            expr = true,
            action = 'coc#pum#visible() ? coc#pum#confirm() : "\\<cr>"',
        },
    }
    util.regHotkeys(keyConfig)
end
