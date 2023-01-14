local dirname = vim.fs.dirname
local join = vim.fn.join
local expand = vim.fn.expand
local getRuntimerPaths = vim.api.nvim_list_runtime_paths

-- Change the first path in runtimepath to the current directory, which is convenient for debugging.
local runtimePaths = getRuntimerPaths()
runtimePaths[1] = dirname(expand("<script>"))
vim.o.runtimepath = join(runtimePaths, ",")

vim.cmd "runtime config/index.vim"
