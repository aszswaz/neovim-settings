local M = {}

function M.inserts(dest, src)
    if type(dest) ~= "table" then
        dialog.error 'The parameter "dest" type must be a table.'
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

function M.strlens(text)
    local textLen = 0
    local mType = type(text)
    if mType == "string" then
        textLen = vim.fn.strchars(text)
    elseif mType == "table" then
        for i = 1, #text do
            textLen = textLen + vim.fn.strchars(text[i])
        end
    end
    return textLen
end

return M
