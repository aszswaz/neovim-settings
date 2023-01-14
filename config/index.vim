" If the user has set --noplugin in the startup parameters of neovim, then disable the plugin and the related configuration of the plugin.
if &loadplugins
    runtime config/vim-plug.vim
    runtime config/packer.lua
    runtime config/plugin-config.lua
endif

runtime config/settings.lua
runtime config/hot-key.vim
runtime config/hot-key.lua
runtime config/commands.lua
runtime config/autocmd.lua
runtime config/theme.vim
