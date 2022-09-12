function table:inserts(dest, src)
    if type(dest) ~= "table" then
        dialog.error 'The parameter "dest" type must be a table.'
        return
    end
    if type(src) == "table" then
        for i, item in ipairs(src) do
            table.insert(dest, item)
        end
    else
        table.insert(dest, src)
    end
end

function string:strlens(text)
    local textLen = 0
    local mType = type(text)
    if mType == "string" then
        textLen = vim.fn.strchars(text)
    elseif mType == "table" then
        for i, item in ipairs(text) do
            textLen = textLen + vim.fn.strchars(item)
        end
    end
    return textLen
end

job = {}
job.start = function(command)
    local messages = {}
    local callback = function(job, data, event)
        if (event == "stdout" or event == "stderr") and data ~= nil then
            table:inserts(messages, data)
        else
            -- git has exited
            if data == 0 then
                dialog.info "Operation performed successfully!"
            else
                dialog.error(messages)
            end
        end
    end
    vim.fn.jobstart(command, { on_stdout = callback, on_stderr = callback, on_exit = callback })
end
