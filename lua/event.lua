local text = require "text"

-- Manage events such as closing buffer, saving and exiting neovim.
local M = {}
local toggleterm = nil

function M.closeBuffer()
    local bufId = vim.api.nvim_get_current_buf()
    -- If the current buffer has been modified by the user, save it to a file first.
    if vim.bo[bufId].modified then
        text.trim()
        vim.cmd "write"
    end

    if vim.o.filetype == "NvimTree" then
        vim.cmd "NvimTreeClose"
    else
        vim.cmd "BufferClose"
    end
end

function M.closeOtherBuffer()
    local currentBuffer = vim.api.nvim_get_current_buf()
    local buffers = vim.api.nvim_list_bufs()
    for _, buffer in pairs(buffers) do
        local loaded = vim.api.nvim_buf_is_loaded(buffer)
        if loaded and vim.bo[buffer].modified and buffer ~= currentBuffer then
            vim.api.nvim_buf_call(buffer, vim.cmd.write)
        end
    end
    vim.cmd "BufferCloseAllButCurrentOrPinned"
end

-- All the text in the buffer is saved to the file after removing spaces at the end of the line.
function M.save()
    local buffers = vim.api.nvim_list_bufs()
    local getBufOption = vim.api.nvim_buf_get_option
    for _, iterm in pairs(buffers) do
        local modified = getBufOption(iterm, "modified")
        local loaded = vim.api.nvim_buf_is_loaded(iterm)
        local readonly = getBufOption(iterm, "readonly")
        if loaded and not readonly and modified then
            text.trim(iterm)
            vim.api.nvim_buf_call(iterm, vim.cmd.write)
        end
    end
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
    closeOtherBuffer = M.closeOtherBuffer,
    save = M.save,
    quit = M.quit,
    toggleterm_open = M.toggleterm_open,
}
