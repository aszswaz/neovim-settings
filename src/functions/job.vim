" The callback function for jobstart.
:function! JobHandler(job_id, data, event) dict
    if a:event == 'stdout'
        echo join(a:data, nr2char(10))
    elseif a:event == 'stderr'
        echohl ErrorMsg | echo join(a:data, nr2char(10)) | echohl None
    elseif a:event == "exit"
        echo self.command . " exit code: " . a:data
    endif
:endfunction
