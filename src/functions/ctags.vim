function! UpdateCtags()
    if !has('linux')
        echohl ErrorMsg | echo 'This function only supports running under the linux operating system.' | echohl None
        return
    endif

    echo "Generating labels..."
    let callbacks = {
        \ 'on_stdout': function('JobHandler'),
        \ 'on_stderr': function('JobHandler'),
        \ 'on_exit': function('JobHandler')
    \ }
    " 异步执行外部命令
    call jobstart('ctags -f ' . g:tags_file .
                \' -I __THROW --extras=+F --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --fields=+S -R /usr/include',
                \ extend({'command': 'ctags'}, callbacks))
endfunction

function! LoadCtags()
    if !has('linux')
        echohl ErrorMsg | echo 'This function only supports running under the linux operating system.' | echohl None
        return
    endif

    if filereadable(g:tags_file)
        execute('set tags=' . g:tags_file)
    else
        call UpdateCtags()
    endif
endfunction
