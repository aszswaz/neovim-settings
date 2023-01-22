--[[
    neovim will save variables with variable names in all uppercase to the shada file.
    We use this function to save the theme currently used by the user,
    and then automatically use the theme used by the user when the user starts neovim next time.
--]]
local M = {}

-- The name of the variable stored in shada.
local COLOR_SCHEME = "COLOR_SCHEME"
local BACKGROUND = "BACKGROUND"

function M.setTheme()
    local colorscheme = vim.cmd.colorscheme
    local exists = function(expr)
        return vim.fn.exists(expr) == 1
    end

    if vim.o.loadplugins then
        -- read theme settings from a shada file
        local scheme = exists("g:" .. COLOR_SCHEME) and vim.api.nvim_get_var(COLOR_SCHEME) or "vscode"
        colorscheme(scheme)

        if exists("g:" .. BACKGROUND) then
            local background = vim.api.nvim_get_var(BACKGROUND)
            vim.o.background = background
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

        require("lualine").setup()
    else
        colorscheme "Tomorrow-Night-Eighties"
    end
end

function M.save(theme)
    local setGlobalVar = vim.api.nvim_set_var

    if theme then
        setGlobalVar(COLOR_SCHEME, theme)
    end

    setGlobalVar(BACKGROUND, vim.o.background)
end

-- Swicth themes, and save the new theme configuration to shada.
function M.switchTheme(theme)
    vim.cmd.colorscheme(theme)
    M.save(theme)
end

return { setTheme = M.setTheme, save = M.save, switchTheme = M.switchTheme }
