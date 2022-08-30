:command! LoadCtags :call LoadCtags()
:command! UpdateCtags :call UpdateCtags()

:autocmd FileType cpp,c :LoadCtags
