-- Set the theme and trigger the ColorScheme event, the theme file is in the colors directory.
local colorscheme = vim.cmd.colorscheme
if vim.o.loadplugins then
    colorscheme "vscode"
    -- colorscheme "tokyonight"
    -- colorscheme "tokyonight-day"
    -- colorscheme "tokyonight-moon"
    -- colorscheme "tokyonight-storm"
else
    colorscheme "Tomorrow-Night-Eighties"
end
