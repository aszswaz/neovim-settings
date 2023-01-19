-- If the user has set --noplugin in the startup parameters of neovim, then disable the plugin and the related configuration of the plugin.
local runtime = vim.cmd.runtime
if vim.o.loadplugins then
    runtime "config/plugins.lua"
    runtime "config/plugin-config.lua"
end

runtime "config/settings.lua"
runtime "config/hot-key.lua"
runtime "config/commands.lua"
runtime "config/autocmd.lua"
runtime "config/theme.lua"
