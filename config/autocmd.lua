local util = require "util"
local theme = require "theme"

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

createAutocmd("ColorScheme", {
    callback = function()
        util.setHighlight("MatchParen", { fg = "#66CCFF", underline = true })
        theme.save()
    end,
})

createAutocmd("VimEnter", {
    callback = theme.setTheme,
})
