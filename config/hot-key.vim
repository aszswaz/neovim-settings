" 以下是快捷键配置，n开头代表普通模式下的快捷键，i开头是编辑模式下的快捷键，nore是不递归快捷键，map是快捷键映射
" vim普通状态下的保存，<cr>表示回车，执行 :w 命令
nnoremap <silent> <C-s> :lua text.row.trim()<cr>:w<cr>
" vim 编辑状态下的保存：<esc>退出编辑模式，:w 保存，<cr> 回车，a 回到编辑模式
inoremap <silent> <C-s> <esc>:lua text.row.trim()<cr>:w<cr>a
" 一次性保存所有打开的文件，并关闭 VIM
nnoremap <silent> <C-q> :wa<cr>:qa!<cr>
inoremap <silent> <C-q> <esc>:wa<cr>:qa!<cr>
" 根据文件类型格式化文件
nnoremap <silent> <C-f> :FileFormat<cr>
inoremap <silent> <C-f> <C-o>:FileFormat<cr>
" 翻译单词
inoremap <silent> <C-t><C-s> <esc>:TranslateW<cr>A
nnoremap <silent> <C-t><C-s> <esc>:TranslateW<cr>
vnoremap <silent> <C-t><C-s> :TranslateW<cr>
" 移动光标到第一个非空格字符
nnoremap <Home> ^
inoremap <Home> <esc>^i
" 输入当前时间。iabbrev 是 vim 的缩写功能，在插入模式下输入“xxx ”就能替换为指定的内容。“<C-r>=”是在插入模式下执行表达式，并获得表达式的返回值
iabbrev ctime <C-r>=strftime('%Y-%m-%d %H:%M:%S')<cr>

if has('clipboard')
    vnoremap <C-c> "+y
    vnoremap <C-x> "+d
    nnoremap <C-p> "+p
    inoremap <C-p> <esc>"+pa
    tnoremap <C-p> <C-\><C-n>"+p
else
    vnoremap <C-c> y
    vnoremap <C-x> d
    nnoremap <C-p> p
    inoremap <C-p> <esc>pa
    tnoremap <C-p> <C-\><C-n>pa
endif
" 删除行
nnoremap <silent> <C-y> :lua text.row.delete()<cr>
inoremap <silent> <C-y> <esc>:lua text.row.delete()<cr>a
" 复制行
nnoremap <silent> <C-d> :lua text.row.copy()<cr>
inoremap <silent> <C-d> <esc>:lua text.row.copy()<cr>a
" 全选
nnoremap <C-a> gg0vG$
inoremap <C-a> <esc>gg0vG$
vnoremap <C-a> gg0G$
" 上移一整行
nnoremap <silent> <C-Up> :move -2<cr>
inoremap <silent> <C-Up> <esc>:move -2<cr>A
" 下移一整行
nnoremap <silent> <C-Down> :move +1<cr>
inoremap <silent> <C-Down> <esc>:move +1<cr>A

" 保存文件、关闭缓冲区并关闭标签页
nnoremap <silent> <A-c> :lua closeTab()<cr>
inoremap <silent> <A-c> <esc>:lua closeTab()<cr>
" 置项标签页
nnoremap <silent> <A-p> :BufferPin<cr>
inoremap <silent> <A-p> <esc>:BufferPin<cr>

" 打开文件管理器，此功能依赖于文件管理器插件
nnoremap <silent> <C-e> :NvimTreeToggle<cr>
inoremap <silent> <C-e> <esc>:NvimTreeToggle<cr>
" 刷新文件管理器
nnoremap <silent> <C-e><C-r> :NvimTreeRefresh<cr>
inoremap <silent> <C-e><C-r> <esc>:NvimTreeRefresh<cr>

" 撤销
nnoremap <silent> <C-z> :undo<cr>
inoremap <silent> <C-z> <esc>:undo<cr>a
" 重做
nnoremap <silent> <A-z> :redo<cr>
inoremap <silent> <A-z> <esc>:redo<cr>a

" 打开/关闭终端
nnoremap <silent> <C-t><C-e> :ToggleTerm<cr>
inoremap <silent> <C-t><C-e> <esc>:ToggleTerm<cr>
tnoremap <silent> <C-t><C-e> <C-\><C-n>:ToggleTerm<cr>
" 退出终端模式
tnoremap <esc> <C-\><C-n>

" barbar.nvim 快捷键配置
" 向左或向右切换标签页
nnoremap <silent> <A-Left> :BufferPrevious<cr>
inoremap <silent> <A-Left> <esc>:BufferPrevious<cr>
tnoremap <silent> <A-Left> <C-\><C-n>:BufferPrevious<cr>
nnoremap <silent> <A-Right> :BufferNext<cr>
inoremap <silent> <A-Right> <esc>:BufferNext<cr>
tnoremap <silent> <A-Right> <C-\><C-n>:BufferNext<cr>
" 切换到指定标签页
nnoremap <silent> <A-1> :BufferGoto 1<CR>
inoremap <silent> <A-1> :BufferGoto 1<CR>
nnoremap <silent> <A-2> :BufferGoto 2<CR>
inoremap <silent> <A-2> :BufferGoto 2<CR>
nnoremap <silent> <A-3> :BufferGoto 3<CR>
inoremap <silent> <A-3> :BufferGoto 3<CR>
nnoremap <silent> <A-4> :BufferGoto 4<CR>
inoremap <silent> <A-4> :BufferGoto 4<CR>
nnoremap <silent> <A-5> :BufferGoto 5<CR>
inoremap <silent> <A-5> :BufferGoto 5<CR>
nnoremap <silent> <A-6> :BufferGoto 6<CR>
inoremap <silent> <A-6> :BufferGoto 6<CR>
nnoremap <silent> <A-7> :BufferGoto 7<CR>
inoremap <silent> <A-7> :BufferGoto 7<CR>
nnoremap <silent> <A-8> :BufferGoto 8<CR>
inoremap <silent> <A-8> :BufferGoto 8<CR>
nnoremap <silent> <A-9> :BufferLast<CR>
inoremap <silent> <A-9> :BufferLast<CR>

" coc.vim 自动补全弹出窗口。确认选择
inoremap <silent> <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<cr>"
inoremap <silent> <expr> <esc> coc#pum#visible() ? coc#pum#cancel() : "\<esc>"
