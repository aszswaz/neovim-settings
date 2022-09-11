function! SetClipboardKey()
    if has('clipboard')
        vnoremap <C-c> "+y
        vnoremap <C-x> "+d
        nnoremap <C-p> "+p
        tnoremap <C-p> <C-\><C-n>"+p
    else
        vnoremap <C-c> y
        vnoremap <C-x> d
        nnoremap <C-p> p
        tnoremap <C-p> <C-\><C-n>pa
    endif
    inoremap <C-p> <C-r>+
endfunction
