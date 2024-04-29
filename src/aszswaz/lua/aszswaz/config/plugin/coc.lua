local M = {}

local keyset = vim.api.nvim_set_keymap

local coc_config = vim.fn["coc#config"]

function M.setup()
    M.regHotKey()
    M.config()
end

-- 注册快捷键
function M.regHotKey()
    local options = { silent = true, unique = true, noremap = true, expr = true }
    keyset("i", "<esc>", [[coc#pum#visible() ? coc#pum#cancel() : "\<esc>"]], options)
    keyset("i", "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], options)
end

-- 配置 coc.nvim
function M.config()
    coc_config("languageserver", {
        ccls = {
            command = "ccls",
            filetypes = {
                "c",
                "cpp",
                "cuda",
                "objc",
                "objcpp",
            },
            rootPatterns = {
                ".ccls-root",
                "compile_commands.json",
            },
            initializationOptions = {
                cache = {
                    directory = "/tmp/ccls",
                },
                client = {
                    snippetSupport = true,
                },
            },
        },
    })
end

return M
