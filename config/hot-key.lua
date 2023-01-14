local util = require "util"
local text = require "text"
local other = require "other"
local nvimTree = require "nvim-tree.api"

local has = vim.fn.has

local cmd = vim.cmd

local delCurrentLine = vim.api.nvim_del_current_line

-- Shortcut keys in normal mode and insert mode.
local niHotkeys = {
    {
        key = "<C-f>",
        action = text.format,
        desc = "Formats text in the current buffer.",
    },
    {
        key = "<C-d>",
        action = text.copyLine,
        desc = "Copy the current row.",
    },
    {
        key = "<C-y>",
        action = delCurrentLine,
        desc = "Delete the current row.",
    },
    {
        key = "<C-s>",
        action = function()
            text.trim()
            cmd "w"
        end,
        desc = "Remove all trailing spaces and save the text.",
    },
    {
        key = "<C-q>",
        action = function()
            text.trimAll()
            cmd "wqall"
        end,
        desc = "Remove all trailing spaces, save the text, and exit neovim.",
    },
    {
        key = "<Home>",
        action = util.wrapCmd "normal! ^",
        desc = "Move the cursor to the first non-space character.",
    },
    {
        key = "<A-c>",
        action = other.closeTab,
        desc = "Save and close the buffer.",
    },
    {
        key = "<C-a>",
        action = {
            n = "gg0vG$",
            i = "<esc>gg0vG$",
            v = "gg0G$",
        },
        desc = "Select all text.",
    },
    {
        key = "<C-Up>",
        action = {
            n = ":move -2<cr>",
            i = "<esc>: move -2<cr>a",
        },
        desc = "Move the current line up one line.",
    },
    {
        key = "<C-Down>",
        action = {
            n = ":move +1<cr>",
            i = "<esc>:move +1<cr>a",
        },
        desc = "Move the current line down one line.",
    },
    {
        key = "<C-z>",
        action = {
            n = ":undo<cr>",
            i = "<esc>:undo<cr>a",
        },
        desc = "Revoke.",
    },
    {
        key = "<A-z>",
        action = {
            n = ":redo<cr>",
            i = "<esc>:redo<cr>a",
        },
        desc = "redo",
    },
}

util.regHotkeys(niHotkeys, { "n", "i" })

local reg = nil
if has "clipboard" then
    reg = "+"
else
    reg = "0"
end
local clipboardHotkeys = {
    {
        mode = { "v" },
        key = "<C-c>",
        action = '"' .. reg .. "y",
        desc = "Copy selected text.",
    },
    {
        mode = { "v" },
        key = "<C-x>",
        action = '"' .. reg .. "d",
        desc = "Cut selected text.",
    },
    {
        key = "<C-p>",
        action = {
            n = '"' .. reg .. "p",
            i = '<esc>"' .. reg .. "pa",
        },
        desc = "Paste text.",
    },
}
util.regHotkeys(clipboardHotkeys)

if vim.o.loadplugins then
    local pluginHotkeys = {
        {
            key = "<C-t><C-s>",
            action = {
                n = ":TranslateW<cr>",
                i = "<esc>:TranslateW<cr>",
                v = ":'<,'>TranslateW<cr>",
            },
            desc = "Translate the word currently under the cursor or the selected text.",
        },
        {
            mode = { "i" },
            key = "<cr>",
            expr = true,
            action = 'coc#pum#visible() ? coc#pum#confirm() : "\\<cr>"',
            desc = "The text selected in the candidate box of coc.vim is written to the buffer.",
        },
        {
            mode = { "i" },
            key = "<esc>",
            expr = true,
            action = 'coc#pum#visible() ? coc#pum#cancel() : "\\<esc>"',
            desc = "Uncheck the checkbox for coc.vim.",
        },
        {
            key = "<C-e>",
            action = nvimTree.tree.focus,
            desc = "Open the file manager.",
        },
        {
            key = "<C-e><C-r>",
            action = nvimTree.tree.reload,
            desc = "Refresh the file manager.",
        },
        {
            key = "<C-t><C-e>",
            action = {
                n = ":ToggleTerm<cr>",
                i = "<esc>:ToggleTerm<cr>",
                t = "<C-\\><C-n>:ToggleTerm<cr>",
            },
            desc = "Open or close the terminal.",
        },
        {
            key = "<A-Left>",
            action = {
                n = ":BufferPrevious<cr>",
                i = "<esc>:BufferPrevious<cr>",
            },
            desc = "Swicth to the previous buffer.",
        },
        {
            key = "<A-Right>",
            action = {
                n = ":BufferNext<cr>",
                i = "<esc>:BufferNext<cr>",
            },
            desc = "Switch to the next buffer.",
        },
        {
            key = "<A-9>",
            action = {
                n = ":BufferLast<cr>",
                i = "<esc>:BufferLast<cr>",
            },
            desc = "Swich to the last buffer.",
        },
    }

    for index = 1, 8 do
        table.insert(pluginHotkeys, {
            key = "<A-" .. index .. ">",
            action = {
                n = ":BufferGoto " .. index .. "<cr>",
                i = "<esc>:BufferGoto " .. index .. "<cr>",
            },
            desc = "Swicth to the " .. index .. "th buffer.",
        })
    end

    util.regHotkeys(pluginHotkeys, { "n", "i" })
end