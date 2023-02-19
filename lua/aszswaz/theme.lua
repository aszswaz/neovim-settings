local objects = require "aszswaz.util.objects"
local storage = require "aszswaz.util.storage"

local M = {}

local THEME = storage.get("theme", objects.new())

function M.init()
    local colorscheme = vim.cmd.colorscheme

    if THEME.background then
        vim.o.background = THEME.background
    elseif os.getenv "TERMUX_APP_PID" then
        --[[
            If neovim is used in termux-app, neovim's cursor can only be white, and all settings for neovim cursor have no effect.
            In order to prevent the color of the cursor from mixing with the background color of the theme and making it impossible to distinguish,
            a theme with a darker color must be used.
        --]]
        vim.o.background = "dark"
    else
        vim.o.background = "light"
    end

    if vim.o.loadplugins then
        -- read theme settings from a shada file
        local scheme = THEME.theme or "vscode"
        colorscheme(scheme)
        require("lualine").setup()
    else
        colorscheme "Tomorrow-Night-Eighties"
    end
end

-- Swicth themes, and save the new theme configuration to shada.
function M.switchTheme(theme, background)
    if theme then
        vim.cmd.colorscheme(theme)
        THEME.theme = theme
    end
    if background then
        vim.o.background = background
        THEME.background = background
    else
        -- The user executed the ":set background" command.
        THEME.background = vim.o.background
    end
end

return {
    init = M.init,
    save = M.save,
    switchTheme = M.switchTheme,
}
