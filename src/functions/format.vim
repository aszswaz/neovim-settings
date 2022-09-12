" Format files via external tools.
function! FileFormat()
    if &filetype == 'json'
        let command = 'jq'
    elseif &filetype == "java"
        let command = 'astyle --style=java --indent=spaces=' . &tabstop . ' --mode=java'
    elseif &filetype == "python"
        let command = 'autopep8 --max-line-length ' .  . ' -'
    elseif &filetype == "lua"
        let command = 'stylua - --indent-type Spaces --indent-width ' . &tabstop .
                    \' --call-parentheses None --quote-style AutoPreferDouble --column-width ' . &textwidth
    elseif &filetype == "tex" || &filetype == "latex"
        let command = 'latexindent'
    elseif &filetype == "xml"
        let command = 'xmllint --encode UTF-8 --format -'
    elseif &filetype == "cpp" || &filetype == "c"
        let command = 'astyle --style=java --indent=spaces=' . &tabstop . ' --pad-oper -N -C --indent-labels -xw -xW -w --mode=c'
    elseif &filetype == "sh" || &filetype == "zsh" || &filetype == "bash"
        let command = 'shfmt -ln bash -i ' . &tabstop
    elseif &filetype == "typescript" || &filetype == "javascript" || &filetype == "js"
        let command = 'prettier --parser typescript --print-width ' . &textwidth . ' --tab-width ' . &tabstop .
                    \' --no-semi --single-attribute-per-line'
    elseif &filetype == 'css' || &filetype == 'scss' || &filetype == 'less'
        let command = 'prettier --parser ' . &filetype . ' --print-width ' . &textwidth . ' --tab-width ' . &tabstop .
                    \' --no-semi --single-attribute-per-line'
    elseif &filetype == 'html'
        let command = 'prettier --parser html --print-width ' . &textwidth . ' --tab-width ' . &tabstop . ' --no-semi --single-attribute-per-line'
    elseif &filetype == 'vue'
        let command = 'prettier --parser vue --print-width ' . &textwidth . ' --tab-width ' . &tabstop .
                    \' --no-semi --single-attribute-per-line --vue-indent-script-and-style'
    elseif &filetype == 'markdown'
        let command = 'prettier --parser markdown --print-width ' . &textwidth . ' --tab-width ' . &tabstop
    elseif &filetype == 'yaml'
        let command = 'prettier --parser yaml --print-width ' . &textwidth . ' --tab-width ' . &tabstop
    else
        call v:lua.DialogError('Unknown file type: ' . vim.o.filetype)
        return
    endif

    let output = systemlist(command, getline(1, '$'))
    if v:shell_error == 0
        call setline(1, output)
        " Delete extra lines.
        let del_start = len(output) + 1
        let del_end = line('$')
        if del_end > del_start
            call deletebufline(bufnr(), del_start, del_end)
        endif
    else
        call v:lua.DialogError(output)
    endif
endfunction
