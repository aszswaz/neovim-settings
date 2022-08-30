" neovim configuration folder
:let g:config_dir=split(&runtimepath, ',')[0]
" C++, C label files.
:let g:tags_file=g:config_dir . '/tags'
