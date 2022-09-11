let s:win_id = 0
let s:win_buf = 0
let s:time = 5000

" Define the dialog style.
:autocmd ColorScheme * :highlight DialogError guifg='#E06C75' guibg=NONE

:function! ErrorDialog(messages)
    if s:win_buf != 0 | return | endif

    let s:win_buf = nvim_create_buf(v:false, v:true)
    call setbufline(s:win_buf, 1, a:messages)

    let width = 40
    let height = 5
    let win_x = &columns - 1
    let win_y = &lines - 3

    let s:win_id = nvim_open_win(s:win_buf, v:false, {
                \'relative': 'editor',
                \'anchor': 'SE',
                \'row': win_y,
                \'col': win_x,
                \'width': width,
                \'height': height,
                \'focusable': v:false,
                \'style': 'minimal',
                \'noautocmd': v:false,
                \'bufpos': [0, 0],
                \'border': 'rounded'
                \})

    call nvim_win_set_option(s:win_id, 'wrap', v:true)
    call nvim_win_set_option(s:win_id, 'winhighlight', 'NormalFloat:DialogError,FloatBorder:DialogError')
    call timer_start(s:time, 'DialogClose')
:endfunction

:function DialogClose(timer)
    if s:win_id != 0
        call nvim_win_close(s:win_id, v:true)
        let s:win_id = 0
    endif
    if s:win_buf != 0
        call nvim_buf_delete(s:win_buf, {'force': v:true})
        let s:win_buf = 0
    endif
:endfunction
