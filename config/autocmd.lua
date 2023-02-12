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
    pattern = { "text", "desktop", "markdown" },
    callback = function()
        vim.o.wrap = true
    end,
})

createAutocmd("FileType", {
    desc = "Set formatting options for all file types.",
    callback = function()
        vim.o.formatoptions = "jcroql"
        vim.o.conceallevel = 0
    end,
})

createAutocmd("FileType", {
    pattern = { "tags" },
    desc = "Some documents cannot use spaces as tabs.",
    callback = function()
        vim.o.expandtab = false
    end,
})

createAutocmd("ColorScheme", {
    desc = "Customize some highlight groups and save the theme changes.",
    callback = function()
        util.setHighlight("MatchParen", { fg = "#66CCFF", underline = true })
        theme.switchTheme()
    end,
})

createAutocmd("VimEnter", { desc = "Restores the user's theme configuration.", callback = theme.init })
createAutocmd("VimLeave", { desc = "Save user preferences configuration.", callback = storage.save })
createAutocmd("BufRead", {
    callback = function()
        local buffer = vim.api.nvim_get_current_buf()
        vim.bo[buffer].modifiable = not vim.bo[buffer].readonly
    end,
})
