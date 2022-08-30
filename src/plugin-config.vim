" 插件的配置

" 快捷键的配置
" 打开文件管理器，此功能依赖于文件管理器插件
:nnoremap <C-e> :NvimTreeToggle<cr>
:inoremap <C-e> <esc>:NvimTreeToggle<cr>
" 刷新文件管理器
:nnoremap <C-r> :NvimTreeRefresh<cr>
:inoremap <C-r> <esc>:NvimTreeRefresh<cr>

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
