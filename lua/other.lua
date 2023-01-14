local text = require "text"

local getbufinfo = vim.fn.getbufinfo

local cmd = vim.cmd

local getCurrentBuf = vim.api.nvim_get_current_buf

local M = {}

-- Closing the current tab is actually closing the vim buffer, but the romgrk/barbar.nvim plugin will use the buffer as a tab,
-- so closing the buffer is equivalent to closing the tab.
function M.closeTab()
    local bufId = getCurrentBuf()
    -- If the current buffer has been modified by the user, save it to a file first.
    local bufInfo = getbufinfo(bufId)
    bufInfo = bufInfo[1]
    if bufInfo.changed == 1 then
        text.trim()
        cmd "w"
    end

    if vim.o.filetype == "NvimTree" then
        cmd "NvimTreeClose"
    else
        cmd "BufferClose"
    end
end

return {
    closeTab = M.closeTab,
}
