local M = {}

function M.inserts(dest, src)
    if type(dest) ~= "table" then
        error 'The parameter "dest" type must be a table.'
        return
    end
    if type(src) == "table" then
        for i = 1, #src do
            table.insert(dest, src[i])
        end
    else
        table.insert(dest, src)
    end
end

return {
    inserts = M.inserts,
}
