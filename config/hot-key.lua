local util = require "util"
local text = require "text"
local other = require "other"

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
        action = '"' .. reg .. "d",
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
