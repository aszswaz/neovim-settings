local util = require "aszswaz.util"
local event = require "aszswaz.event"

local M = {}

function M.setup()
    -- util.regHotkeys(hotkeys, { "n", "i" })
    local keyset = vim.keymap.set

    local options = { silent = true, unique = true, noremap = true }
    keyset({ "n", "i" }, "<A-c>", event.closeBuffer, options)
    keyset({ "n", "i" }, "<A-c-o>", event.closeOtherBuffer, options)
    keyset({ "n", "i" }, "<A-Left>", vim.cmd.BufferPrevious, options)
    keyset({ "n", "i" }, "<A-Right>", vim.cmd.BufferNext, options)
    keyset({ "n", "i" }, "<A-9>", vim.cmd.BufferLast, options)
    keyset({ "n", "i" }, "<C-A-Left>", vim.cmd.BufferMove, options)
    keyset({ "n", "i" }, "<C-A-Right>", vim.cmd.BufferMoveNext, options)
    keyset({ "n", "i" }, "<A-p>", vim.cmd.BufferPin, options)

    for index = 1, 8 do
        keyset({ "n", "i" }, "<A-" .. index .. ">", function()
            vim.cmd.BufferGoto(index)
        end, options)
    end
end
return M
