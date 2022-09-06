:function SetClipboardKey()
    if has('clipboard')
        :vnoremap <C-c> "+y
        :vnoremap <C-x> "+d
        :nnoremap <C-p> "+p
        :inoremap <C-p> <C-o>"+p
        :tnoremap <C-p> <C-\><C-n>"+pa
    else
        :vnoremap <C-c> y
        :vnoremap <C-x> d
        :nnoremap <C-p> p
        :inoremap <C-p> <C-o> p
        :tnoremap <C-p> <C-\><C-n>pa
    endif
:endfunction
