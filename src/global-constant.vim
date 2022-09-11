" neovim configuration folder
if getenv('XDG_CONFIG_HOME') != v:null
    let g:config_dir = getenv('XDG_CONFIG_HOME') . '/nvim'
elseif has('unix')
    let g:config_dir = getenv('HOME') . '/.config/nvim'
elseif has('win32')
    let g:config_dir = getenv('USERHOME') . '/AppData/Local/nvim'
else
    echohl ErrorMsg | echo 'Unknown platform.' | echohl None
endif

" C++, C label files.
let g:tags_file=g:config_dir . '/tags'
