local util = require "aszswaz.util"
local nvimTree = require "nvim-tree.api"
local MODULES = {
    require "aszswaz.config.hotkey.buffer",
    require "aszswaz.config.hotkey.coc",
}

local M = {}

local keyset = vim.keymap.set

function M.setup()
    local options = { silent = true, unique = true, noremap = true }
    keyset({ "n", "i" }, "<C-t><C-s>", vim.cmd.Translate, options)
    keyset("v", "<C-t><C-s>", ":'<,'>Translate<cr>", options)
    keyset("i", "<C-e>", "<esc>:NvimTreeOpen<cr>", options)
    keyset("n", "<C-e>", nvimTree.tree.focus, options)
    keyset({ "n", "i" }, "<C-e><C-r>", nvimTree.tree.reload, options)
    keyset({ "n", "i" }, "<C-t><C-e>", "<esc>:ToggleTerm<cr>", options)
    keyset("t", "<C-\\><C-N>:ToggleTerm<cr>", options)

    for _, iterm in pairs(MODULES) do
        iterm.setup()
    end
end
return M
