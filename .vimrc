if(has("win32") || has("win95") || has("win64") || has("win16")) "判定当前操作系统类型
    let g:iswindows=1
else
    let g:iswindows=0
endif
set nocompatible "不要vim模仿vi模式，建议设置，否则会有很多不兼容的问题
" Leader Code
let mapleader=" "
syntax on"打开高亮
if has("autocmd")
	filetype plugin indent on "根据文件进行缩进, 这个要斟酌使用，拷贝时候可能会自动缩进出问题，需要暂时注释掉
    augroup vimrcEx
        au!
        autocmd FileType text setlocal textwidth=78
        autocmd BufReadPost *
                    \ if line("'\"") > 1 && line("'\"") <= line("$") | "实现打开同一文件时，vim能够自动记住上一次的位置
                    \ exe "normal! g`\"" |
                    \ endif
    augroup END
else
    set autoindent " always set autoindenting on "智能缩进，相应的有cindent，官方说autoindent可以支持各种文件的缩进，但是效果会比只支持C/C++的cindent效果会差一点， 但笔者并没有看出来
endif " has("autocmd")
set tabstop=4 "让一个tab等于4个空格
set vb t_vb=
set nowrap "不自动换行
set hlsearch "高亮显示结果
set incsearch "在输入要搜索的文字时，vim会实时匹配
set backspace=indent,eol,start whichwrap+=<,>,[,] "允许退格键的使用
if(g:iswindows==1) "允许鼠标的使用
    "防止linux终端下无法拷贝
    if has('mouse')
        set mouse=a
    endif
    au GUIEnter * simalt ~x
endif
"字体的设置
set guifont=Bitstream_Vera_Sans_Mono:h9:cANSI "记住空格用下划线代替哦
set gfw=幼圆:h10:cGB2312
set ic"ingorecase

" vimconf的内容
" ctags
"map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" omnicppcomplete
set nocp  
filetype plugin on
"....=============================>>>>>>>>  为了拷贝=======>>>>
" :set fo-=r   "这个这里没作用，需要自己:set fo-=r 是无需要自动注释的意思，免得拷贝时候出问题
" set noautoindent
"====================<<<<<<<<<<<<<<<<<<<<<=======================


" yi_mo help.  start
"vimgrep ... Note:uses % to limit the search to the current file only
nmap <C-f> :exec 'vimgrep /' . input('/', expand('<cword>')) . '/j %' <Bar>cw<CR> 

"taglist
nnoremap <silent> <F4> :TlistToggle<CR>
let Tlist_Exit_OnlyWindow = 1 
let Tlist_File_Fold_Auto_Close = 1 
let Tlist_GainFocus_On_ToggleOpen = 1 
let Tlist_Process_File_Always = 1 
let Tlist_Show_One_File = 1 
let Tlist_Show_Menu = 1 
let Tlist_Use_Right_Window = 1 

"NERDTree
nnoremap <silent> <F3> :NERDTreeToggle<CR>
"nnoremap <silent>  <F2>:NERDTreeFind<CR>
let NERDTreeQuitOnOpen = 0 
let NERDTreeShowLineNumbers = 1 
let NERDTreeCWD = 1 
let NERDTreeMapOpenVSplit = 0 
" yi_mo help. End


"==========================================================================
""BufExplore setting，设置bufexplorer插件的选项，进行定制
"==========================================================================
let g:BufExplorerShowRelativePath=1   " Show relative paths.
let g:BufExplorerSplitRight=0         " Split left
let g:BufExplorerSplitVertical=1      " Split vertically
let g:bufExplorerSplitVertSize = 30   " Split width
let g:bufExplorerUseCurrentWindow=1   " Open in new window.
autocmd BufWinEnter \[Buf\ List\] setl nonumber
let g:BufExplorerSplitBelow=0
let g:bufExplorerDefaultHelp=0   " Do not show default help.
let g:bufExplorerSortBy='mru'    " Sort by most recently used.


noremap <silent> <Leader>be :BufExplorer<CR>
noremap <silent> <Leader>bs :BufExplorerHorizontalSplit<CR>
noremap <silent> <Leader>bv :BufExplorerVerticalSplit<CR>
" For chinese show..
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

