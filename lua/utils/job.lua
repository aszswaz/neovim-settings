require "utils/dialog"

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
