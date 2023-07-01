local M = {}

function M.setup()
    -- vim-bookmarks
    vim.api.nvim_set_var("bookmark_sign", "⚑")
    vim.api.nvim_set_var("bookmark_highlight_lines", 0)
end

return M
