" 如果用户在 neovim 的启动参数中设置了 --noplugin，那么禁用插件和插件的有关配置
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
