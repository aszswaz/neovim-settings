cmake = {}

-- Initialize the cmake project
cmake.init = function()
    local message = vim.fn.systemlist "cmake -S . -B build"
    if vim.api.nvim_get_vvar "shell_error" == 0 then
        if vim.fn.filereadable "build/compile_commands.json" == 1 then
            vim.fn.system "ln -sf build/compile_commands.json compile_commands.json"
        end
        dialog.info "Initialize the cmake project successded."
    else
        dialog.error(message)
    end
end

cmake.build = function()
    if vim.fn.filereadable "build/Makefile" == 0 then
        cmake.init()
    end

    local message = vim.fn.systemlist "cmake --build build"
    if vim.api.nvim_get_vvar "shell_error" == 0 then
        dialog.info "cmake compiles successfully."
    else
        dialog.error(message)
    end
end

cmake.clean = function()
    if vim.fn.isdirectory "build" == 1 then
        vim.fn.delete("build", "rf")
    end
end
