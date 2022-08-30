" neovim 的基本配置
" 开启语法高亮
:syntax on

" 根据文件类型，设置制表符的宽度
:set tabstop=4
:autocmd FileType json,html,xml set tabstop=2
" 缩进应该跨越的宽度，0 表示复制 tabstop 的值，-1 表示复制 shiftwidth 的值
:set softtabstop=0
" shiftwidth 给出用于移位命令的宽度，例如 << , >>和 == .特殊值 0 表示复制 'tabstop' 的值。
:set shiftwidth=0
" 设置 expandtab，缩进总是只使用空格字符。否则，按 <Tab> 插入尽可能多的制表字符，并用空格字符完成缩进宽度。
:set expandtab
" 移动文本时将缩进舍入为 'shiftwidth' 的倍数
:set shiftround
" 重现上一行的缩进
:set autoindent
" 设置光标距离窗口最下面的最小行数，比如一个 vim 屏幕的最下方是第 66 行，那么当光标到达第 61 行时就开始向上翻滚。
:set scrolloff=3

" 显示行号
:set number
" 开启光标所在位置的行和列高亮
:set cursorcolumn
:set cursorline

" vim 其他杂项设置
" 关闭备份
:set nobackup
" 编码设置
:set enc=utf-8
:set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
"语言设置
:set langmenu=zh_CN.UTF-8
:set helplang=cn
:set magic
" 自动换行
:set nowrap
" 文件在外部被修改，自动更新
:set autoread
" neovim 会在文本长度达到 78 时，自动添加 \n 拆行，如果直接 :set textwidth=0 那么 textwidth 会在其他的脚本当中被设置为 78，所以这里通过关闭文本格式化的方式，达到禁用该功能的目的
:set fo-=t
" 设置鼠标可点击
:set mouse=a
" 设置新的分屏出现的位置，如果是垂直分屏，新的分屏出现在右边，如果是水平分屏，新的分屏在下边
:set splitright
:set splitbelow
" 启用真彩色
:set termguicolors
" gdb debug 设置
" 关闭源码悬浮窗
:let g:termdebug_popup=0
:let g:termdebug_wide=163
" 设置光标闪烁
:set guicursor+=a:blinkon1

" 写出文件之前，删除尾部空格
:autocmd BufWritePre * :call Trim()
