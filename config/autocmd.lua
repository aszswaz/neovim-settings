local lualine = require "lualine"
local floatWindow = require "float-window"

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
    pattern = "*",
    callback = function()
        vim.o.formatoptions = "jcroql"
    end,
})

createAutocmd("ColorScheme", {
    desc = "After the theme is set, set some highlights.",
    pattern = "*",
    callback = floatWindow.regStyle,
})

createAutocmd("ColorScheme", {
    pattern = { "vscode", "tokyonight*" },
    callback = function()
        lualine.setup {
            options = {
                icons_enable = true,
                theme = vim.api.nvim_get_var "colors_name",
            },
        }
    end,
})
