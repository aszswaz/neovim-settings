local util = require "aszswaz.util"
local theme = require "aszswaz.theme"
local storage = require "aszswaz.util.storage"

local M = {}

local autocmd = vim.cmd.autocmd
local createAutocmd = vim.api.nvim_create_autocmd

function M.setup()
    autocmd "FileType json,html,xml,yaml,svg,sql :set tabstop=2"
    autocmd "FileType text,desktop,markdown      :set wrap"
    autocmd "FileType tags                       :set noexpandtab"
    autocmd "FileType help                       :set conceallevel=0"

    createAutocmd("ColorScheme", {
        desc = "Customize some highlight groups and save the theme changes.",
        callback = function()
            util.setHighlight("MatchParen", { fg = "#66CCFF", underline = true })
            theme.switchTheme()
        end,
    })

    createAutocmd("BufRead", {
        callback = function()
            local buffer = vim.api.nvim_get_current_buf()
            vim.bo[buffer].modifiable = not vim.bo[buffer].readonly
        end,
    })
    createAutocmd("VimEnter", { desc = "Restores the user's theme configuration.", callback = theme.init })
    createAutocmd("VimLeave", { desc = "Save user preferences configuration.", callback = storage.save })
end
return M
