set tabstop=4
autocmd FileType json,html,xml,yaml,svg set tabstop=2
set shiftwidth=0
set expandtab
set shiftround
set nobackup
" Enable regular expression expansion.
set magic
" Set automatic line wrapping.
set nowrap
autocmd FileType text set wrap
execute 'set textwidth=' . (&columns / 4 * 3)
" Enable mouse is all modes.
set mouse=a
set splitright
set splitbelow
" Automatic insertion of comments is disabled.
autocmd FileType * set formatoptions-=t
" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=3
set number
" The row and column where the cursor is located are highligted.
set cursorcolumn
set cursorline
execute 'set tags+=' . stdpath('config') . '/tags'
" Enable True Color.
set termguicolors
