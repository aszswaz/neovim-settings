require "text"

-- Closing the current tab is actually closing the vim buffer, but the romgrk/barbar.nvim plugin will use the buffer as a tab,
-- so closing the buffer is equivalent to closing the tab.
function closeTab()
    local buf_id = vim.fn.bufnr()
    -- If the current buffer has been modified by the user, save it to a file first.
    local buf_info = vim.fn.getbufinfo(buf_id)
    buf_info = buf_info[1]
    if buf_info.changed == 1 then
        text.row.trim()
        vim.cmd "w"
    end
    -- Close buffer
    vim.cmd "BufferClose"
end
