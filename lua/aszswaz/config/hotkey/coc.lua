local M = {}

local keyset = vim.keymap.set

function M.setup()
    vim.g["coc_snippet_next"] = "<tab>"

    local options = { silent = true, unique = true, noremap = true, expr = true }
    keyset("i", "<esc>", [[coc#pum#visible() ? coc#pum#cancel() : "<esc>"]], options)
    keyset("i", "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], options)

    vim.cmd [[

    ]]
end

return M
