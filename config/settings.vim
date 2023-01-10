" 设置 TAB 缩进
set tabstop=4
autocmd FileType json,html,xml,yaml,svg,sql set tabstop=2
set shiftwidth=0
set expandtab
set shiftround
set nobackup
set magic
" 设置自动换行
set nowrap
autocmd FileType text,desktop set wrap
execute 'set textwidth=' . (&columns / 4 * 3)
" 启用鼠标
set mouse=a
set splitright
set splitbelow
" 禁用自动插入注释
autocmd FileType * set formatoptions-=t
set scrolloff=3
set number
" 设置光标所在行和列高亮
set cursorcolumn
set cursorline
" 使用 C 和 C++ 的标签文件
execute 'set tags+=' . stdpath('config') . '/tags'
" 启用真彩色
set termguicolors
