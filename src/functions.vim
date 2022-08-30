" 自定义函数

" 插件中的 gitbranch#name 函数只返回分支名称，这里加上一个 unicode 的电路图标表示 git 图标
:function! Gitbranchicon()
    let branchname=gitbranch#name()
    if empty(branchname)
        return ""
    else
        return " " . branchname
    endif
:endfunction

" 显示用户名称
:function! Username()
    return $USER
:endfunction

" 关闭当前标签，其实是关闭 vim 的 buffer，但是 romgrk/barbar.nvim 插件会把 buffer 作为标签页，所以关闭 buffer 相当于关闭标签页
:function! CloseTab()
    " 获得当前 buffer 的序号
    let current_buffer = bufnr("%")
    " 如果当前 buffer 已被用户修改，先保存到文件
    if getbufinfo(current_buffer)[0].changed
        w
    endif
    " 关闭 buffer
    BufferClose
:endfunction

" 复制行
:function! CopyRow()
    let current_column = col(".")
    execute("normal! yyp")
    execute("normal! " . current_column . "|")
:endfunction

" 删除行
:function! DeleteRow()
    let current_column = col(".")
    execute("normal! dd")
    execute("normal! " . current_column . "|")
:endfunction

" jobstart 的回调函数
:function! JobHandler(job_id, data, event) dict
    if a:event == 'stdout'
        echo join(a:data, nr2char(10))
    elseif a:event == 'stderr'
        echohl ErrorMsg | echo join(a:data, nr2char(10)) | echohl None
    elseif a:event == "exit"
        echo self.command . " exit code: " . a:data
    endif
:endfunction

:function! UpdateCtags()
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
    call jobstart('ctags -f ' . g:tags_file . ' -I __THROW --extras=+F --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --fields=+S -R /usr/include',
                \ extend({'command': 'ctags'}, callbacks))
:endfunction

:function! LoadCtags()
    if !has('linux')
        echohl ErrorMsg | echo 'This function only supports running under the linux operating system.' | echohl None
        return
    endif

    if filereadable(g:tags_file)
        execute('set tags=' . g:tags_file)
    else
        call UpdateCtags()
    endif
:endfunction

" 通过外部工具格式化文件
:function! FileFormat()
    " 获取当前行号
    let current_line = line('.')
    let current_column = col('.')

    if &filetype == 'json'
        let command = 'jq'
    elseif &filetype == "java"
        let command = 'astyle --style=java --indent=spaces=' . &tabstop . ' --mode=java'
    elseif &filetype == "python"
        let command = 'autopep8 --max-line-length 10000 -'
    elseif &filetype == "lua"
        let command = 'stylua - --indent-type Spaces --indent-width ' . &tabstop . ' --call-parentheses None --quote-style AutoPreferDouble'
    elseif &filetype == "tex" || &filetype == "latex"
        let command = 'latexindent'
    elseif &filetype == "xml"
        let command = 'xmllint --encode UTF-8 --format -'
    elseif &filetype == "cpp" || &filetype == "c"
        let command = 'astyle --style=java --indent=spaces=' . &tabstop . ' --pad-oper -N -C --indent-labels -xw -xW -w --mode=c'
    elseif &filetype == "sh" || &filetype == "zsh" || &filetype == "bash"
        let command = 'shfmt -i ' . &tabstop
    elseif &filetype == "typescript" || &filetype == "javascript" || &filetype == "js"
        let command = 'prettier --parser typescript --print-width --tab-width ' . &tabstop
    elseif &filetype == "css" || &filetype == "scss" || &filetype == "less" || &filetype == "markdown" || &filetype == "vue" || &filetype == "html"
        let command = 'prettier --prettier ' . &filetype . ' --print-width 160 --tab-width ' . &tabstop
    else
        echo "Unknown file type: " . &filetype
        return
    endif

    let output = system(command, getline(1, '$'))
    if v:shell_error == 0
        " clear buffer
        silent %delete _
        call setline(1, split(output, '\n'))
        " 光标回到到原本的行
        execute("normal! " . current_line . "G")
        execute("normal! " . current_column . "|")
    else
        echohl ErrorMsg | echo output | echohl None
    endif
:endfunction

" Trim trailing whitespace.
:function! Trim()
    let line_count = line('$')
    for line_number in range(1, line_count)
        let line_text = getline(line_number)
        " Find the last non-space character.
        let i = strlen(line_text) - 1
        while i > 0
            if strgetchar(line_text, i) != 32
                break
            endif
            let i -= 1
        endwhile
        call setline(line_number, line_text[0:i])
    endfor
:endfunction
