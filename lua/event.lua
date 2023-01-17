local text = require "text"

local getbufinfo = vim.fn.getbufinfo
local bufexists = vim.fn.bufexists

local cmd = vim.cmd

local getCurrentBuf = vim.api.nvim_get_current_buf
local bufDelete = vim.api.nvim_buf_delete

-- Manage events such as closing buffer, saving and exiting neovim.
local M = {}
local toggleterm = nil

function M.closeBuffer()
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

-- All the text in the buffer is saved to the file after removing spaces at the end of the line.
function M.save()
    text.trimAll()
    cmd "wall"
end

-- After saving the text, exit neovim.
function M.quit()
    if toggleterm and bufexists(toggleterm.bufnr) == 1 then
        bufDelete(toggleterm.bufnr, { force = true })
    end
    M.save()
    cmd "qall"
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
