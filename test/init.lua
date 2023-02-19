local PROJECT_DIR = vim.fn.expand("<script>:h:h")
local runtimePaths = vim.api.nvim_list_runtime_paths()
runtimePaths[1] = PROJECT_DIR
vim.o.runtimepath = vim.fn.join(runtimePaths, ",")

vim.cmd.runtime "init.lua"
