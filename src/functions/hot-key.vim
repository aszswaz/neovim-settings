:function! SetClipboardKey()
    if has('clipboard')
        :vnoremap <C-c> "+y
        :vnoremap <C-x> "+d
        :nnoremap <C-p> "+P
        :tnoremap <C-p> <C-\><C-n>"+Pa
    else
        :vnoremap <C-c> y
        :vnoremap <C-x> d
        :nnoremap <C-p> P
        :tnoremap <C-p> <C-\><C-n>Pa
    endif
    :inoremap <C-p> <C-r>+
:endfunction
