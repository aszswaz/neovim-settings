local lualine = require "lualine"
local dialog = require "dialog"

local createAutocmd = vim.api.nvim_create_autocmd
local getGlobalVar = vim.api.nvim_get_var

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
    pattern = "*",
    callback = function()
        vim.o.formatoptions = "jcroql"
    end,
})

createAutocmd("ColorScheme", {
    desc = "After the theme is set, set some highlights.",
    pattern = "*",
    callback = dialog.regStyle,
})

createAutocmd("ColorScheme", {
    pattern = { "vscode", "tokyonight*" },
    callback = function()
        lualine.setup {
            options = {
                icons_enable = true,
                theme = getGlobalVar "colors_name",
            },
        }
    end,
})
