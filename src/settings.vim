:set tabstop=4
:autocmd FileType json,html,xml,yaml set tabstop=2
:set shiftwidth=0
:set expandtab
:set shiftround
:set nobackup
" Enable regular expression expansion.
:set magic
:set nowrap
:set textwidth=0
" Enable mouse is all modes.
:set mouse=a
:set splitright
:set splitbelow
" Set up the gdb window.
:let g:termdebug_popup=0
:let g:termdebug_wide=163
" Automatic insertion of comments is disabled.
:autocmd FileType * set formatoptions-=c formatoptions-=t formatoptions-=r
" Minimal number of screen lines to keep above and below the cursor.
:set scrolloff=3
:set number
" The row and column where the cursor is located are highligted.
:set cursorcolumn
:set cursorline
