local M = {}

local keyset = vim.api.nvim_set_keymap
local get_current_line = vim.api.nvim_get_current_line
local set_current_line = vim.api.nvim_set_current_line
local get_current_win = vim.api.nvim_get_current_win
local get_cursor = vim.api.nvim_win_get_cursor

local visible = function()
    return vim.fn["coc#pum#visible"]() == 1
end
local expandableOrJumpable = function()
    return vim.fn["coc#expandableOrJumpable"]() == 1
end
local cancel = vim.fn["coc#pum#cancel"]
local confirm = vim.fn["coc#pum#confirm"]
local on_enter = vim.fn["coc#on_enter"]
local rpc_request = vim.fn["coc#rpc#request"]
local refresh = vim.fn["coc#refresh"]
local coc_config = vim.fn["coc#config"]

function M.setup()
    M.regHotKey()
    M.config()
end

-- 注册快捷键
function M.regHotKey()
    local options = { silent = true, unique = true, noremap = true, expr = true }
    keyset("i", "<esc>", "", {
        silent = options.silent,
        unique = options.unique,
        noremap = options.noremap,
        expr = options.expr,
        callback = M.escEvent,
    })
    keyset("i", "<CR>", "", {
        silent = options.silent,
        unique = options.unique,
        noremap = options.noremap,
        expr = options.expr,
        callback = M.enterEvent,
    })

    keyset("i", "<C-space>", "", {
        desc = "打开自动完成窗口，或者移动到下一个选项",
        silent = options.silent,
        unique = options.unique,
        noremap = options.noremap,
        expr = options.expr,
        callback = M.autocomplete,
    })
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

-- 如果自动完成窗口已经打开，跳转到下一个选项，否则打开自动完成窗口
function M.autocomplete()
    if expandableOrJumpable() then
        -- 跳转到下一个选项
        rpc_request("doKeymap", { "snippets-expand-jump", "" })
    else
        refresh()
    end
end

-- 处理 esc 按键
function M.escEvent()
    if visible() then
        cancel()
    else
        vim.cmd.normal()
    end
end

-- 处理 enter 键
function M.enterEvent()
    if visible() then
        confirm()
    else
        on_enter()
    end
end

return M
