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
    normal! yyp
    execute("normal! " . current_column . "|")
:endfunction

" 删除行
:function! DeleteRow()
    let current_column = col(".")
    normal! dd
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

" Format files via external tools.
:function! FileFormat()
    let current_line = line('.')
    let current_column = col('.')
    let max_line_length = 160

    if &filetype == 'json'
        let command = 'jq'
    elseif &filetype == "java"
        let command = 'astyle --style=java --indent=spaces=' . &tabstop . ' --mode=java'
    elseif &filetype == "python"
        let command = 'autopep8 --max-line-length ' . max_line_length . ' -'
    elseif &filetype == "lua"
        let command = 'stylua - --indent-type Spaces --indent-width ' . &tabstop . ' --call-parentheses None --quote-style AutoPreferDouble'
    elseif &filetype == "tex" || &filetype == "latex"
        let command = 'latexindent'
    elseif &filetype == "xml"
        let command = 'xmllint --encode UTF-8 --format -'
    elseif &filetype == "cpp" || &filetype == "c"
        let command = 'astyle --style=java --indent=spaces=' . &tabstop . ' --pad-oper -N -C --indent-labels -xw -xW -w --mode=c'
    elseif &filetype == "sh" || &filetype == "zsh" || &filetype == "bash"
        let command = 'shfmt -ln sh -i ' . &tabstop
    elseif &filetype == "typescript" || &filetype == "javascript" || &filetype == "js"
        let command = 'prettier --parser typescript --print-width ' . max_line_length . ' --tab-width ' . &tabstop .
                    \' --no-semi --single-attribute-per-line'
    elseif &filetype == 'css' || &filetype == 'scss' || &filetype == 'less'
        let command = 'prettier --parser ' . &filetype . ' --print-width ' . max_line_length . ' --tab-width ' . &tabstop .
                    \' --no-semi --single-attribute-per-line'
    elseif &filetype == 'html'
        let command = 'prettier --parser html --print-width ' . max_line_length . ' --tab-width ' . &tabstop . ' --no-semi --single-attribute-per-line'
    elseif &filetype == 'vue'
        let command = 'prettier --parser vue --print-width ' . max_line_length . ' --tab-width ' . &tabstop .
                    \' --no-semi --single-attribute-per-line --vue-indent-script-and-style'
    elseif &filetype == 'markdown'
        let command = 'prettier --parser markdown --print-width ' . max_line_length . ' --tab-width ' . &tabstop
    elseif &filetype == 'yaml'
        let command = 'prettier --parser yaml --print-width ' . max_line_length . ' --tab-width ' . &tabstop
    else
        echo "Unknown file type: " . &filetype
        return
    endif

    let output = systemlist(command, getline(1, '$'))
    if v:shell_error == 0
        call setline(1, output)
        " Delete extra lines.
        let del_start = len(output) + 1
        let del_end = line('.')
        if del_end > del_start
            call deletebufline(bufnr('.'), del_start, del_end)
        endif
    else
        echohl ErrorMsg
        for line in output
            echo line
        endfor
        echohl None
    endif
:endfunction

" Trim trailing whitespace.
:function! Trim()
    let line_count = line('$')
    " Iterate over all rows.
    for line_number in range(1, line_count)
        let line_text = getline(line_number)
        let line_len = strlen(line_text)
        if line_len == 0
            continue
        endif

        " Find the last non-space character.
        let last_index = line_len - 1
        let i = last_index
        while i >= 0 && strgetchar(line_text, i) == 32
            let i -= 1
        endwhile

        if i == -1
            " The line does not has non-space characters.
            call setline(line_number, '')
        else
            " Remove whitespace at the end of the line, keep non-whitespace characters.
            call setline(line_number, line_text[0:i])
        endif
    endfor
:endfunction
