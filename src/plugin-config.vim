" 插件的配置

" 状态栏主题配置
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

" vim-bookmarks 插件配置
:highlight BookmarkSign ctermbg=NONE ctermfg=160
:highlight BookmarkLine ctermbg=194 ctermfg=NONE
:let g:bookmark_sign = '⚑'
:let g:bookmark_highlight_lines = 1
