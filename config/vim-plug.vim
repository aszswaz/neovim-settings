" vim-plug
call plug#begin('~/.config/nvim/vim-plugins')

" Translation plugin.
Plug 'voldikss/vim-translator'
" Terminal plugin.
Plug 'akinsho/toggleterm.nvim'
" Programming language helper plugins.
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" A gui function for nvim-qt.
Plug 'equalsraf/neovim-gui-shim'
" Indent level display plugin
Plug 'lukas-reineke/indent-blankline.nvim'
" Bookmark plugin.
Plug 'MattesGroeger/vim-bookmarks'
" Fuzzy lookup plugin.
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
" Start screen plugin.
Plug 'mhinz/vim-startify'
" gdb debugging plugin.
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }

call plug#end()
