-- Set the theme and trigger the ColorScheme event, the theme file is in the colors directory.

--[[
    Available themes:
    vscode
    tokyonight
    tokyonight-day
    tokyonight-moon
    tokyonight-storm
    Tomorrow-Night-Eighties
    onedark
--]]

local colorscheme = vim.cmd.colorscheme

if vim.o.loadplugins then
    colorscheme("onedark")
else
    colorscheme "Tomorrow-Night-Eighties"
end
