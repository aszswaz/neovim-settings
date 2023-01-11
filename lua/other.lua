local text = require "text"

local bufnr = vim.fn.bufnr
local getbufinfo = vim.fn.getbufinfo

local cmd = vim.cmd

local M = {}

-- Closing the current tab is actually closing the vim buffer, but the romgrk/barbar.nvim plugin will use the buffer as a tab,
-- so closing the buffer is equivalent to closing the tab.
function M.closeTab()
    local buf_id = bufnr()
    -- If the current buffer has been modified by the user, save it to a file first.
    local buf_info = getbufinfo(buf_id)
    buf_info = buf_info[1]
    if buf_info.changed == 1 then
        text.row.trim()
        vim.cmd "w"
    end

    if vim.o.filetype == "NvimTree" then
        cmd "NvimTreeClose"
    else
        cmd "BufferClose"
    end
end

return M
