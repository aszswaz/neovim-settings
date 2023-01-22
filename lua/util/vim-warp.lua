-- vim function wapper.
local M = {}

function M.isdirectory(path)
    return vim.fn.isdirectory(path) == 1
end

function M.filereadable(path)
    return vim.fn.filereadable(path) == 1
end

return M
