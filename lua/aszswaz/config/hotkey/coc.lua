local M = {}

local keyset = vim.keymap.set

function M.setup()
    vim.g["coc_snippet_next"] = "<tab>"

    local options = { silent = true, unique = true, noremap = true, expr = true }
    keyset("i", "<esc>", [[coc#pum#visible() ? coc#pum#cancel() : "<esc>"]], options)
    keyset("i", "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], options)

    --[[
        在 insert 模式中注册 <TAB> 热键，执行如下操作
        1. 如果 coc.nvim 的选项窗口已经打开，跳转到下一个选项
        2. 如果使用 coc-snippets 插入了一段文本，且已经在 snippets 中设置了占位符，则跳转到下一个占位符
        3. 如果光标在行首或光标下的字符为空格，打开 coc.nvim 的自动完成窗口
    --]]
    vim.cmd [[
        inoremap <silent><unique><expr> <C-space>
        \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
        \ v:lua.require("aszswaz.config.hotkey.coc").checkBackspace() ? "\<TAB>" : coc#refresh()
    ]]
end

-- 判断光标是否在行首，以及光标下的字符是否为空格
function M.checkBackspace()
    local window = vim.api.nvim_get_current_win()
    local col = vim.api.nvim_win_get_cursor(window)[2]
    col = col - 1
    return col == 0 or vim.api.nvim_get_current_line():sub(col, col) == " "
end

return M
