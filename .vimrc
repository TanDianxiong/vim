set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
"  " required! 
Bundle 'gmarik/vundle'

Bundle 'https://github.com/scrooloose/nerdtree.git'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'Lokaltog/vim-powerline'
Bundle 'Lokaltog/powerline-fonts'

"Bundle 'AutoComplPop'
Bundle 'ctags.vim'
Bundle 'DoxygenToolkit.vim'
Bundle 'JSON.vim'
Bundle 'Markdown'
Bundle 'nerdtree'
Bundle 'pydoc.vim'
Bundle 'pyflakes.vim'
Bundle 'python.vim'
Bundle 'surround.vim'
Bundle 'Tagbar'
Bundle 'UltiSnips'
Bundle 'vim-indent-guides'
Bundle 'xml.vim'

filetype plugin indent on     " required!

"设置编码
set encoding=utf-8
"显示行号
set nu 
"set cursorline "高亮显示光标所在行
"set cursorcolumn"高亮显示光标所在行

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
""set guifont=Bitstream_Vera_Sans_Mono:h9:cANSI "记住空格用下划线代替哦
""set gfw=幼圆:h10:cGB2312
set bg=dark
colorscheme desert

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
"set vb t_vb=

"set nowrap "不自动换行
set hlsearch "高亮显示结果
set incsearch "在输入要搜索的文字时，vim会实时匹配
set backspace=indent,eol,start whichwrap+=<,>,[,] "允许退格键的使用

"tagbar面向对象的taglist
map tb :TagbarToggle<CR> 

"对NERD_commenter的设置
"代码注释的插件
let mapleader = ","
let NERDShutUp=1

"代码折叠
set foldmethod=indent "折叠方式
set foldnestmax=10 "最大折叠层级 
set nofoldenable "默认不折叠 
set foldlevel=1
"highlight Folded guibg=grey guifg=blue
"highlight FoldColumn guibg=darkgrey guifg=white

"文件浏览的配置
"let g:winManagerWindowLayout='FileExplorer|TagList'
"nmap wm :WMToggle<cr>

"文件浏览器NERD_tree配置
"map <C-n> :NERDTreeToggle<CR>
map ne :NERDTreeToggle<CR>
" loaded_nerd_tree 不使用NerdTree脚本"
let NERDChristmasTree=0 "让Tree把自己给装饰得多姿多彩漂亮点
let NERDTreeAutoCenter=0 "控制当光标移动超过一定距离时，是否自动将焦点调整到屏中心
let NERDTreeAutoCenterThreshold=8 "与NERDTreeAutoCenter配合使用
" NERDTreeCaseSensitiveSort 排序时是否大小写敏感
let NERDTreeChDirMode=2 "确定是否改变Vim的CWD
let NERDTreeHighlightCursorline=1 "是否高亮显示光标所在行
" NERDTreeHijackNetrw 是否使用:edit命令时打开第二NerdTree
" NERDTreeIgnore 默认的“无视”文
" NERDTreeBookmarksFile 指定书签文件
" NERDTreeMouseMode 指定鼠标模式（1.双击打开；2.单目录双文件；3.单击打开）
" NERDTreeQuitOnOpen 打开文件后是否关闭NerdTree窗口
" NERDTreeShowBookmarks 是否默认显示书签列表
" NERDTreeShowFiles 是否默认显示文件
let NERDTreeShowHidden=0 "是否默认显示隐藏文件
let NERDTreeShowLineNumbers=0 "是否默认显示行号
" NERDTreeSortOrder 排序规则
" NERDTreeStatusline 窗口状态栏
" NERDTreeWinPos 窗口位置（'left' or 'right'）
" NERDTreeWinSize 窗口宽
let NERDTreeShowFiles=1
let NERDTreeWinPos='left'
"let NERDTreeWinSize=38
" autocmd VimEnter * NERDTree
" 启动Vim时自动打开nerdtree
let NERDTreeShowBookmarks=1
"一直显示书签
let NERDTreeChDirMode=2
"打开书签时，自动将Vim的pwd设为打开的目录，如果你的项目有tags文件，你会发现这个命令很有帮助

"使用cscope
:set cscopequickfix=s-,c-,d-,i-,t-,e-

"noremap <C-J>     <C-W>j
"noremap <C-K>     <C-W>k
"noremap <C-H>     <C-W>h
"noremap <C-L>     <C-W>l

"minibuffer
noremap <C-L>   :MBEbn<CR>
noremap <C-H> :MBEbp<CR>

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
" 在搜索的时候忽略大小写 
set ignorecase 

"Doxygen风格注释
"let g:DoxygenToolkit_commentType = "PHP"
let g:DoxygenToolkit_briefTag_pre="@Synopsis  " 
let g:DoxygenToolkit_paramTag_pre="@Param " 
let g:DoxygenToolkit_returnTag="@Returns   " 
let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------" 
let g:DoxygenToolkit_blockFooter="----------------------------------------------------------------------------" 
let g:DoxygenToolkit_authorName="chenxiaonan" 
let g:DoxygenToolkit_licenseTag="seanchen"  

"indent guides 函数对齐线
let g:indent_guides_guide_size=1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3 
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4 
"python语法检查
if has("gui_running") 
    highlight SpellBad term=underline gui=undercurl guisp=Green
endif 

"align 配置
"set nocp 
"filetype plugin on 

"---------------------------------------------------------------
" csupport
"---------------------------------------------------------------
let g:C_GlobalTemplateFile=$HOME."/.vim/c-support/templates/Templates"
let g:C_LocalTemplateFile=$HOME."/.vim/c-support/templates/Templates"
let g:C_CodeSnippets=$HOME."/.vim/c-support/codesnippets"
"let g:C_Styles = {'*.c,*.h' : 'default', '*.cc,*.cpp,*.hh' : 'CPP'}
let g:C_Styles = { '.c,.h' : 'C', '.cc,.cpp,.c++,.C,.hh,.h++,*.H' : 'CPP'  }

"ctrlp.vim cofig
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
"let g:ctrlp_custom_ignore = { 'dir':  '\v[\/]\.(git|hg|svn)$','file': '\v\.(exe|so|dll)$', 'link': 'some_bad_symbolic_links' }
"let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux

"powerline
let g:Powerline_symbols = 'fancy'
set nocompatible
set laststatus=2   " Always show the statusline"
set t_Co=256
let g:Powerline_symbols_override = {
            \ 'BRANCH': [0x2213],
            \ 'LINE': 'L',
            \ }
let g:Powerline_mode_n = 'NORMAL'
let g:Powerline_stl_path_style = 'full'
"let g:Powerline_cache_file='~/.vim/bundle/powerline/Powerline.cache'