"==============================================================================
"csope settings，设置cscope的参数内容，实现启动自动添加数据库
"==============================================================================
if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=0
    set cst
    set csverb
    set cspc=3
    "add any database in current dir
    if filereadable("cscope.out")
        cs add cscope.out
    "else search cscope.out elsewhere
    else
       let cscope_file=findfile("cscope.out", ".;")
       let cscope_pre=matchstr(cscope_file, ".*/")
       if !empty(cscope_file) && filereadable(cscope_file)
           exe "cs add" cscope_file cscope_pre
       endif      
     endif
endif
"nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
"nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
"nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
""nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>  // conflict with ctags
"nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
"nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
"nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" Use <Leader> to map. jayden@20150909
" s: 查找指定标示符的使用位置
nmap <silent> <Leader>,s :cs find s <C-R>=expand("<cword>")<CR><CR>
" g: 查找指定标示符的定义位置，此时用tag会好一点
nmap <silent> <Leader>,g :cs find g <C-R>=expand("<cword>")<CR><CR>
" c: 查找有那些函数调用了指定的函数!!!!!! Like SourceInsight
nmap <silent> <Leader>,c :cs find c <C-R>=expand("<cword>")<CR><CR>
" t: 查找指定的文本字符串，会全局搜索所有包含此字符串的匹配，所以会比较慢 
" cs find t will cost lot of time.
nmap <silent> <Leader>,t :cs find t <C-R>=expand("<cword>")<CR><CR>
" e: 查找指定的正则表达式，此时不宜用键盘映射
nmap <silent> <Leader>,e :cs find e <C-R>=expand("<cword>")<CR><CR>
" f: 查找指定的文件
nmap <silent> <Leader>,f :cs find f <C-R>=expand("<cfile>")<CR><CR>
" i: 查找指定文件被哪些文件包含
nmap <silent> <Leader>,i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
" d: 查找指定函数调用了哪些函数
nmap <silent> <Leader>,d :cs find d <C-R>=expand("<cword>")<CR><CR>

"===================================================================
" lookupfile setting
"===================================================================
 let g:LookupFile_MinPatLength = 4               "最少输入2个字符才开始查找
 let g:LookupFile_PreserveLastPattern = 0        "不保存上次查找的字符串
 let g:LookupFile_PreservePatternHistory = 1     "保存查找历史
 let g:LookupFile_AlwaysAcceptFirst = 1          "回车打开第一个匹配项目
 let g:LookupFile_AllowNewFiles = 0              "不允许创建不存在的文件

"if filereadable("/84T/filenametags")
"	 let g:LookupFile_TagExpr = '"/84T/filenametags"'
"endif

if filereadable("/hi/filenametags")
	 let g:LookupFile_TagExpr = '"/hi/filenametags"'
endif

"au BufEnter /82/*
au BufEnter /hi/*
 
 nmap <silent> <Leader>lf <Plug>LookupFile<CR>
 nnoremap <silent> <Leader>lb :LUBufs<CR>
 nnoremap <silent> <Leader>lw :LUWalk<CR>
 nnoremap <silent> <Leader>lt :LUTags<CR>

 "======================================
 "quickfix setting
 "======================================
 noremap <silent> <Leader>cn :cn<CR>
 noremap <silent> <Leader>cp :cp<CR>
 noremap <silent> <Leader>cw :cw<CR>
 noremap <silent> <Leader>cc :cc<CR>
 noremap <silent> <Leader>co :copen<CR>
 noremap <silent> <Leader>ce :cclose<CR>
  
 "======================================
 "project manager
 "======================================
 "noremap <silent> <Leader>pj :!~/opt/scripts/project<CR>
 "if filereadable("./cscope.files")
	"silent exec '!ls'
	"exec '!project'
"	silent exec '!~/opt/scripts/project'

" endif



"###############==========>>Vendule##############===========>>>>>>
" Vendule################========================################
" <<<<<<<<<<<<<<<<<<<<<<<=========================================
"set nocompatible              " be iMproved, required   ### zhoujun #end.
"filetype off                  " required   ### zhoujun comment

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" ==========================>>>>>>>>>>>>>>> YCM
"Bundle 'Valloric/YouCompleteMe'

set fileformats=unix,dos
set ts=4
set expandtab

" Set /.vimbookmark auto save. 20150917-Jayden
let g:vbookmark_bookmarkSaveFile = $HOME . '/.vimbookmark'

" Use for copy and replace
