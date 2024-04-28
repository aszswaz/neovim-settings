local M = {}

local keyset = vim.keymap.set

function M.setup()
    local options = { silent = true, unique = true, noremap = true }

    keyset({ "n", "i" }, "<C-t><C-s>", vim.cmd.Translate, options)
    keyset("v", "<C-t><C-s>", ":'<,'>Translate<cr>", options)
end

return M
