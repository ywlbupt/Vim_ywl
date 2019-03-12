" version : 1.0
" Author : WiZero(<ywlbupt@163.com>)
" LastUpdate : 2016-09-17 13:56:35
" Description : vimrc

"  Install Dependency"{{{
""""""""""""""""
" # ubuntu
" sudo apt-get install ctags
" sudo apt-get install build-essential cmake python-dev
" #编译YCM自动补全插件依赖
" sudo apt-get install silversearcher-ag
" # python # For syntastic
" sudo pip install pyflakes
" sudo pip install pylint
" sudo pip install pep8
"}}}

" Set mapleader & Fast edit vimrc
let   mapleader = ","
let g:mapleader = ","

if !exists('g:plugin_function_groups')
    " optional :
    " "syntastic", "hexo" , "YouCompleteMe" , "ale", "airline",
    " "tagbar" , "LeaderF"
    let g:plugin_function_groups = ['hexo', "YouCompleteMe", "airline" ,"ale", "LeaderF"]
endif

" Load Plugin and Customed_Func "{{{
if filereadable(expand(g:ywl_path.'/vimrc.bundles'))
    exec 'source '.g:ywl_path.'/vimrc.bundles'
else
    echo 'No vimrc.bundles found'
endif

if filereadable(expand(g:ywl_path.'/vimrc.func'))
    exec 'source '.g:ywl_path.'/vimrc.func'
else 
    echo 'No vimrc.func found'
endif
"  matchit.vim插件扩展了%匹配字符的范围,根据不同的filetype来做不同的匹配
    source $VIMRUNTIME/macros/matchit.vim
"}}}

set history =1000

" Base Setting "{{{

" Basic{{{
    set hidden " 允许在有未保存的修改时切换缓冲区，此时的修改由 vim 负责保存
    
    " vim命令行补全增强，显示所有匹配的命令或文件名。
    " set wildmode=list:longest
    " Ignore compiled files
        
    " 增强模式中的命令行自动完成操作
    set wildmenu 
    set completeopt=longest,menu
    " wildmenu" 激活时，下面的键有特殊含义:
    " <Left> <Right> - 选择前项/后项匹配 (类似于 CTRL-P/CTRL-N)
    " <Down> - 文件名/菜单名补全中: 移进子目录和子菜单。
    " <CR> - 菜单补全中，如果光标在句号之后: 移进子菜单。
    " <Up> - 文件名/菜单名补全中: 上移到父目录或父菜单。
    
    set showcmd     " Show (partial) command in status line."
    set cmdheight=1 " 设定命令行的行数为 1

" 搜索相关
    set hlsearch "搜索高亮匹配的文本"
    set ignorecase smartcase
    "   搜索时忽略大小写，但在有一个或以上大写字母时仍保持对大小写敏感
    set nowrapscan " 禁止在搜索到文件两端时重新搜索
    set incsearch " 输入搜索内容时就显示搜索结果
    " 取消搜索高亮"
    exec "noh" 
    set magic " 设置魔术，搜索设置
    
    " 设置宽度不明的文字(如 “”①②→ )为双宽度文本
    set ambiwidth=double
" Set to auto read when a file is changed from the outside
    set autoread
    set number " 显示行号
    " set relativenumber " 显示相对行号
    set ruler " 打开状态栏标尺

    set nobackup " 覆盖文件时不备份
    "let &autochdir=0
    set autochdir " 自动切换当前目录为当前文件所在的目录

    if has("autocmd")
        "windows下，对包含空格的路径会有问题，修改如下：
        autocmd! BufEnter * silent! lcd %:p:h:gs/ /\\ /
        "开/tmp文件夹下的文件时不自动切换，则设置如下：
        "autocmd! BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif
    endif

    set backupcopy=yes " 设置备份时的行为为覆盖
    set noerrorbells " 关闭错误信息响铃
    set novisualbell " 关闭使用可视响铃代替呼叫
    " 置空错误铃声的终端代码,set silent (no beep)
    set vb t_vb=

    " set showmatch " 插入括号时，短暂地跳转到匹配的对应括号
    " set matchtime=2 " 短暂跳转到匹配括号的时间

    
    set laststatus=2 " 显示状态栏 (默认值为 1, 无法显示状态栏)
    "   我的状态栏显示的内容
    set statusline=%F%m%r%h%w\[POS=%l,%v][%p%%]\%{
                \strftime(\"%d/%m/%y\ -\ %H:%M\")}
    " 从左到右分别是: 相对路径, 光标处字符 Unicode 编码, 系统, 文件编码, " 文件类型, tab长度, 行/列, 光标位置, 视窗位置
    " set statusline=%h%w%r\ %f\ %m%=\ %B\ \|\ %{&ff}\ \|\ %{&fenc!=''?&fenc:&enc}\ \|\ %{&ft!=''?&ft:'none'}\ \|\ %{&tabstop}\ %8(%l,%v%)\ %10(%p%%,%P%)
    
    "带有如下符号的单词不要被换行分割
    set iskeyword+=_,$,@,%,#,-
    " 在gui环境下altkey快捷键的
    if MySys()=='windows'
        set winaltkeys=no
    endif
" 提示自己代码别超过81列"}}}

" Fold setting "{{{
   
    function! MyFoldText()
      let a:line=getline(v:foldstart)
      let a:foldcms_1=substitute(&commentstring,'%s',get(split(&foldmarker,','),0),"")
      " if matchstr(a:line,'^\s*'.a:foldcms_1)!=""
      if '^\s*'.a:foldcms_1=~a:line
      "if a:line==a:foldcms_1
          let a:line=getline(v:foldstart+1)
      endif
      let sub=substitute(a:line, a:foldcms_1, '', 'g')
      return v:folddashes.sub
    endfunction

    function! MyFoldExpr_Markdown(lnum)
        return getline(a:lnum+1)=~'^##'?0:1
    endfunction 

    function! MyFoldText_Markdown()
        let a:line_1=getline(v:foldstart)
        let a:line_2=getline(v:foldstart+1)
        return v:folddashes.a:line_1." : ".a:line_2
        "return sub
    endfunction
    set foldopen-=undo  "dont open folds when i search into thm or undo thm
    set foldopen-=search
    set foldenable " 开始折叠
    "set foldlevel=9999 "相当于默认不折叠
    "set foldmethod=syntax " 设置语法折叠
    set foldmethod=marker
    set foldcolumn=3 " 设置折叠区域的宽度
    set foldtext=MyFoldText()
    
    " 用空格键来开关折叠
    nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
"}}}

"{{{
" view,buffer Operation
    " if MySys() == 'linux'
        " set viewdir=$HOME/Dropbox/vimfiles/view
    " elseif MySys() == 'windows'
        " set viewdir=$HOME/vimfiles/view
    " endif
" 谨慎使用，防止修改了全局映射变量在里面没有体现
    set viewoptions=cursor,folds,slash,unix
    " ,options
" au BufWinLeave * if expand("%") != '' && &buftype=='' | silent
"               \mkview! | endif
"   au BufWinEnter * if expand("%") != '' && &buftype=='' | silent
"               \loadview |syntax on| endif

"   function! RemoveOldViewFiles()
"   if MySys() == 'windows'
"       exe '!find '.g:ywl_path.'/vimfiles/view/* -mtime +90 -exec rm {} \;'
"   else if MySys() == 'linux'
"       exe '!find '.g:ywl_path.'/vimfiles/view/* -mtime +90 -exec rm {} \;'
"   endfunction

"------------------------view--------------------------------
"}}}

" undodir 持久保存撤销历史"{{{
" Remove this, use gundo
    " exec 'set undodir='.g:ywl_path.'/vimfiles/undodirfile'
    " set undolevels=1000 "maximum number of changes that can be undone
    " set undofile
"}}}
"}}}

"{{{
" gui_running 此行需要在syntax on 之前配置
    highlight WhitespaceEOL ctermbg=red guibg=red
    match WhitespaceEOL /\s\+$/
    highlight WhitespaceHOL ctermbg=red guibg=red
    match WhitespaceHOL /^\s\+/
    set cursorline " 突出显示当前行
    " set cursorcolumn "突出当前列

    syntax enable
    " 使用鼠标操作
    " set mouse=a
    set mouse=cvn

    if has("gui_running")
        set guioptions-=T " 隐藏工具栏
        set guioptions-=m " 隐藏菜单栏
        set guioptions-=L
        " set guioptions-=r
        set background=dark
        colorscheme solarized
        " colorscheme desert_ywl  "设定配色方案
        autocmd GUIEnter * set lines=40 |  set columns=149 
        if MySys() == 'linux'
            "exec "winpos 400 70"
        endif
    else
        set background=dark
        set t_Co=16
        colorscheme solarized
        " if &term =~ "xterm"
            " set t_Co=16
            " set t_Sb=^[[4%dm " 设置背景色
            " set t_Sf=^[[3%dm " 设置前景色
        autocmd VimEnter * set lines=40 | set columns=149
        " endif 
    endif

    " 防止tmux下vim的背景色显示异常
    " Refer: http://sunaku.github.io/vim-256color-bce.html
    if &term =~ '256color'
        " disable Background Color Erase (BCE) so that color schemes
        " render properly when inside 256-color tmux and GNU screen.
        " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
        set t_ut=
    endif 

"}}}

" 开启语法高亮
syntax on

""""""""""""""""""""
"  filtetype open  "
""""""""""""""""""""
" 检测文件类型
filetype on
" 针对不同的文件类型采用不同的缩进格式
filetype indent on
" 允许插件
filetype plugin on
" 启动自动补全
filetype plugin indent on

" For windows version, using gVIM with Cygwin on a Windows PC"{{{
if MySys() == 'windows'
    " source $VIMRUNTIME/mswin.vim
    " behave mswin
    " unmap <C-A>
    set diffexpr=MyDiff()
    function! MyDiff()
        let opt = '-a --binary '
        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
        if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
        let eq = ''
        if $VIMRUNTIME =~ ' '
            if &sh =~ '/<cmd'
                let cmd = '""' . $VIMRUNTIME . '/diff"'
                let eq = '"'
            else
                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '/diff"'
            endif
        else
            let cmd = $VIMRUNTIME . '/diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
endif
"}}}

" Fast edit vimrc & font coding Setting "{{{

" Fast edit vimrc
    if MySys() == 'linux'
    "   Fast reloading of the .vimrc
        map <silent> <leader>ss :exec 'source '.g:ywl_path.'/_vimrc'<cr>
        map <silent> <leader>rr :source ~/.vimrc<cr>
    "   Fast editing of .vimrc
        map <silent> <leader>ee :exec 'edit '.g:ywl_path.'/_vimrc'<cr>
        map <silent> <leader>er :e ~/.vimrc<cr>
        map <silent> <leader>eb :exec 'edit '.g:ywl_path.'/vimrc.bundles'<cr>
    "   When .vimrc is edited, reload it 每次保存syntax总不太对头
        " autocmd! bufwritepost _vimrc exec 'source ~/.vimrc'
        " autocmd! bufwritepost .vimrc exec 'source ~/.vimrc'
    elseif MySys() == 'windows'
    "   Fast reloading of the _vimrc
        map <silent> <leader>ss :exec 'source '.g:ywl_path.'\_vimrc'<cr>
        map <silent> <leader>rr :source $VIM\_vimrc<cr>
    "   Fast editing of _vimrc
        map <silent> <leader>ee :exec 'edit '.g:ywl_path.'\_vimrc'<cr>
        map <silent> <leader>er :e $VIM\_vimrc<cr>
        map <silent> <leader>eb :exec 'edit '.g:ywl_path.'\vimrc.bundles'<cr>
    "   When _vimrc is edited, reload it
        " autocmd! bufwritepost _vimrc exec 'source $VIM\_vimrc'
    endif
"}}}
 
" Reformate 排版与文本格式"{{{
" 文本格式化
    " B在连接行时，不要在两个多字节字符之间插入空格。有'M' 标志位时无效。
    set formatoptions+=B
        
    set expandtab
    set shiftwidth=4 " 设定 << 和 >> 命令移动时的宽度为 4
    set softtabstop=4 " 使得按退格键时可以一次删掉 4 个空格
    set tabstop=4 " 设定 tab 长度为 4
    " 缩进时，取整 use multiple of shiftwidth when indenting with '<' and '>'
    set shiftround

    set wrap "文本的回绕，不超过窗口宽度

    auto FileType c,cpp  set cindent " Strict rules for C Programs
    "auto FileType c,cpp  set smartindent " Strict rules for C Programs
    set autoindent
    set backspace=indent,eol,start

    if has("autocmd")
    endif
"}}}

" Text Encoding "{{{

    set fileformats=unix,dos
    " 缩略 set ffs = unix,dos
    set fileformat =unix
    
    if MySys() == "windows"
        set langmenu=zh_CN.UTF-8
        language message zh_CN.UTF-8
        set encoding=utf-8
        set termencoding =GBK
        set fileencodings=utf-8,ucs-bom,gb18030,cp936,big5,euc-jp,euc-kr,latin1
    elseif MySys() == "linux"
        set langmenu=zh_CN.UTF-8
        set encoding=utf-8
        let &termencoding=&encoding
        set fileencoding=utf-8
        set fencs=utf-8,usc-bom,gb18030,gbk,gb2312,cp936 
    endif
"}}}

" Default Path & Global constant - chrome "{{{
    " 启动进入自己的主目录
    exec 'cd '.g:ywl_path

    " python path
    if MySys()=='linux'
        let g:pypath="/home/ywl/.pyenv/versions/anaconda3-2.4.0/bin"
    endif

    " chrome path for windows 
    if hostname() == 'M-PC'
        let g:path_chrome='C:\Users\m\AppData\Local\Google\Chrome\Application\chrome.exe'
    else 
        let g:path_chrome='C:\Users\ywl\AppData\Local\Google\Chrome\Application\chrome.exe'
    endif
"}}}

" Global Mapping "{{{ 

    " F1 废弃这个键,防止调出系统帮助
    noremap <F1> <Esc>"
    " F2 语法开关，关闭语法可以加快大文件的展示
    nnoremap <F2> :exec exists('g:syntax_on') ? 'syn off' : 'syn enable'<CR>
    " F3 显示可打印字符开关
    nnoremap <F3> :set list! list?<CR>
    " set paste的Toggle，有格式的代码粘贴
    set pastetoggle=<F6>
    " disbale paste mode when leaving insert mode
    " au InsertLeave * set nopaste   

    " F11 doesn't work in terms 全屏模式 buftype = 'quickfix'
    " nmap <S-F11> :cw 10<cr>
    " nmap <C-F11> :ccl<cr>
    " nmap <leader>cc :botright lw 10<cr>
    " map <c-u> <c-l><c-j>:q<cr>:botright cw 10<cr>
    
    " Quickly close the current window
    nnoremap <leader>q :q<CR>

    " Quickly save the current file
    nnoremap <leader>w :w<CR>

    " remap U to <C-r> for easier redo
    nnoremap U <C-r>

    " 方便书签的跳转
    nnoremap ' `
    nnoremap ` '

    " mapping
    " 如果下拉菜单弹出，回车映射为接受当前所选项目，否则，仍映射为回车
    inoremap <expr> <CR> pumvisible()?"\<C-Y>":"\<CR>"
    " 如果下拉菜单弹出，CTRL-U映射为CTRL-E，即停止补全，否则，仍映射为CTRL-U
    " inoremap <expr> <C-U> pumvisible()?"\<C-E>":"\<C-U>"

    " vim default mapping
    " inoremap <c-[> <ESC>
    " inoremap <c-h> <BS>
    " <C-O>    : 依次沿着你的跳转记录向回跳 (从最近的一次开始)
    " <C-I>    : 依次沿着你的跳转记录向前跳
    " :ju(mps) : 列出你跳转的足迹


"{{{
" 自定义／个性化快捷键

" 关于tab buffer 的快捷键
" 跳转，翻页 向下翻半夜  向上翻半夜
" Tab操作快捷方式!
    " nnoremap <C-TAB> :tabnext<CR>
    " nnoremap <C-S-TAB> :tabprev<CR>
    " nnoremap gn :tabnext<CR>
    " nnoremap gp :tabprev<CR>
    " nnoremap <C-t> :tabnew<cr>
    " nnoremap <C-e> :tabclose<cr>
" map te :tabedit
" tabd[o] {cmd} 对每个标签页执行{cmd}, 遍历标签页
" tablast 最后一个标签页
" tabmove N  将当前标签页移动到N个标签页之后
" 移动到第一个标签页
    " nnoremap g1 1gt
    " nnoremap g2 2gt
    " nnoremap g3 3gt
    " nnoremap g4 4gt
    " nnoremap g5 5gt
    " nnoremap g6 6gt
    nnoremap gn :bn<CR>
    nnoremap gp :bp<CR>
    nnoremap <leader>bd :bd<CR>
"}}}

"{{{
" Smart way to move .btw. windows 
" 关于窗口的扩大缩小, :help window-resize
    " noremap <C-j> <C-W>j
    " noremap <C-k> <C-W>k
    " noremap <C-h> <C-W>h
    " noremap <C-l> <C-W>l
    imap <C-h> <Left>
    imap <C-l> <Right>
    imap <C-j> <Down>
    imap <C-k> <Up>
    " <C-B>插入模式下一次性删除一个词
    imap <c-b> <c-o>diw

" Treat long lines as break lines (useful when moving around in them)
    nnoremap j gj
    nnoremap k gk
"}}}

"{{{
" Quickfix
""""""""""""""""""""""""""""""
"   nmap <leader>cn :cn<cr>
"   nmap <leader>cp :cp<cr>
"}}}

"{{{
" 自动补全括号，包括大括号 ( 用插件 delimitMate 代替了）
    " :inoremap ( ()<ESC>i
    " :inoremap ) <c-r>=ClosePair(')')<CR>
    " :inoremap { {}<ESC>i
    " :inoremap } <c-r>=ClosePair('}')<CR>
    " :inoremap [ []<ESC>i
    " :inoremap ] <c-r>=ClosePair(''')<CR>
    " :inoremap < <><ESC>i
    " :inoremap > <c-r>=ClosePair('>')<CR>
" 实现括号的自动配对后防止重复输入），适用python
     " function! ClosePair(char)
        " if getline('.')[col('.') - 1] == a:char
            " return "\<Right>"
        " else
          " return a:char
       " endif
    " endf
"}}}

"}}}

" Autocmd "{{{
if has("autocmd")
    autocmd! FileType c,cs,java,perl,
                \shell,bash,cpp,python,vim,php,ruby  setlocal cc=81
    
    augroup htmlevent
        autocmd! htmlevent
        autocmd BufRead,BufNewFile *.html  
                    \setlocal tabstop=2 |
                    \setlocal softtabstop=2 |
                    \setlocal shiftwidth=2 |
                    \setlocal cc=81
    augroup END

    autocmd! FileType c,cpp set smartindent
    " set smartindent " 开启行时使用智能自动缩进，为C程序
    " indent: 如果用了:set indent,
        " :set ai 等自动缩进，想用退格键将字段缩进的删掉，必须设置这个选项。否则不响应。
    " eol:如果插入模式下在行开头，想通过退格键合并两行，需要设置eol。
    " start：要想删除此次插入前的输入，需设置这个。 

    augroup xml-fold
        autocmd! xml-fold
        autocmd BufReadPre *.xml 
                    \let g:xml_syntax_folding = 1 |  
                    \setlocal foldmethod=syntax |
                    \setlocal cc=81
    augroup END

    au BufNewFile,BufRead *.swig,*.ejs set filetype=javascript 

    augroup markdownevent
        autocmd! markdownevent
        autocmd BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn,html} 
                    \ setlocal formatoptions+=n |
                    \setlocal tabstop=4 |
                    \setlocal softtabstop=4 |
                    \setlocal shiftwidth=4 |
                    \setlocal cc=81
        if MySys() == 'linux'
            autocmd BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn,html} 
                        \map <leader>p :!google-chrome "%:p"<CR>
        elseif MySys() == 'windows'
            " autocmd Filetype html,xml,xsl source $HOME\vimfiles\plugin\closetag.vim
            " autocmd Filetype matlab source $HOME\vimfiles\syntax\matlab.vim|set cms=%\ %s
            " autocmd BufEnter *.m compiler mlint
            autocmd BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn,html} 
                        \map <Leader>p :exec "!start ".g:path_chrome." %:p"<CR>
            "   autocmd Bufenter * normal zn    
        endif
    augroup END

    autocmd! BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \ exe " normal g`\"" |
                \ endif

    augroup  pythonevent
        autocmd! pythonevent
        autocmd pythonevent BufRead,BufNewFile *.py setlocal foldmethod=indent | setlocal foldlevel=0
        autocmd pythonevent BufNewFile,BufRead *.py
                    \ setlocal tabstop=4 |
                    \ setlocal softtabstop=4 |
                    \ setlocal shiftwidth=4 |
                    " \ set textwidth=79 |
                    \ setlocal autoindent |
                    \ setlocal fileformat=unix 
    augroup END


        "
" 使用模板文件
"   autocmd BufNewFile  *.html 0r ~/.vim/template/html.tpl
"   autocmd BufNewFile  *.js   0r ~/.vim/template/javascript.tpl
"   autocmd BufNewFile  *.php  0r ~/.vim/template/php.tpl
    
endif "has("autocmd")
"}}}

" Customed Function"{{{
"{{{
" Time.function 缩写定义
" 在插入模式下输入xdate就会自动显示当前的时间
    iab tdate <c-r>=strftime("%Y/%m/%d %H:%M:%S")<cr>
    iab ydate <c-r>=strftime("%Y-%m-%d")<cr>
"}}}
"}}}

"{{{
" 调用AStyle程序，进行代码美化

func! CodeFormat()
    "取得当前光标所在行号
    let lineNum = line(".")
    "C源程序
    if &filetype == 'c'
        "执行调用外部程序的命令
        exec "! astyle --style=ansi -A3Lfpjk3NS %"
        "H头文件(文件类型识别为cpp)，CPP源程序
    elseif &filetype == 'cpp'
        "执行调用外部程序的命令
        "exec "%! astyle -A3Lfpjk3NS\<CR>"
        "exec '! astyle --style=ansi -A3Lfpjk3NS '.expand('%:p')
        exec '! astyle --style=ansi -A3Lfpjk3NS %'
        "exec "%! astyle -p -V --style=ansi --indent=spaces=4"
        "JAVA源程序
    elseif &filetype == 'java'
        "执行调用外部程序的命令
        exec "%! astyle -A2Lfpjk3NS\<CR>"
    else 
        "提示信息
        echo "no support ".&filetype." filetype."
    endif
    "返回先前光标所在行
    exec lineNum
endfunc
"映射代码美化函数到Shift+f快捷键
if MySys() == "windows"
    " map <leader>fm <Esc>:call CodeFormat()<CR>
endif
"}}}

"{{{
" 瞎捣鼓

"   获取当前文件的后缀名：抛砖引玉
    function! GetFileType()
        let uFileSuffix = expand('%:e')
        return uFileSuffix
    endfunction

"   进行版权声明的设置
"   添加或更新头
    function! AddTitle()
        if GetFileType() == 'wiki'
            let uAnnotation = '# ' 
        else
            let uAnnotation = '//'
        endif
            call append(0,uAnnotation."========================
                        \=====================================================")
            call append(1,uAnnotation)
            call append(2,uAnnotation." Author: ywlbupt - ywlbupt@163.com")
            call append(3,uAnnotation)
            call append(4,uAnnotation)
            call append(5,uAnnotation." Last modified:  XXXX-XX-XX XX:XX")
            call append(6,uAnnotation)
            call append(7,uAnnotation." Filename:       _vimrc")
            call append(8,uAnnotation)
            call append(9,uAnnotation." Description: ")
            call append(10,uAnnotation)
            call append(11,uAnnotation."=======================
                        \======================================================")
        echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
    endf


" 更新最近修改时间和文件名
" 以后考虑使用查找替换字符串函数来优化这段代码 ##
    function! UpdateTitle()
        if GetFileType() != 'wiki'
            normal m'
            execute '/\/\/ *Last modified:/s@:.*$@\=strftime(":\t%Y-%m-%d %H:%M")@'
            normal ''
            normal mk
            execute '/\/\/ *Filename:/s@:.*$@\=":\t\t".expand("%:t")@'
            execute "noh"
            normal 'k
        else 
            normal m'
            execute '/# *Last modified:/s@:.*$@\=strftime(":\t%Y-%m-%d %H:%M")@'
            normal ''
            normal mk
            execute '/# *Filename:/s@:.*$@\=":\t\t".expand("%:t")@'
            execute "noh"
            normal 'k
        endif
        echohl WarningMsg | echo "Successful in updating the copy right." | echohl None
    endfunction

"   判断前10行代码里面，是否有Last modified这个单词，
"   如果没有的话，代表没有添加过作者信息，需要新添加；
"   如果有的话，那么只需要更新即可
    function! TitleDet()
        if GetFileType() == 'wiki'
            let uAnnotation = '# ' 
        else
            let uAnnotation = '//'
        endif
        let n=1
        normal gg
    "   默认为添加
        while n < 10
            let line = getline(n)
    "       if line =~ '^\/\/\s*\S*Last\smodified:\S*.*$'
            if line =~ '^'.uAnnotation.'\s*\S*Last\smodified:\S*.*$'
                call UpdateTitle()
                return
            endif
            let n = n + 1
        endwhile
        call AddTitle()
    endfunction
"}}}

"{{{
" Plugin unused 
"{{{
" taglist.vim
""""""""""""""""""""""""""""""
    " noremap <leader>tl :TlistToggle<cr>
    " if MySys() == "windows"                "设定windows系统中ctags程序的位
        " let Tlist_Ctags_Cmd = 'ctags'
    " elseif MySys() == "linux"              "设定linux系统中ctags程序的位置
        " let Tlist_Ctags_Cmd = '/usr/bin/ctags'
    " endif
    " " let Tlist_Show_One_File = 1
    " "不同时显示多个文件的tag，只显示当前文件的
    " let Tlist_Exit_OnlyWindow = 1
    " "如果taglist窗口是最后一个窗口，则退出vim
    " let Tlist_Use_Right_Window = 0         "在右侧窗口中显示taglist窗口
    " let Tlist_WinWidth=31
    " " 如果希望taglist始终解析文件中的tag，不管taglist窗口有没有打开，设置Tlist_Process_File_Always 为 1
"}}}

" BufExplorer "{{{
""""""""""""""""""""""""""""""
    " let g:bufExplorerDefaultHelp=0       " Do not show default help.
    " let g:bufExplorerShowRelativePath=1  " Show relative paths.
    " let g:bufExplorerSortBy='mru'        " Sort by most recently used.
    " let g:bufExplorerSplitRight=0        " Split left.
    " let g:bufExplorerSplitVertical=1     " Split vertically.
    " let g:bufExplorerSplitVertSize = 30  " Split width
    " let g:bufExplorerUseCurrentWindow=1  " Open in new window.
    " autocmd! BufWinEnter \[Buf\ List\] setl nonumber 
"}}}

" Tohtml 将缓冲区的配色转成html"{{{
""""""""""""""""""""""""""""""
" 步骤如下：
" 1、vim编辑代码；
" 2、如果有中文字符，则:let html_use_encoding='gb2312'；
" 4、设置let html_no_pre = 1，This makes it show up as you see it in Vim, but without wrapping。懒得翻译，自己看吧
" 3、:TOhtml，保存；
" 4、用浏览器将3保存的文件打开；
" 5、复制4的页面内容粘贴到博客的编辑框（如果是cnblogs，则需要将4生成的html代码拷贝到html编辑框内）；
" 6、搞定。
    " let g:html_start_line = line("'<")
    " let g:html_end_line = line("'>")
    " " 强制给行编号
    " let g:html_number_lines = 0
    " "let g:html_no_pre = 1 
    " "let g:html_use_css = 0
    " "let g:html_use_xhtml = 1
"}}}
    
" Yggdroot/vim-mark "{{{
""""""""""""""""""""""""""""""
"   To enable the automatic restore of marks from a previous Vim session
    " let g:mwAutoLoadMarks = 1

    " noremap <Leader>1  <Plug>MarkSearchGroup1Next
    " noremap <Leader>!  <Plug>MarkSearchGroup1Prev
    " noremap <Leader>2  <Plug>MarkSearchGroup2Next
    " noremap <Leader>@  <Plug>MarkSearchGroup2Prev
    " noremap <Leader>3  <Plug>MarkSearchGroup3Next
    " noremap <Leader>#  <Plug>MarkSearchGroup3Prev
    " noremap <Leader>4  <Plug>MarkSearchGroup4Next
    " noremap <Leader>$  <Plug>MarkSearchGroup4Prev
    " noremap <Leader>5  <Plug>MarkSearchGroup5Next
    " noremap <Leader>%  <Plug>MarkSearchGroup5Prev
    " noremap <Leader>6  <Plug>MarkSearchGroup6Next
    " noremap <Leader>^  <Plug>MarkSearchGroup6Prev
" "   There are no default mappings for toggling all marks and for the :MarkClear 
" "   command, but you can define some yourself: 
    " nmap <Leader>M <Plug>MarkToggle
    " nmap <Leader>N <Plug>MarkAllClear
"}}}

" winManager setting "{{{
"""""""""""""""""""""""""""""""
""  let g:winManagerWindowLayout = "TagList"            
""  FileExplorer,BufExplorer
""  let g:winManagerWindowLayout='FileExplorer|TagList'
"   let g:winManagerWindowLayout='NERDTree|TagList'
"   let g:winManagerWidth = 31
"   let g:defaultExplorer = 0
""  nmap <C-W><C-F> :FirstExplorerWindow<cr>
""  nmap <C-W><C-B> :BottomExplorerWindow<cr>
"   nmap <silent> <leader>wm :WMToggle<cr>
""  nmap <leader>wm :if IsWinManagerVisible() <BAR> WMToggle<CR> <BAR> else <BAR> WMToggle<CR>:q<CR> endif <CR><CR>
"}}}

" Trinity of wesleyche"{{{
"   " Open and close all the three plugins on the same time 
"   nmap <F8>  :TrinityToggleAll<CR> 
"
""  Open and close the Source Explorer separately 
"   nmap <F9>  :TrinityToggleSourceExplorer<CR> 
"
""}}}

" Txtbrowser"{{{
"   定制自己的搜索引擎:h txt-search-engine
    " let Txtbrowser_Search_Engine='https://www.google.com.hk/#newwindow=1&q=text&safe=strict'
"   定制自己的词典:h txt-dict
    " let TxtBrowser_Dict_Url='http://dict.youdao.com/search?q=text&keyfrom=dict.index'
"}}}

"{{{
" Align
" AlignCtrl lp0P0
" p0P0表示分隔符前后有0个空格
" 通过字母l和r进行对齐，l表示左对齐，r表示右对齐
" help alignctrl-p
""""""""""""""""""""""""""""""
    " let g:Align_xstrlen= 3
"}}}

"}}}
