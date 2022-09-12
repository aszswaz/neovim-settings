" The gitbranch#name function in the plugin only returns the branch name, here a unicode circuit icon is added to represent the git icon.
function! Gitbranchicon()
    let branchname=gitbranch#name()
    if empty(branchname)
        return ""
    else
        return " " . branchname
    endif
endfunction

" show username
function! Username()
    return $USER
endfunction

" Closing the current tab is actually closing the vim buffer, but the romgrk/barbar.nvim plugin will use the buffer as a tab,
" so closing the buffer is equivalent to closing the tab.
function! CloseTab()
    " Get the sequence number of the current buffer
    let current_buffer = bufnr('%')
    " If the current buffer has been modified by the user, save it to a file first.
    if getbufinfo(current_buffer)[0].changed
        w
    endif
    " Close buffer
    BufferClose
endfunction

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
