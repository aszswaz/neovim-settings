" Status bar theme configuration.
let g:lightline = {
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
autocmd ColorScheme * :highlight BookmarkSign guibg=NONE guifg='#D70000'
autocmd ColorScheme * :highlight BookmarkLine guibg='#D7FFD7' guifg=NONE
let g:bookmark_sign = '⚑'
let g:bookmark_highlight_lines = 1
