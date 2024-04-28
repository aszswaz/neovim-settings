local M = {}

function M.setup()
    require("nvim-autopairs").setup {
        map_cr = false,
    }
end

return M
