local M = {}

function M.setup()
    require("indent_blankline").setup {
        show_end_of_line = true,
        filetype_exclude = { "startify", "help", "qf", "vim-plug", "dashboard" },
    }
end

return M
