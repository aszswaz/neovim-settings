:function! CopyRow()
    let current_column = col(".")
    normal! yyp
    execute("normal! " . current_column . "|")
:endfunction

:function! DeleteRow()
    let current_column = col(".")
    normal! dd
    execute("normal! " . current_column . "|")
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
