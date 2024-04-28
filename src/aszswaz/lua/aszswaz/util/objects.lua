local M = {}

-- Create a table.
function M.new(obj, metaTable)
    obj = obj or {}
    metaTable = metaTable or {
        __tostring = vim.inspect,
    }
    return setmetatable(obj, metaTable)
end

return { new = M.new }
