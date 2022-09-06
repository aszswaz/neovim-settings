" Status bar theme configuration.
:let g:lightline = {
        \ 'colorscheme': 'onedark',
        \ 'active': {
            \ 'left': [ [ 'mode', 'paste' ], [ 'user', 'gitbranch', 'readonly', 'filename', 'modified' ] ]
        \ },
        \ 'component_function': {
            \ 'user': 'Username',
            \ 'gitbranch': 'Gitbranchicon'
        \ }
    \ }

" vim-bookmarks
:autocmd ColorScheme * :highlight BookmarkSign ctermbg=NONE ctermfg=160 guibg=NONE ctermfg='#D70000'
:autocmd ColorScheme * :highlight BookmarkLine ctermbg=194 ctermfg=NONE guibg='#D7FFD7' guifg=NONE
:let g:bookmark_sign = '⚑'
:let g:bookmark_highlight_lines = 1

" Sets the background color of the coc.vim autocomplete pupup.
:autocmd ColorScheme * :highlight CocMenuSel ctermbg=237 guibg='#445444'
