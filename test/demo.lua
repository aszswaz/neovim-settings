local job = require "aszswaz.util.job"
local util = require "aszswaz.util"

local has = vim.fn.has

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
