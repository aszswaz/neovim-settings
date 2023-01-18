local log = require "logger"

local M = {}

-- Initialize the cmake project
function M.init()
    local message = vim.fn.systemlist "cmake -S . -B build"
    if vim.api.nvim_get_vvar "shell_error" == 0 then
        if vim.fn.filereadable "build/compile_commands.json" == 1 then
            vim.fn.system "ln -sf build/compile_commands.json compile_commands.json"
        end
        log.info "Initialize the cmake project successded."
    else
        log.error(message)
    end
end

function M.build()
    if vim.fn.filereadable "build/Makefile" == 0 then
        M.init()
    end

    local message = vim.fn.systemlist "cmake --build build"
    if vim.api.nvim_get_vvar "shell_error" == 0 then
        log.info "cmake compiles successfully."
    else
        log.error(message)
    end
end

function M.clean()
    if vim.fn.isdirectory "build" == 1 then
        vim.fn.delete("build", "rf")
    end
end

return {
    init = M.init,
    build = M.build,
    clean = M.clean,
}
