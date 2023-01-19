local text = require "text"

-- Manage events such as closing buffer, saving and exiting neovim.
local M = {}
local toggleterm = nil

function M.closeBuffer()
    local bufId = vim.api.nvim_get_current_buf()
    -- If the current buffer has been modified by the user, save it to a file first.
    local bufInfo = vim.fn.getbufinfo(bufId)
    bufInfo = bufInfo[1]
    if bufInfo.changed == 1 then
        text.trim()
        vim.cmd.write()
    end

    if vim.o.filetype == "NvimTree" then
        vim.cmd.NvimTreeClose()
    else
        vim.cmd.BufferClose()
    end
end

-- All the text in the buffer is saved to the file after removing spaces at the end of the line.
function M.save()
    text.trimAll()
    vim.cmd.wall()
end

-- After saving the text, exit neovim.
function M.quit()
    if toggleterm and vim.api.nvim_buf_is_valid(toggleterm.bufnr) then
        vim.api.nvim_buf_delete(toggleterm.bufnr, { force = true })
    end
    M.save()
    vim.cmd.qall()
end

function M.toggleterm_open(term)
    toggleterm = term
end

return {
    closeBuffer = M.closeBuffer,
    save = M.save,
    quit = M.quit,
    toggleterm_open = M.toggleterm_open,
}
