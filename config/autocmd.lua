local util = require "util"
local theme = require "theme"
local storage = require "util.storage"

local createAutocmd = vim.api.nvim_create_autocmd

createAutocmd("FileType", {
    desc = "Sets the indentation width for some file types.",
    pattern = { "json", "html", "xml", "yaml", "svg", "sql" },
    callback = function()
        vim.o.tabstop = 2
    end,
})

createAutocmd("FileType", {
    desc = "Some file types enable line breaks.",
    pattern = { "text", "desktop" },
    callback = function()
        vim.o.wrap = true
    end,
})

createAutocmd("FileType", {
    desc = "Set formatting options for all file types.",
    callback = function()
        vim.o.formatoptions = "jcroql"
    end,
})

createAutocmd("FileType", {
    pattern = { "tags" },
    desc = "Some documents cannot use spaces as tabs.",
    callback = function()
        vim.o.expantab = false
    end,
})

createAutocmd("ColorScheme", {
    callback = function()
        util.setHighlight("MatchParen", { fg = "#66CCFF", underline = true })
        theme.switchTheme()
    end,
})

createAutocmd("VimEnter", { callback = theme.init })
createAutocmd("VimLeave", { callback = storage.save })
