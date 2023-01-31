local string = require "util.string"

-- Dialog box. A read-only, centered floating window.
local M = {}

local namespace = vim.api.nvim_create_namespace "Dialog"
local setHighlight = function(name, value)
    vim.api.nvim_set_hl(namespace, name, value)
end
setHighlight("NormalFloat", { fg = "#FFFFFF", bg = nil })
setHighlight("FloatBorder", { fg = "#000000", bg = nil })
setHighlight("LineNr", { fg = "#000000", bg = nil })
setHighlight("CursorLine", { fg = nil, bg = nil })
setHighlight("CursorLineNr", { fg = nil, bg = nil })
setHighlight("CursorColumn", { fg = nil, bg = nil })

function M.createBuffer(messages)
    local buf = vim.api.nvim_create_buf(false, true)

    if type(messages) == "string" then
        vim.fn.setbufline(buf, 1, string.toLines(messages))
    elseif vim.tbl_islist(messages) then
        local currentLine = 1
        for _, iterm in pairs(messages) do
            msgType = type(iterm)
            if msgType == "string" then
                local lines = string.toLines(iterm)
                vim.fn.setbufline(buf, currentLine, lines)
                currentLine = currentLine + #lines
            elseif msgType == "table" then
                local lines = string.toLines(iterm.text)
                vim.fn.setbufline(buf, currentLine, lines)
                for index = -1, #lines do
                    vim.api.nvim_buf_add_highlight(buf, 0, iterm.highlight, index + currentLine, 0, -1)
                end
                currentLine = currentLine + #lines
            else
                error("illegal parameter type: " .. msgType)
            end
        end
    else
        error "parameter messages must be a string or an array."
    end
    return buf
end

function M.create(messages)
    local buf = M.createBuffer(messages)

    vim.api.nvim_buf_set_option(buf, "modifiable", false)

    local width = 80
    local height = 20
    local x = vim.o.columns / 2 - width / 2
    local y = vim.o.lines / 2 - height / 2

    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        col = x,
        row = y,
        width = width,
        height = height,
        border = "double",
        style = "minimal",
    })

    vim.api.nvim_win_set_hl_ns(win, namespace)
    vim.wo[win].number = true

    vim.api.nvim_create_autocmd("WinClosed", {
        pattern = tostring(win),
        callback = function()
            vim.api.nvim_buf_delete(buf, {})
        end,
    })
end

return { create = M.create }
