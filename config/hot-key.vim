" The following is the shortcut key configuration,
" starting with n represents the shortcut key in normal mode,
" starting with i is the shortcut key in editing mode,
" nore is the non-recursive shortcut key, and map is the shortcut key mapping.
nnoremap <silent> <C-s> :lua text.row.trim()<cr>:w<cr>
inoremap <silent> <C-s> <esc>:lua text.row.trim()<cr>:w<cr>a
nnoremap <silent> <C-q> :wa<cr>:qa!<cr>
inoremap <silent> <C-q> <esc>:wa<cr>:qa!<cr>
nnoremap <silent> <C-f> :FileFormat<cr>
inoremap <silent> <C-f> <C-o>:FileFormat<cr>
inoremap <silent> <C-t><C-s> <esc>:TranslateW<cr>A
nnoremap <silent> <C-t><C-s> <esc>:TranslateW<cr>
vnoremap <silent> <C-t><C-s> :TranslateW<cr>
" Move the cursor to the first non-space character.
nnoremap <Home> ^
inoremap <Home> <esc>^i
" Enter the current time.
" \"iabbrev\" is the abbreviation function of vim,
" and you can replace it with the specified content by typing \"xxx\" in insert mode.
" \"<C-r>=\" is to execute the expression in insert mode and get the return value of the expression.
iabbrev ctime <C-r>=strftime('%Y-%m-%d %H:%M:%S')<cr>
" coc.vim autocomplete popup
inoremap <silent> <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<cr>"
inoremap <silent> <expr> <esc> coc#pum#visible() ? coc#pum#cancel() : "\<esc>"

if has('clipboard')
    vnoremap <C-c> "+y
    vnoremap <C-x> "+d
    nnoremap <C-p> "+p
    inoremap <C-p> <esc>"+pa
    tnoremap <C-p> <C-\><C-n>"+p
else
    vnoremap <C-c> y
    vnoremap <C-x> d
    nnoremap <C-p> p
    inoremap <C-p> <esc>pa
    tnoremap <C-p> <C-\><C-n>pa
endif
nnoremap <silent> <C-y> :lua text.row.delete()<cr>
inoremap <silent> <C-y> <esc>:lua text.row.delete()<cr>a
nnoremap <silent> <C-d> :lua text.row.copy()<cr>
inoremap <silent> <C-d> <esc>:lua text.row.copy()<cr>a
" select all
nnoremap <C-a> gg0vG$
inoremap <C-a> <esc>gg0vG$
vnoremap <C-a> gg0G$
" Move the current line up.
nnoremap <silent> <C-Up> :move -2<cr>
inoremap <silent> <C-Up> <esc>:move -2<cr>A
" Move the current line down.
nnoremap <silent> <C-Down> :move +1<cr>
inoremap <silent> <C-Down> <esc>:move +1<cr>A

nnoremap <silent> <A-c> :lua closeTab()<cr>
inoremap <silent> <A-c> <esc>:lua closeTab()<cr>
" Settings tab.
nnoremap <silent> <A-p> :BufferPin<cr>
inoremap <silent> <A-p> <esc>:BufferPin<cr>

" Open or close the file manager.
nnoremap <silent> <C-e> :NvimTreeFocus<cr>
inoremap <silent> <C-e> <esc>:NvimTreeFocus<cr>
" Refresh the file manager.
nnoremap <silent> <C-e><C-r> :NvimTreeRefresh<cr>
inoremap <silent> <C-e><C-r> <esc>:NvimTreeRefresh<cr>

nnoremap <silent> <C-z> :undo<cr>
inoremap <silent> <C-z> <esc>:undo<cr>a
nnoremap <silent> <A-z> :redo<cr>
inoremap <silent> <A-z> <esc>:redo<cr>a

" open/close terminal.
nnoremap <silent> <C-t><C-e> :ToggleTerm<cr>
inoremap <silent> <C-t><C-e> <esc>:ToggleTerm<cr>
tnoremap <silent> <C-t><C-e> <C-\><C-n>:ToggleTerm<cr>

" Switch tabs left or right.
nnoremap <silent> <A-Left> :BufferPrevious<cr>
inoremap <silent> <A-Left> <esc>:BufferPrevious<cr>
tnoremap <silent> <A-Left> <C-\><C-n>:BufferPrevious<cr>
nnoremap <silent> <A-Right> :BufferNext<cr>
inoremap <silent> <A-Right> <esc>:BufferNext<cr>
tnoremap <silent> <A-Right> <C-\><C-n>:BufferNext<cr>
" Swicth to the specified tab.
nnoremap <silent> <A-1> :BufferGoto 1<CR>
inoremap <silent> <A-1> :BufferGoto 1<CR>
nnoremap <silent> <A-2> :BufferGoto 2<CR>
inoremap <silent> <A-2> :BufferGoto 2<CR>
nnoremap <silent> <A-3> :BufferGoto 3<CR>
inoremap <silent> <A-3> :BufferGoto 3<CR>
nnoremap <silent> <A-4> :BufferGoto 4<CR>
inoremap <silent> <A-4> :BufferGoto 4<CR>
nnoremap <silent> <A-5> :BufferGoto 5<CR>
inoremap <silent> <A-5> :BufferGoto 5<CR>
nnoremap <silent> <A-6> :BufferGoto 6<CR>
inoremap <silent> <A-6> :BufferGoto 6<CR>
nnoremap <silent> <A-7> :BufferGoto 7<CR>
inoremap <silent> <A-7> :BufferGoto 7<CR>
nnoremap <silent> <A-8> :BufferGoto 8<CR>
inoremap <silent> <A-8> :BufferGoto 8<CR>
nnoremap <silent> <A-9> :BufferLast<CR>
inoremap <silent> <A-9> :BufferLast<CR>
