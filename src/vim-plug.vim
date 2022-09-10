" vim-plug
:call plug#begin('~/.config/nvim/vim-plugins')

" File manager.
:Plug 'kyazdani42/nvim-tree.lua'
" File icon.
:Plug 'kyazdani42/nvim-web-devicons'
" Translation plugin.
:Plug 'voldikss/vim-translator'
" Terminal plugin.
:Plug 'akinsho/toggleterm.nvim'
" Programming language helper plugins.
:Plug 'neoclide/coc.nvim', {'branch': 'release'}
" A gui function for nvim-qt.
:Plug 'equalsraf/neovim-gui-shim'
" Indent level display plugin
:Plug 'lukas-reineke/indent-blankline.nvim'
" vim status bar plugin, there are some supporting plugins below.
:Plug 'itchyny/lightline.vim'
:Plug 'itchyny/vim-gitbranch'
" Bookmark plugin.
:Plug 'MattesGroeger/vim-bookmarks'
" Fuzzy lookup plugin.
:Plug 'nvim-lua/plenary.nvim'
:Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
" Start screen plugin.
:Plug 'mhinz/vim-startify'

" theme
" :Plug 'dracula/vim'
" :Plug 'morhetz/gruvbox'
" :Plug 'junegunn/seoul256.vim'
:Plug 'joshdick/onedark.vim'

:call plug#end()
