local log = require "Logger"

local systemlist = vim.fn.systemlist
local filereadable = vim.fn.filereadable
local system = vim.fn.system
local isdirectory = vim.fn.isdirectory
local delete = vim.fn.delete

local getVvar = vim.api.nvim_get_vvar

local M = {}

-- Initialize the cmake project
function M.init()
    local message = systemlist "cmake -S . -B build"
    if getVvar "shell_error" == 0 then
        if filereadable "build/compile_commands.json" == 1 then
            system "ln -sf build/compile_commands.json compile_commands.json"
        end
        log.info "Initialize the cmake project successded."
    else
        log.error(message)
    end
end

function M.build()
    if filereadable "build/Makefile" == 0 then
        M.init()
    end

    local message = systemlist "cmake --build build"
    if getVvar "shell_error" == 0 then
        log.info "cmake compiles successfully."
    else
        log.error(message)
    end
end

function M.clean()
    if isdirectory "build" == 1 then
        delete("build", "rf")
    end
end

return {
    init = M.init,
    build = M.build,
    clean = M.clean,
}
