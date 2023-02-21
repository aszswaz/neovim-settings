local M = {}

-- Checks if the specified highlight does not exist.
function M.hlNotExists(name)
    return vim.fn.hlexists(name) == 0
end

function M.setHighlight(name, value)
    vim.api.nvim_set_hl(0, name, value)
end

return {
    hlNotExists = M.hlNotExists,
    setHighlight = M.setHighlight,
}
