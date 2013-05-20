"设置编码
set encoding=utf-8
"显示行号
set nu 

if(has("win32") || has("win95") || has("win64") || has("win16")) "判定当前操作系统类型
    let g:iswindows=1
else
    let g:iswindows=0
endif
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

set nocompatible "不要vim模仿vi模式，建议设置，否则会有很多不兼容的问题
syntax on"打开高亮
if has("autocmd")
    filetype plugin indent on "根据文件进行缩进
    augroup vimrcEx
        au!
        autocmd FileType text setlocal textwidth=78
        autocmd BufReadPost *
                    \ if line("'\"") > 1 && line("'\"") <= line("$") |
                    \ exe "normal! g`\"" |
                    \ endif
    augroup END
else
    "智能缩进，相应的有cindent，官方说autoindent可以支持各种文件的缩进，但是效果会比只支持C/C++的cindent效果会差一点，但笔者并没有看出来
    set autoindent " always set autoindenting on 
endif " has("autocmd")

"让一个tab等于4个空格
set tabstop=4
set softtabstop=4

"设置默认缩进宽度为4
set shiftwidth=4

"输入的tab自动转化为4个空格
set expandtab

"强制已有的tab转化为4个空格
retab!
"去掉vim错误时的发声
set vb t_vb=

set nowrap "不自动换行
set hlsearch "高亮显示结果
set incsearch "在输入要搜索的文字时，vim会实时匹配
set backspace=indent,eol,start whichwrap+=<,>,[,] "允许退格键的使用



map <F12> :call Do_CsTag()<CR>
nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>:copen<CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:copen<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>:copen<CR>
function Do_CsTag()
    let dir = getcwd()
    if filereadable("tags")
        if(g:iswindows==1)
            let tagsdeleted=delete(dir."\\"."tags")
        else
            let tagsdeleted=delete("./"."tags")
        endif
        if(tagsdeleted!=0)
            echohl WarningMsg | echo "Fail to do tags! I cannot delete the tags" | echohl None
            return
        endif
    endif
    if has("cscope")
        silent! execute "cs kill -1"
    endif
    if filereadable("cscope.files")
        if(g:iswindows==1)
            let csfilesdeleted=delete(dir."\\"."cscope.files")
        else
            let csfilesdeleted=delete("./"."cscope.files")
        endif
        if(csfilesdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.files" | echohl None
            return
        endif
    endif
    if filereadable("cscope.out")
        if(g:iswindows==1)
            let csoutdeleted=delete(dir."\\"."cscope.out")
        else
            let csoutdeleted=delete("./"."cscope.out")
        endif
        if(csoutdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.out" | echohl None
            return
        endif
    endif
    if(executable('ctags'))
        "silent! execute "!ctags -R --c-types=+p --fields=+S *"
        silent! execute "!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ."
    endif
    if(executable('cscope') && has("cscope") )
        if(g:iswindows!=1)
            silent! execute "!find . -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' > cscope.files"
        else
            silent! execute "!dir /s/b *.c,*.cpp,*.h,*.java,*.cs >> cscope.files"
        endif
        silent! execute "!cscope -b"
        execute "normal :"
        if filereadable("cscope.out")
            execute "cs add cscope.out"
        endif
    endif
endfunction

"进行Tlist的设置
"TlistUpdate可以更新tags
map <F3> :silent! Tlist<CR> "按下F3就可以呼出了
let Tlist_Ctags_Cmd='ctags' "因为我们放在环境变量里，所以可以直接执行
let Tlist_Use_Right_Window=1 "让窗口显示在右边，0的话就是显示在左边
let Tlist_Show_One_File=0 "让taglist可以同时展示多个文件的函数列表，如果想只有1个，设置为1
let Tlist_File_Fold_Auto_Close=1 "非当前文件，函数列表折叠隐藏
let Tlist_Exit_OnlyWindow=1 "当taglist是最后一个分割窗口时，自动推出vim
let Tlist_Process_File_Always=0 "是否一直处理tags.1:处理;0:不处理。不是一直实时更新tags，因为没有必要
let Tlist_Inc_Winwidth=0

"tagbar面向对象的taglist
map <F4> :TagbarToggle<CR> 

"对NERD_commenter的设置
"代码注释的插件
let mapleader = ","
let NERDShutUp=1

"文件浏览的配置
"let g:winManagerWindowLayout='FileExplorer|TagList'
nmap wm :WMToggle<cr>

"文件浏览器NERD_tree配置
map <C-n> :NERDTreeToggle<CR>
" loaded_nerd_tree 不使用NerdTree脚本"
let NERDChristmasTree=0 "让Tree把自己给装饰得多姿多彩漂亮点
let NERDTreeAutoCenter=0 "控制当光标移动超过一定距离时，是否自动将焦点调整到屏中心
let NERDTreeAutoCenterThreshold=8 "与NERDTreeAutoCenter配合使用
" NERDTreeCaseSensitiveSort 排序时是否大小写敏感
let NERDTreeChDirMode=2 "确定是否改变Vim的CWD
" NERDTreeHighlightCursorline 是否高亮显示光标所在行
" NERDTreeHijackNetrw 是否使用:edit命令时打开第二NerdTree
" NERDTreeIgnore 默认的“无视”文
" NERDTreeBookmarksFile 指定书签文件
" NERDTreeMouseMode 指定鼠标模式（1.双击打开；2.单目录双文件；3.单击打开）
" NERDTreeQuitOnOpen 打开文件后是否关闭NerdTree窗口
" NERDTreeShowBookmarks 是否默认显示书签列表
" NERDTreeShowFiles 是否默认显示文件
let NERDTreeShowHidden=1 "是否默认显示隐藏文件
let NERDTreeShowLineNumbers=1 "是否默认显示行号
" NERDTreeSortOrder 排序规则
" NERDTreeStatusline 窗口状态栏
" NERDTreeWinPos 窗口位置（'left' or 'right'）
" NERDTreeWinSize 窗口宽
let NERDTreeShowFiles=1
let NERDTreeWinPos='left'
let NERDTreeWinSize=38
" autocmd VimEnter * NERDTree
" 启动Vim时自动打开nerdtree
let NERDTreeShowBookmarks=1
"一直显示书签
let NERDTreeChDirMode=2
"打开书签时，自动将Vim的pwd设为打开的目录，如果你的项目有tags文件，你会发现这个命令很有帮助

"使用cscope
:set cscopequickfix=s-,c-,d-,i-,t-,e-

"使tab菜单文件在当前窗口打开
let g:miniBufExplMapCTabSwitchBufs = 1
"可以用<C-h,j,k,l>切换到上下左右的窗口中去
"let g:miniBufExplMapWindowNavVim = 1
"用<C-箭头键>切换到上下左右窗口中去
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplModSelTarget = 1 

"代码自动补全
filetype plugin indent on
set completeopt=longest,menu

"php函数自动补全
au FileType php call AddPHPFuncList()
function AddPHPFuncList()
		set dictionary-=~/.vim/doc/php_funclist.txt dictionary+=~/.vim/doc/php_funclist.txt
		set complete-=k complete+=k
endfunction

" 不让vim发出讨厌的滴滴声 
set noerrorbells 

" 在被分割的窗口间显示空白，便于阅读 
set fillchars=vert:\ ,stl:\ ,stlnc:\ 

" 在搜索的时候忽略大小写 
set ignorecase 

"git命令自动补全
"source ~/.vim/doc/git-completion.bash

