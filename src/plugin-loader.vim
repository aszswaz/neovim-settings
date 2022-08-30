" 加载 neovim 或者 vim 的插件
" vim-plug 初始化，以及指定插件的安装目录
:call plug#begin('~/.config/nvim/vim-plugins')

" 文件管理器
:Plug 'kyazdani42/nvim-tree.lua'
" 文件管理器中的文件图标
:Plug 'kyazdani42/nvim-web-devicons'
" 翻译插件
:Plug 'voldikss/vim-translator'
" 终端插件
:Plug 'akinsho/toggleterm.nvim'
" 编程语言辅助插件
:Plug 'neoclide/coc.nvim', {'branch': 'release'}
" nvim-qt 的 gui 功能插件
:Plug 'equalsraf/neovim-gui-shim'
" 缩进层级展示插件
:Plug 'lukas-reineke/indent-blankline.nvim'
" vim 状态栏插件，下面有些配套插件
:Plug 'itchyny/lightline.vim'
:Plug 'itchyny/vim-gitbranch'
" 书签
:Plug 'MattesGroeger/vim-bookmarks'
" vim 欢迎页插件
:Plug 'aszswaz/vim-startify'

" vim 主题插件
:Plug 'dracula/vim'
:Plug 'morhetz/gruvbox'
:Plug 'junegunn/seoul256.vim'
:Plug 'joshdick/onedark.vim'

:call plug#end()

" packer 和 vim-plug 一样，也是一个 neovim 的插件管理器
:lua require("packer-config")

" 运行 lua/plugin-loader.lua 脚本，加载那些使用 lua 编写的插件
:lua require("plugin-loader")
