local tableUtil = require "util.table"

local strchars = vim.fn.strchars
local split = vim.fn.split

local M = {}

function M.strlens(text)
    local textLen = 0
    local mType = type(text)
    if mType == "string" then
        textLen = strchars(text)
    elseif mType == "table" then
        for i = 1, #text do
            textLen = textLen + strchars(text[i])
        end
    end
    return textLen
end

-- Breaks text at line breaks.
function M.toLines(str)
    local strType = type(str)
    local lines = {}

    if strType == "string" then
        tableUtil.inserts(lines, split(str, "\n"))
    elseif strType == "table" then
        for _, line in pairs(str) do
            tableUtil.inserts(lines, split(line, "\n"))
        end
    else
        error('The type of parameter "str" cannot be ' .. strType .. ", it must be string or table.")
    end

    return lines
end

return {
    strlens = M.strlens,
    toLines = M.toLines,
}
