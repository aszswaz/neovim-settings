local util = require "aszswaz.util"
local text = require "aszswaz.text"
local event = require "aszswaz.event"

local M = {}

local keyset = vim.keymap.set

function M.setup()
    local options = { silent = true, unique = true, noremap = true }
    keyset({ "n", "i" }, "<C-f>", text.format, options)
    keyset({ "n", "i" }, "<C-d>", text.copyLine, options)
    keyset({ "n", "i" }, "<C-y>", vim.api.nvim_del_current_line, options)
    keyset({ "n", "i" }, "<C-s>", event.save, options)
    keyset({ "n", "i" }, "<C-q>", event.quit, options)
    -- 光标跳转到首个非空格字符
    keyset("n", "<Home>", "^", options)
    keyset("i", "<Home>", "<esc>^a", options)
    -- 全选
    keyset("n", "<C-a>", "gg0vG$", options)
    keyset("i", "<C-a>", "<esc>gg0vG$", options)
    keyset("v", "<C-a>", "gg0G$", options)
    -- 光标所在行向上或向下移动一行
    keyset({ "n", "i" }, "<C-Up>", function()
        vim.cmd.move "-2"
    end, options)
    keyset({ "n", "i" }, "<C-Down>", function()
        vim.cmd.move "+1"
    end, options)
    -- 撤销
    keyset({ "n", "i" }, "<C-z>", vim.cmd.undo, options)
    -- 重做
    keyset({ "n", "i" }, "<A-z>", vim.cmd.redo, options)
    -- 复制和粘贴
    local reg = nil
    if vim.fn.has "clipboard" then
        reg = "+"
    else
        reg = "0"
    end
    keyset("v", "<C-c>", '"' .. reg .. "y", options)
    keyset("v", "<C-x>", '"' .. reg .. "d", options)
    keyset("n", "<C-p>", '"' .. reg .. "p", options)
    keyset("i", "<C-p>", '<esc>"' .. reg .. "pa", options)
end
return M
