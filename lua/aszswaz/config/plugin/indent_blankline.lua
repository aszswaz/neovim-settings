local M = {}

function M.setup()
    require("ibl").setup {
        exclude = {
            filetypes = { "startify", "help", "qf", "vim-plug", "dashboard" },
            buftypes = { "terminal" },
        },
    }
end

return M
