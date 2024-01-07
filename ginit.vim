" Set font
:GuiFont JetBrainsMono Nerd Font Mono:h12
" popup
:GuiPopupmenu v:false
" Siamese
:GuiRenderLigatures v:false
:GuiScrollBar v:false
:GuiTabline v:false
" The filename is used as the window title.
:set title
" 让 Neovim-qt 接管“*”和“+”寄存器，在通过 neovim-qt 远程连接 Neovim RPC 时可以使用 Neovim-qt 所在主机的剪切板
:call GuiClipboard()
