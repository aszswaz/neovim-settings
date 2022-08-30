" 以下是快捷键配置，n开头代表普通模式下的快捷键，i开头是编辑模式下的快捷键，nore是不递归快捷键，map是快捷键映射
" vim普通状态下的保存，<cr>表示回车，执行 :w 命令
:nnoremap <silent> <C-s>      :w<cr>
" vim 编辑状态下的保存：<esc>退出编辑模式，:w 保存，<cr> 回车，a 回到编辑模式
:inoremap <silent> <C-s>      <esc>:w<cr>a
" 一次性保存所有打开的文件，并关闭 VIM
:nnoremap <silent> <C-q>      :wa<cr>:qa!<cr>
:inoremap <silent> <C-q>      <esc>:wa<cr>:qa!<cr>
" 撤销
:nnoremap <silent> <C-z>      :undo<cr>
:inoremap <silent> <C-z>      <esc>:undo<cr>a
" 重做
:nnoremap <silent> <A-z>      :redo<cr>
:inoremap <silent> <A-z>      <esc>:redo<cr>a
" 普通模式删除行
:nnoremap <silent> <C-y>      :call DeleteRow()<cr>
" 编辑模式删除行，并吧光标移动到行尾
:inoremap <silent> <C-y>      <esc>:call DeleteRow()<cr>a
" 粘贴
:nnoremap          <C-p>      <esc>"+pa
:inoremap          <C-p>      <esc>"+pa
:tnoremap          <C-p>      <C-\><C-n>"+pa
" 复制行，yy是复制，p是在新的一行粘贴
:nnoremap <silent> <C-d>      :call CopyRow()<cr>
:inoremap <silent> <C-d>      <esc>:call CopyRow()<cr>a
" 复制选中文本到系统剪切板
:vnoremap          <C-c>      "+y
" 剪切选中文本到系统剪切板
:vnoremap          <C-x>      "+d

" 上移一整行
:nnoremap <silent> <C-Up>     :m -2<cr>
:inoremap <silent> <C-Up>     <esc>:m -2<cr>A
" 下移一整行
:nnoremap <silent> <C-Down>   :m +1<cr>
:inoremap <silent> <C-Down>   <esc>:m +1<cr>A

" 根据文件类型格式化文件
:nnoremap <silent> <C-f>      :call FileFormat()<cr>
:inoremap <silent> <C-f>      <esc>:call FileFormat()<cr>a
" 翻译单词
:inoremap <silent> <C-t><C-s> <esc>:TranslateW<cr>A
:nnoremap <silent> <C-t><C-s> <esc>:TranslateW<cr>
:vnoremap <silent> <C-t><C-s> :TranslateW<cr>
" 移动光标到第一个非空格字符
:nnoremap          <Home>     ^
:inoremap          <Home>     <esc>^i
" 全选
:nnoremap          <C-a>      gg^vG$
:inoremap          <C-a>      <esc>gg^vG$
" 打开/关闭终端
:nnoremap <silent> <C-t><C-e> :ToggleTerm<cr>
:inoremap <silent> <C-t><C-e> <esc>:ToggleTerm<cr>
:tnoremap <silent> <C-t><C-e> <C-\><C-n>:ToggleTerm<cr>
" 退出终端模式
:tnoremap          <esc>      <C-\><C-n>

" barbar.nvim 快捷键配置
" 向左或向右切换标签页
:nnoremap <silent> <A-Left>   :BufferPrevious<cr>
:inoremap <silent> <A-Left>   <esc>:BufferPrevious<cr>
:tnoremap <silent> <A-Left>   <C-\><C-n>:BufferPrevious<cr>
:nnoremap <silent> <A-Right>  :BufferNext<cr>
:inoremap <silent> <A-Right>  <esc>:BufferNext<cr>
:tnoremap <silent> <A-Right>  <C-\><C-n>:BufferNext<cr>
" 切换到指定标签页
:nnoremap <silent> <A-1>      :BufferGoto 1<CR>
:inoremap <silent> <A-1>      :BufferGoto 1<CR>
:nnoremap <silent> <A-2>      :BufferGoto 2<CR>
:inoremap <silent> <A-2>      :BufferGoto 2<CR>
:nnoremap <silent> <A-3>      :BufferGoto 3<CR>
:inoremap <silent> <A-3>      :BufferGoto 3<CR>
:nnoremap <silent> <A-4>      :BufferGoto 4<CR>
:inoremap <silent> <A-4>      :BufferGoto 4<CR>
:nnoremap <silent> <A-5>      :BufferGoto 5<CR>
:inoremap <silent> <A-5>      :BufferGoto 5<CR>
:nnoremap <silent> <A-6>      :BufferGoto 6<CR>
:inoremap <silent> <A-6>      :BufferGoto 6<CR>
:nnoremap <silent> <A-7>      :BufferGoto 7<CR>
:inoremap <silent> <A-7>      :BufferGoto 7<CR>
:nnoremap <silent> <A-8>      :BufferGoto 8<CR>
:inoremap <silent> <A-8>      :BufferGoto 8<CR>
:nnoremap <silent> <A-9>      :BufferLast<CR>
:inoremap <silent> <A-9>      :BufferLast<CR>
" 保存文件、关闭缓冲区并关闭标签页
:nnoremap <silent> <A-c>      :call CloseTab()<cr>
:inoremap <silent> <A-c>      <esc>:call CloseTab()<cr>
" 置项标签页
:nnoremap <silent> <A-p>      :BufferPin<cr>
:inoremap <silent> <A-p>      <esc>:BufferPin<cr>
