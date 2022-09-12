set tabstop=4
autocmd FileType json,html,xml,yaml set tabstop=2
set shiftwidth=0
set expandtab
set shiftround
set nobackup
" Enable regular expression expansion.
set magic
set nowrap
execute 'set textwidth=' . (&columns / 4 * 3)
" Enable mouse is all modes.
set mouse=a
set splitright
set splitbelow
" Automatic insertion of comments is disabled.
autocmd FileType * set formatoptions-=t formatoptions-=c formatoptions-=r
" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=3
set number
" The row and column where the cursor is located are highligted.
set cursorcolumn
set cursorline
execute 'set tags+=' . g:tags_file
