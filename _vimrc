" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

" Bundle management"{{{
" --------Brief help----------------------------
" :PluginList          - list configured bundles  
" :PluginInstall(!)    - install(update) bundles  
" :PluginSearch(!) foo - search(or refresh cache first) for foo   
" :PluginClean(!)      - confirm(or auto-approve) removal of unused bundles 

" Get out of VI's compatible mode.
set nocompatible    " required
filetype off        " required
" ----------------------------------------------
" for VundleVim/Vundle.vim "
set rtp+=$VIMFILES/bundle/Vundle.vim
call vundle#begin('$VIMFILES/bundle')
Plugin 'VundleVim/Vundle.vim'

"	"let Vundle manage Vundle, required

        " Plugin 'vimwiki/vimwiki'

        " ----------------------------------------------
        " vim-markdown 要求tabular插件，feature as Align
        Plugin 'godlygeek/tabular' | Plugin 'plasticboy/vim-markdown'
        " ----------------------------------------------

        " ----------------------------------------------
    "  for Sourcecode-like ide
        " Plugin 'wesleyche/Trinity'
        " Plugin 'wesleyche/SrcExpl'

        " xolox/vim-misc 以下plugin的依赖包
        " vim-colorscheme-switcher (vimscript #4586) 
        " vim-easytags (vimscript #3114) 
        " vim-lua-ftplugin (vimscript #3625) 
        " vim-lua-inspect (vimscript #3169) 
        " vim-notes (vimscript #3375) 
        " vim-reload (vimscript #3148) 
        " vim-session (vimscript #3150) 
        " vim-shell (vimscript #3123)
        Plugin 'xolox/vim-misc' |  Plugin 'xolox/vim-session'

        " 目前还没有用上
        Plugin 'yegappan/grep'

    " tpope 大神
        Plugin 'tpope/vim-repeat' | Plugin 'tpope/vim-surround'
        " Git 集成工具
        Plugin 'tpope/vim-fugitive'
        " 强大的注释工具
        " Plugin 'tpope/vim-commentary'
        " 类似于公共支持插件，支持surroud,

        Plugin 'jkeylu/vimcdoc'


        " 这个插件用于自动补全，可用于 . ->  :: 等操作符。
        " Plugin 'FromtonRouge/OmniCppComplete'

        if MySys() == "linux"
            Plugin 'Valloric/YouCompleteMe'
        endif

        " provide a reference manual for the C++ standard template library (STL)
"       Plugin 'stlrefvim'
        " Auto Complete of python
        Plugin 'Pydiction'
        " fold for python
        Plugin 'tmhedberg/SimpylFold'

        "---------模板输入 快捷输入--------
        " Plugin 'load_template'
        Plugin 'ywlbupt/load_template'

        " snipmate 
"       Plugin 'MarcWeber/vim-addon-mw-utils'
"       Plugin 'tomtom/tlib_vim'
"       Plugin 'garbas/vim-snipmate'

		"""""""""""""""""""""""""""""""""""""""""""""""
        Plugin 'scrooloose/nerdcommenter'
        Plugin 'scrooloose/nerdtree'
        Plugin 'taglist.vim' 
        Plugin 'Align'
        " Plugin 'TxtBrowser'
        " Plugin 'winmanager'
        Plugin 'a.vim'

        " Optional:
"       Plugin "honza/vim-snippets"
        """"""""""" end of snipmate

        " autocomplete pairs自动补全括号
        Plugin 'Raimondi/delimitMate'

        " colors
        Plugin 'vim-airline/vim-airline' 
        Plugin 'vim-airline/vim-airline-themes'

        Plugin 'vim-ctrlspace/vim-ctrlspace'
        " Plugin 'ywlbupt/vim-color-ywl'
        Plugin 'altercation/vim-colors-solarized'

        " 括号显示增强
        Plugin 'kien/rainbow_parentheses.vim'
        " quickrun
        Plugin 'thinca/vim-quickrun'
        " 
        Plugin 'ctrlpvim/ctrlp.vim' " or 
        Plugin 'majutsushi/tagbar'
        " gitgutter
        Plugin 'airblade/vim-gitgutter'
        " nerd tree tabs
        Plugin 'jistr/vim-nerdtree-tabs'
        Plugin 'scrooloose/syntastic'
        " " text object
        " " 支持自定义文本对象
        " Plug 'kana/vim-textobj-user'
        " " 增加行文本对象: l   dal yal cil
        " Plug 'kana/vim-textobj-line'
        " " 增加文件文本对象: e   dae yae cie
        " Plug 'kana/vim-textobj-entire'
        " " 增加缩进文本对象: i   dai yai cii - 相同缩进属于同一块
        " Plug 'kana/vim-textobj-indent'
    
    " endif
    call vundle#end()            " required
    filetype plugin indent on    " required
"}}}

"  matchit.vim插件扩展了%匹配字符的范围,根据不同的filetype来做不同的匹配
    source $VIMRUNTIME/macros/matchit.vim

"	For windows version, using gVIM with Cygwin on a Windows PC"{{{
if MySys() == "windows"
"   source $VIMRUNTIME/mswin.vim
"   behave mswin
"	unmap <C-A>
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

" Set mapleader & Fast edit vimrc
    let mapleader =","
" Fast edit vimrc
    if MySys() == "linux"
    "   Fast reloading of the .vimrc
        map <silent> <leader>ss :exec 'source '.g:ywl_path.'/_vimrc'<cr>
        map <silent> <leader>rr :source ~/.vimrc<cr>
    "   Fast editing of .vimrc
        map <silent> <leader>ee :exec 'edit '.g:ywl_path.'/_vimrc'<cr>
        map <silent> <leader>er :e ~/.vimrc<cr>
    "   When .vimrc is edited, reload it
        autocmd! bufwritepost _vimrc exec 'source ~/.vimrc'
        autocmd! bufwritepost .vimrc exec 'source ~/.vimrc'
    elseif MySys() == "windows"
    "   Set helplang
    "   Set helplang=cn
    "   Fast reloading of the _vimrc
        map <silent> <leader>ss :exec 'source '.g:ywl_path.'\_vimrc'<cr>
        map <silent> <leader>rr :source $VIM\_vimrc<cr>
    "   Fast editing of _vimrc
        map <silent> <leader>ee :exec 'edit '.g:ywl_path.'\_vimrc'<cr>
        map <silent> <leader>er :e $VIM\_vimrc<cr>
    "   When _vimrc is edited, reload it
        autocmd! bufwritepost _vimrc exec 'source $VIM\_vimrc'
    "   Open my note about Vim
    endif
"}}}
 
" Reformate 排版与文本格式"{{{
" 文本格式化
" B在连接行时，不要在两个多字节字符之间插入空格。有'M' 标志位时无效。
    set formatoptions+=B
        
    set expandtab
    set shiftwidth=4 " 设定 << 和 >> 命令移动时的宽度为 4
    set softtabstop=4 " 使得按退格键时可以一次删掉 4 个空格
    " set tabstop=8 " 设定 tab 长度为 8
    set tabstop=4 " 设定 tab 长度为 4

    set wrap "文本的回绕，不超过窗口宽度

    auto FileType c,cpp  set cindent " Strict rules for C Programs
    "auto FileType c,cpp  set smartindent " Strict rules for C Programs
    set autoindent
    set smartindent " 开启行时使用智能自动缩进，为C程序
    set backspace=indent,eol,start
    "   不设定在插入状态无法用退格键和 Delete 键删除回车符


    if has("autocmd")
    endif
"}}}

" Chinese encoding "{{{

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

"{{{
" 启动进入自己的主目录
    if MySys() == 'linux'
        exec 'cd '.g:ywl_path
    elseif MySys() == 'windows'
        exec 'cd '.g:ywl_path
    "   set shell=c:\\cygwin\\bin\\bash.exe shellcmdflag=--login\ -c shellxquote=\"
    endif
"}}}

    if hostname() == 'M-PC'
        let g:path_chrome='C:\Users\m\AppData\Local\Google\Chrome\Application\chrome.exe'
    else 
        let g:path_chrome='C:\Users\ywl\AppData\Local\Google\Chrome\Application\chrome.exe'
    endif
"}}}

" Base Setting "{{{
" Basic{{{
    syntax on " 自动语法高亮
    syntax enable

    set showcmd     " Show (partial) command in status line."
    set hlsearch
    exec "noh"
    " 设置宽度不明的文字(如 “”①②→ )为双宽度文本
    set ambiwidth=double
" Set to auto read when a file is changed from the outside
    set autoread
    set mouse=a
    set number " 显示行号
    " set relativenumber " 显示相对行号
    set ruler " 打开状态栏标尺

    set nobackup " 覆盖文件时不备份
	set autochdir " 自动切换当前目录为当前文件所在的目录

    if has("autocmd")
        "windows下，对包含空格的路径会有问题，修改如下：
        autocmd! BufEnter * silent! lcd %:p:h:gs/ /\\ /
        "开/tmp文件夹下的文件时不自动切换，则设置如下：
        "autocmd! BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif
    endif

    "let &autochdir=0
    set backupcopy=yes " 设置备份时的行为为覆盖
    set ignorecase smartcase
    "   搜索时忽略大小写，但在有一个或以上大写字母时仍保持对大小写敏感
    set nowrapscan " 禁止在搜索到文件两端时重新搜索
    set incsearch " 输入搜索内容时就显示搜索结果
    set noerrorbells " 关闭错误信息响铃
    set novisualbell " 关闭使用可视响铃代替呼叫
    set vb t_vb=
    "   置空错误铃声的终端代码,set silent (no beep)
    "   set showmatch " 插入括号时，短暂地跳转到匹配的对应括号
    "   set matchtime=2 " 短暂跳转到匹配括号的时间
    set magic " 设置魔术，搜索设置
    set hidden " 允许在有未保存的修改时切换缓冲区，此时的修改由 vim 负责保存

    set cmdheight=1 " 设定命令行的行数为 1
    set laststatus=2 " 显示状态栏 (默认值为 1, 无法显示状态栏)
    "   我的状态栏显示的内容
    set statusline=%F%m%r%h%w\[POS=%l,%v][%p%%]\%{
                \strftime(\"%d/%m/%y\ -\ %H:%M\")}
    " 从左到右分别是: 相对路径, 光标处字符 Unicode 编码, 系统, 文件编码, " 文件类型, tab长度, 行/列, 光标位置, 视窗位置
    " set statusline=%h%w%r\ %f\ %m%=\ %B\ \|\ %{&ff}\ \|\ %{&fenc!=''?&fenc:&enc}\ \|\ %{&ft!=''?&ft:'none'}\ \|\ %{&tabstop}\ %8(%l,%v%)\ %10(%p%%,%P%)
    "用空格键来开关折叠
    nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
    
    "带有如下符号的单词不要被换行分割
    set iskeyword+=_,$,@,%,#,-
    " 在gui环境下altkey快捷键的
    if MySys()=='windows'
        set winaltkeys=no
    endif
" 提示自己代码别超过81列"}}}

" Fold setting "{{{
    set foldtext=MyFoldText()
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
    "}}}

"{{{
" view,buffer Operation
if MySys() == 'linux'
    set viewdir=$HOME/Dropbox/vimfiles/view
elseif MySys() == 'windows'
    set viewdir=$HOME/vimfiles/view
endif
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
    exec 'set undodir='.g:ywl_path.'/vimfiles/undodirfile'
    set undolevels=1000 "maximum number of changes that can be undone
    set undofile
"}}}

"}}}

" Global Mapping "{{{ 

" Save and Quit
    
    " F1 废弃这个键,防止调出系统帮助
    noremap <F1> <Esc>"
    " F2 语法开关，关闭语法可以加快大文件的展示
    nnoremap <F2> :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>
    " F3 显示可打印字符开关
    nnoremap <F3> :set list! list?<CR>
    " set paste的Toggle，有格式的代码粘贴
    set pastetoggle=<F6>
    
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



"{{{
" 自定义／个性化快捷键

" 关于tab buffer 的快捷键
" 跳转，翻页 向下翻半夜  向上翻半夜
" Tab操作快捷方式!
    nnoremap <C-TAB> :tabnext<CR>
    nnoremap <C-S-TAB> :tabprev<CR>
    nnoremap gn :tabnext<CR>
    nnoremap gp :tabprev<CR>
    nnoremap <C-t> :tabnew<cr>
    nnoremap <C-e> :tabclose<cr>
" map te :tabedit
" tabd[o] {cmd} 对每个标签页执行{cmd}, 遍历标签页
" tablast 最后一个标签页
" tabmove N  将当前标签页移动到N个标签页之后
" 移动到第一个标签页
    nnoremap g1 1gt
    nnoremap g2 2gt
    nnoremap g3 3gt
    nnoremap g4 4gt
    nnoremap g5 5gt
    nnoremap g6 6gt
    nnoremap <c-b>n :bn<CR>
    nnoremap <c-b>p :bp<CR>
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
" F11 doesn't work in terms
   nmap <S-F11> :cw 10<cr>
   nmap <C-F11> :ccl<cr>
"   nmap <leader>cc :botright lw 10<cr>
"   map <c-u> <c-l><c-j>:q<cr>:botright cw 10<cr>
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

"{{{
" xolox/vim-session
" --------Brief help------------
" :SaveSession sessionname  - 如果不提供sessionname，默认保存为default会话
" :OpenSession sessionname  - 如果不提供sessionname，默认打开default会话
" :CloseSession  - 关闭当前会话，关闭所有标签，打开一个空缓冲区
" :DeleteSession - 关闭会话，当前标签保留

" Session保存路径
    if MySys() == 'windows'
        let g:session_directory=g:ywl_path.'\vimfiles\Workspace'
    elseif MySys() == 'linux'
        let g:session_directory=g:ywl_path.'/vimfiles/Workspace'
    endif

    " 每次打开空Vim，不提示是否打开 default session
    let g:session_autoload='no'

    " 每次退出session时，是否提示保存会话
    let g:session_autosave='no'

    " 每十分钟自动保存Session
    " let g:session_autosave_periodic = 10
"}}}

" altercation/vim-colors-solarized"{{{
    " if g:colors_name == 'solarized' 
        let g:solarized_termcolors= 256
        let g:solarized_termtrans = 1
        let g:solarized_contrast = "normal"    " 'normal' 'high' or 'low'
        let g:solarized_visibility= "normal"
    " endif
"}}}

"{{{
" gui_running

    highlight WhitespaceEOL ctermbg=red guibg=red
    match WhitespaceEOL /\s\+$/
    set cursorline " 突出显示当前行
    set background=dark
    colorscheme solarized

    if has("gui_running")
        set guioptions-=T " 隐藏工具栏
        set guioptions-=m " 隐藏菜单栏
        set guioptions-=L
        " set guioptions-=r
        set background=dark
        " colorscheme desert_ywl  "设定配色方案
        autocmd GUIEnter * set lines=35 |  set columns=119 
        if MySys() == 'linux'
            "exec "winpos 400 70"
        endif
    else
        if &term == "xterm"
            " set t_Co=16
            " set t_Sb=^[[4%dm " 设置背景色
            " set t_Sf=^[[3%dm " 设置前景色
            set t_Co=256
            " colorscheme evening_ywl
            autocmd VimEnter * set lines=35 | set columns=119
        endif 
    endif
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
                        \ set formatoptions+=n
        if MySys() == 'linux'
            autocmd BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn,html} 
                        \map <leader>p :!google-chrome "%:p"<CR>
        elseif MySys() == 'windows'
            " autocmd Filetype html,xml,xsl source $HOME\vimfiles\plugin\closetag.vim
            " autocmd Filetype matlab source $HOME\vimfiles\syntax\matlab.vim|set cms=%\ %s
            " autocmd BufEnter *.m compiler mlint
            autocmd BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn,html} 
                        \map <Leader>p :exec "!start ".g:path_chrome." %:p"<CR>
            "\map <Leader>p :exec "!start ".substitute(g:path_chrome, '\\', '\\\\', 'g')." %:p"
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
                    \ setlocal expandtab |
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

"{{{
" vim-airline/vim-airline  "好看轻量级的powerline，不依赖python
    let g:airline_powerline_fonts = 1    
    let g:airline_theme = "base16_google"
    if MySys() == 'windows'
        " set guifont=Sauce_Code_Powerline:h11:cANSI
        " set guifont=Anonymice_Powerline:h13:cANSI     " 字体太大
        " set guifont=Droid_Sans_Mono_Dotted_for_Powe:h11:cANSI
        set guifont=DejaVu_Sans_Mono_for_Powerline:h11:cANSI
        " set guifont=Inconsolata-g_for_Powerline:h11:cANSI
        " set guifont=Hack:h11:cANSI
        " set guifont=monofur_for_Powerline:h13:cANSI
    else 
	    if has("gui_gtk2")
            set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 11
        endif
    endif
    " 打开tabline功能,方便查看Buffer和切换，这个功能比较不错
    " let g:airline#extensions#tabline#enabled = 1
    " let g:airline#extensions#tabline#buffer_nr_show = 1

"}}}

" vim-ctrlspace/vim-ctrlspace  " Tab 与 Buffer 的导航增强"{{{
    set hidden
    " 与airline statusline的冲突
    let g:CtrlSpaceDefaultMappingKey = "<leader><Space>"
    let g:airline_exclude_preview = 1
    if has("gui_running")
        " Settings for MacVim and Inconsolata font
        let g:CtrlSpaceSymbols = { "File": "◯", "CTab": "▣", "Tabs": "▢" }
    endif
"}}}

"{{{
" vim-scripts/Load_Template file setting
    if MySys() == 'windows'
        let g:template_path=g:ywl_path.'\vimfiles\bundle\load_template\template\'
    elseif MySys() == 'linux'
        let g:template_path=g:ywl_path.'/vimfiles/bundle/load_template/template/'
    endif
" Load_template 说明
" 1. 静态模板文件中，`TEMPLATE_CURSOR`标明载入模板后光标所在位置
" 2. 动态模板，Vim 脚本放置在`EXE_BEGIN_TEMPLATE (NEEDNEW)``EXE_END_TEMPLATE`
"}}}

"{{{
" Pydiction && SimpylFold
    if MySys() == 'windows'
		let g:pydiction_location =
		 \ g:ywl_path.'\vimfiles\bundle\Pydiction\complete-dict'
    elseif MySys() == 'linux'
		let g:pydiction_location = 
		 \ g:ywl_path.'/vimfiles/bundle/Pydiction/complete-dict'
    endif
    let g:SimpylFold_docstring_preview=1
"}}}

" Customed Function"{{{
"{{{
" function! RunmeCmd()
    function! RunmeCmd()
    let s:text = getline('.')
    if strlen('s:text')!=0
    exec ":! " . s:text
    else
    echo "no find"
    endif
    endfunction

    function! RunmeCmdRead()
    let s:text = getline('.')
    if strlen('s:text')!=0
    exec ":r ! " . s:text
" 上行中的 . 为连接符号，连接前面的字符串和后面的字符变量
    else
    echo "no find"
    endif
    endfunction
    
" 将当前行作为命令行在shell/cmd中执行
    " map <F4> :call RunmeCmd()<CR>
" 将当前行作为命令行在shell/cmd中执行，并写入当前行中
    " map <S-F4> :call RunmeCmdRead()<CR>
"}}}

"{{{
" Time.function
" 在插入模式下输入xdate就会自动显示当前的时间
    iab tdate <c-r>=strftime("%Y/%m/%d %H:%M:%S")<cr>
    iab ydate <c-r>=strftime("%Y-%m-%d")<cr>
"}}}
"}}}

" plasticboy/vim-markdown : markdown　syntax"{{{
" --------Brief help------------
" :Toc " 左侧打开目录栏quickfix Windows
    " Add the following line to your '.vimrc' to disable the folding configuration:
    let g:vim_markdown_folding_disabled = 0
    " set the initial foldlevel
    let g:vim_markdown_initial_foldlevel=0
    " Markdown Toc width autofit
    let g:vim_markdown_toc_autofit = 1
    " Disable vim-markdown mapping :1 disable ; 0: enable
    let g:vim_markdown_no_default_key_mappings = 1
    " 列表的自动缩进
    let g:vim_markdown_new_list_item_indent = 0
    " 'g:vim_markdown_folding_level' setting is not active with this fold style.
    let g:vim_markdown_folding_style_pythonic = 1
    " Highlight YAML front matter as used by Jekyll or Hugo [7].
    let g:vim_markdown_frontmatter = 1

"}}}

"{{{
" taglist.vim
""""""""""""""""""""""""""""""
    noremap <leader>tl :TlistToggle<cr>
    if MySys() == "windows"                "设定windows系统中ctags程序的位
        let Tlist_Ctags_Cmd = 'ctags'
    elseif MySys() == "linux"              "设定linux系统中ctags程序的位置
        let Tlist_Ctags_Cmd = '/usr/bin/ctags'
    endif
    " let Tlist_Show_One_File = 1
    "不同时显示多个文件的tag，只显示当前文件的
    let Tlist_Exit_OnlyWindow = 1
    "如果taglist窗口是最后一个窗口，则退出vim
    let Tlist_Use_Right_Window = 0         "在右侧窗口中显示taglist窗口
    let Tlist_WinWidth=31
    " 如果希望taglist始终解析文件中的tag，不管taglist窗口有没有打开，设置Tlist_Process_File_Always 为 1
"}}}

" Raimondi/delimitMate : 自动补全括号 "{{{
" --------Brief help------------
" <BS>         is mapped to <Plug>delimitMateBS
" <S-BS>       is mapped to <Plug>delimitMateS-BS
" <S-Tab>      is mapped to <Plug>delimitMateS-Tab
" <C-G>g       is mapped to <Plug>delimitMateJumpMany
    let g:delimitMate_matchpairs = "(:),[:],{:},<:>"
    " 关闭某类型文件的自动补全
    " au FileType mail,text let b:delimitMate_autoclose = 0
    " for python docstring ",优化输入
    au FileType python let b:delimitMate_nesting_quotes = ['"']
    au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} 
        \ let b:delimitMate_quotes = "'" |
        \ let b:delimitMate_excluded_regions = " "
    "}}}

"{{{
" scrooloose/nerdtree
" The-NERD-Tree / netrw setting"{{{
""""""""""""""""""""""""""""""
    let g:netrw_winsize = 31
    " Vexplore!为在左侧打开netrw
    " nmap <silent> <leader>fe :Vexplore<cr>
    nmap <silent> <leader>fe :NERDTreeToggle<cr>

    if MySys() == 'windows'
        let g:NERDTreeBookmarksFile=g:ywl_path.'\vimfiles\plugindata\NERDTreeBookmarks.txt'
    elseif MySys() == 'linux'
        let g:NERDTreeBookmarksFile=g:ywl_path.'/vimfiles/plugindata/NERDTreeBookmarks.txt'     
    endif
    " 将 NERDTree 的窗口设置在 vim 窗口的右侧（默认为左侧）
    let  g:NERDTreeWinPos="left"
    " 当打开 NERDTree 窗口时，自动显示 Bookmarks
    let g:NERDTreeShowBookmarks=1
    " 让Tree把自己给装饰得多姿多彩漂亮点
    let g:NERDChristmasTree=1
    let g:NERDTreeWinSize=31
    " 当输入 [:e filename]不再显示netrw,而是显示nerdtree
    let g:NERDTreeHijackNetrw=1 
    " Nerdtree Display line numbers
    let NERDTreeShowLineNumbers=1
    " 处理文件夹下单一文件夹的显示
    let NERDTreeCascadeOpenSingleChildDir=0

    " Note: Now start vim with plain `vim`, not `vim .`
    if has("autocmd")
        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    endif
" 自定义命令，让NERDTree进入当前文件所在的目录
    command! -n=? -complete=dir -bar Ncd :call MyNerdtreeToggle('<args>')
    function! MyNerdtreeToggle(dir) 
        exec "cd ".expand('%:h')
        exec "NERDTree ".expand('%:h')
    endfunction
"}}}

" Used by winmanager "{{{
    let g:NERDTree_title = "[NERDTree]" 
    function! NERDTree_Start() 
        exe 'NERDTree'
    endfunction 

    function! NERDTree_IsValid() 
      return 1 
    endfunction
"}}}

" Cunstomed Function"{{{

        "if expand('%')=~"NERD_tree_\\d\\+"
    "   nnoremap <buffer> <F4> :call OpenNERDTreeBoookmarks()
    "endif
    " if has("autocmd")
        " autocmd! BufEnter _NERD_tree_ nnoremap <buffer> <F4> :call OpenNERDTreeBoookmarks()<CR>
    " endif
    function! OpenNERDTreeBoookmarks()
        let a:bookmark_str = input("Please enter Bookmarkname: ")
        execute "BookmarkToRoot ".a:bookmark_str
        execute "normal pcd"
    endfunction
"}}}
"}}}

" scrooloose/nerdcommenter"{{{
" --------Brief help------------
" <leader>cc  - Comment out the current line or text selected in visual mode.
" <leader>cn  - Nested Comment 
" <leader>cu  - Uncomments
" <leader>cm  - multiple line NERDComMinimalComment 包裹性的注释时管用

    " Add spaces after comment delimiters by default
    let g:NERDSpaceDelims = 0
    let g:NERDDefaultAlign = 'none'

    let NERDCreateDefaultMappings = 1

    let g:NERDCustomDelimiters = { 'vim': { 'left': '" ' } }
    nmap \\\ <Plug>NERDCommenterToggle
    xmap \\ <Plug>NERDCommenterToggle
    nmap <leader>cc <plug>NERDCommenterComment
    xmap <leader>cc <plug>NERDCommenterComment
    nmap <leader>cu <plug>NERDCommenterUncomment
    xmap <leader>cu <plug>NERDCommenterUncomment
    xmap <leader>cm <Plug>NERDComMinimalComment
"}}}

"{{{
" tpope/vim-surround.vim
" :echo char2nr('-')=45
" :echo char2nr('=')=61
    let g:surround_45 = "```\n\r```"
    let g:surround_61 = "**\n\r**"
    let g:surround_98 = "**\r**"

"}}}

" tpope/vim-fugitive"{{{
" 快捷键
    nnoremap <leader>ge :Gvdiff<CR>
"}}}

" airblade/gitgutter　同用于git diff "{{{
    " " 同git diff,实时展示文件中修改的行
    " " 只是不喜欢除了行号多一列, 默认关闭,gs时打开
    " let g:gitgutter_map_keys = 0
    " let g:gitgutter_enabled = 0
    " let g:gitgutter_highlight_lines = 1
    " nnoremap <leader>gs :GitGutterToggle<CR>
"}}}

" Valloric/YouCompleteMe"{{{
    " let g:ycm_python_binary_path = 'python'
    " nnoremap <leader>y :let g:ycm_auto_trigger=0<cr> "turn off YCM nnoremap
    " nnoremap <leader>Y :let g:ycm_auto_trigger=1<cr> "turn on YCM nnoremap
    if MySys() == 'windows'
        let g:ycm_auto_trigger=0
    else
        let g:ycm_python_binary_path = '/home/ywl/.pyenv/versions/anaconda3-2.4.0/bin/python'
        let g:ycm_auto_trigger=1
        nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
        nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
        nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
        let g:ycm_error_symbol = '>>'
        let g:ycm_warning_symbol = '>*'
        let g:ycm_complete_in_comments = 1  "在注释输入中也能补全
        let g:ycm_complete_in_strings = 1   "在字符串输入中也能补全
        " 注释和字符串中的文字也会被收入补全
        let g:ycm_collect_identifiers_from_comments_and_strings = 1   
        let g:ycm_collect_identifiers_from_tags_files = 1
        " nmap <F4> :YcmDiags<CR>
        " 往前跳和往后跳的快捷键为Ctrl+O以及Ctrl+I
        " 黑名单策略
        let g:ycm_filetype_blacklist = {'tagbar': 1,}
    endif
"}}}

" kien/rainbow_parentheses  彩虹括号"{{{
    " 不加入这行, 防止黑色括号出现, 很难识别
    " \ ['black',       'SeaGreen3'],
    let g:rbpt_colorpairs = [
        \ ['brown',       'RoyalBlue3'],
        \ ['Darkblue',    'SeaGreen3'],
        \ ['darkgray',    'DarkOrchid3'],
        \ ['darkgreen',   'firebrick3'],
        \ ['darkcyan',    'RoyalBlue3'],
        \ ['darkred',     'SeaGreen3'],
        \ ['darkmagenta', 'DarkOrchid3'],
        \ ['brown',       'firebrick3'],
        \ ['gray',        'RoyalBlue3'],
        \ ['darkmagenta', 'DarkOrchid3'],
        \ ['Darkblue',    'firebrick3'],
        \ ['darkgreen',   'RoyalBlue3'],
        \ ['darkcyan',    'SeaGreen3'],
        \ ['darkred',     'DarkOrchid3'],
        \ ['red',         'firebrick3'],
        \ ]
    let g:rbpt_max = 16
    let g:rbpt_loadcmd_toggle = 0
    au VimEnter * RainbowParenthesesToggle
    au Syntax * RainbowParenthesesLoadRound
    au Syntax * RainbowParenthesesLoadSquare
    au Syntax * RainbowParenthesesLoadBraces
"}}}

"{{{
" Ctags
" """"""""""""""""""""""""""""""
" 将当前的工程的tags导入
" 如果源文件在当前文件夹下没有找到tags,可以到它的上层目录下继续寻找
    set tags=tags;
"}}}

"{{{
" Tohtml
""""""""""""""""""""""""""""""
" 步骤如下：
" 1、vim编辑代码；
" 2、如果有中文字符，则:let html_use_encoding='gb2312'；
" 4、设置let html_no_pre = 1，This makes it show up as you see it in Vim, but without wrapping。懒得翻译，自己看吧
" 3、:TOhtml，保存；
" 4、用浏览器将3保存的文件打开；
" 5、复制4的页面内容粘贴到博客的编辑框（如果是cnblogs，则需要将4生成的html代码拷贝到html编辑框内）；
" 6、搞定。
    let g:html_start_line = line("'<")
    let g:html_end_line = line("'>")
    "   强制给行编号
    let g:html_number_lines = 0
    "let g:html_no_pre = 1 
    "let g:html_use_css = 0
    "let g:html_use_xhtml = 1
"}}}
    
"{{{
" Align
" AlignCtrl lp0P0
" p0P0表示分隔符前后有0个空格
" 通过字母l和r进行对齐，l表示左对齐，r表示右对齐
" help alignctrl-p
""""""""""""""""""""""""""""""
    let g:Align_xstrlen= 3
"}}}

"{{{
" vimgrep.vim
" 对搜索的设置
    map <leader>ff :call Search_Word()<CR>:copen<CR>
    function! Search_Word()
        let w = expand("<cword>") " 在当前光标位置抓词
        execute "vimgrep " w " %"
    endfunction

    map <leader>tn :call Tabe_edit()<CR>
    function! Tabe_edit()
        let w = expand("%:p")   "当前文件的完整路径文件名
        execute "close|tabedit "w
    endfunction

""""""""""""""""""""""""""""""
" grep setting
""""""""""""""""""""""""""""""
    " nnoremap <silent> <F3> :Grep<CR>
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
	map <leader>fm <Esc>:call CodeFormat()<CR>
endif
"}}}

"{{{
" 定义CompileRun函数，用来调用编译和运行  
    func! ComplieX()  
        exec "w"  
        if &filetype == 'c'  
            exec "!gcc % -g -Wall -o %<"
        elseif &filetype == 'cpp'  
            exec "!g++ % -g -Wall -o %<"
        endif
    endfunc

" 定义Run函数  
    func! RunX()  
        if &filetype == 'c' || &filetype == 'cpp'  
            exec "!./%<"
        elseif &filetype == 'java'  
            exec "!java %<"
		elseif &filetype == 'python'
            exec "w"  
            if MySys() == 'windows'
                exec "!python %"
            elseif MySys() == 'linux'
                exec "!python %"
            endif  
        endif  
    endfunc  

" 定义Debug函数，用来调试程序  
    func! Debug()  
        exec "w"  
        if &filetype == 'c'  
            exec "!gcc % -g -o %<" 
            exec "!gdb %<"
        elseif &filetype == 'cpp'  
            exec "!g++ % -g -o %<"
            exec "!gdb %<" 
        elseif &filetype == 'java'  
            exec "!javac %"  
            exec "!jdb %<"
        endif  
    endfunc  

"-----------------CPP @ windows---------------
    if MySys() == 'windows'
        func! ComplieRunGpp()
            "if &filetype == 'cpp'
                exec "w"
                exec "!cl -EHsc %"
                exec "!%<"
                " %< 表示没有后缀的本文件
            "endif
        endfunc
" -------------Cpp @ ubuntu --------------------
    elseif MySys() == 'linux'
        func! ComplieRunGpp()
            if &filetype == 'cpp'
                exec "w"
                exec "!g++ % -g -Wall -o %<"
                exec "! %<"
                " exec "! ./%<"     
                " %< 表示没有后缀的本文件
            endif
            if &filetype == 'c'
                exec "w"
                exec "!gcc % -g -Wall -o %<"
                exec "! ./%<"       
                " %< 表示没有后缀的本文件
            endif
        endfunc
    endif
    
    
" 单文件编译运行
    map <silent> <C-F5> :call ComplieRunGpp()<CR>
    map <silent> <F5> :call ComplieX()<CR>
    map <silent> <F7> :call RunX()<CR>
" make
    autocmd FileType c,cpp map <silent> <leader><space> :make<CR>
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

"   更新最近修改时间和文件名
"   以后考虑使用查找替换字符串函数来优化这段代码 ##
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
"   BufExplorer
""""""""""""""""""""""""""""""
    let g:bufExplorerDefaultHelp=0       " Do not show default help.
    let g:bufExplorerShowRelativePath=1  " Show relative paths.
    let g:bufExplorerSortBy='mru'        " Sort by most recently used.
    let g:bufExplorerSplitRight=0        " Split left.
    let g:bufExplorerSplitVertical=1     " Split vertically.
    let g:bufExplorerSplitVertSize = 30  " Split width
    let g:bufExplorerUseCurrentWindow=1  " Open in new window.
    autocmd! BufWinEnter \[Buf\ List\] setl nonumber 
"}}}

"{{{
"   vimwiki.vim
""""""""""""""""""""""""""""""""
""{{{    vimwiki rc
"        let g:vimwiki_use_mouse = 1 
"    "   对中文用户来说，我们并不怎么需要驼峰英文成为维基词条 , 0为关闭；1为开启
"        let g:vimwiki_camel_case = 0 
"    "   是否开启按语法折叠 会让文件比较慢,0为禁用折叠
"        let g:vimwiki_folding = ""
"        
"    "   删除当前页 
"        map <Leader>dd <Plug>VimwikiDeleteLink 
"    "   更改当前页的名称 
"        map <Leader>rr <Plug>VimwikiRenameLink
"    "   对[]中的选中切换 
"        " map <leader>do <Plug>VimwikiToggleListItem
"        "nnoremap <leader>
"    "   待办事项的高亮，在vimwiki中
"        " let g:vimwiki_hl_cb_checked = 1
"    "   创建复选框
"        " let g:vimwiki_auto_checkbox = 1
"    "   将换行符转换成<br />
"        " let g:vimwiki_list_ignore_newline = 0
"    "   map <Leader><Enter> <Plug>VimwikiFollowLink
"    "   <Plug>有种覆盖原来映射的感觉
"
"    "   0为不删除，1为删除
"        " let g:vimwiki_delete_html = 0
"
""   声明可以在wiki里面使用的HTML标签
"        let g:vimwiki_valid_html_tags ='a,img,b,i,s,u,sub,sup,br,hr,div,del,code,
"                    \red,center,left,right,!--,p,
"                    \h1,h2,h3,h4,h5,h6,pre,script,style,form,
"                    \blockquote,ol,ul,object,embed,dt,dd'
"        let g:vimwiki_file_exts ='pdf,txt,doc,docx,rtf,xls,php,zip,rar,7z,html,gz'
"        " let g:vimwiki_ext2syntax    = {'.mkd': 'markdown'}
"    "   let g:vimwiki_html_header_numbering = 1
"    "   如果希望 html 中的标题带上自动编号，设置这个选项，1表示1级标题编号，2表示
"    "   二级标题编号，0表示不编号(默认)
"        " map <S-F2> :VimwikiAll2HTML<cr>
"        " map <F2> :Vimwiki2HTML<cr>
"    "}}}
"
""   创建站点wiki_blog"{{{
"    let blog = {}
"    if MySys() == "windows"
"        let blog.path        = g:ywl_path.'\vimwiki\wiki\'
"        let blog.path_html   = g:ywl_path.'\vimwiki\'
"        let blog.template_path=g:ywl_path.'\vimwiki\template\'
""       let blog.html_header = g:ywl_path.'\vimwiki\template\header.tpl'
""       let blog.html_footer = g:ywl_path.'\vimwiki\template\footer.tpl'
"    elseif MySys() == "linux"
"        let blog.path        = g:ywl_path.'/vimwiki/wiki/'
"        let blog.path_html   = g:ywl_path.'/vimwiki/'
"        let blog.template_path=g:ywl_path.'/vimwiki/template/'
""       let blog.html_header = g:ywl_path.'/vimwiki/template/header.tpl'
""       let blog.html_footer = g:ywl_path.'/vimwiki/template/footer.tpl'
"    endif
"    let blog.template_default = 'site'
"    let blog.template_ext     = '.htm'
"    let blog.auto_export      = 0
"    let blog.diary_link_count = 5
"    let blog.css_name         = 'style.css'
"    " let blog.ext              = '.mkd'
"    " let blog.syntax           = 'markdown'
"    let blog.nested_syntaxes  = {'python': 'python', 'c++': 'cpp','html': 'html',}
""}}}
"
""   创建站点mkd_wiki"{{{
"    let g:mkd_wiki = {}
"    if MySys() == "windows"
"        let mkd_wiki.path        = g:ywl_path.'\mkd_vimwiki\'
"        let mkd_wiki.path_html   = g:ywl_path.'\mkd_vimwiki\html\'
"        let mkd_wiki.template_path=g:ywl_path.'\mkd_vimwiki\template\'
""       let mkd_wiki.html_header = g:ywl_path.'\mkd_vimwiki\template\header.tpl'
""       let mkd_wiki.html_footer = g:ywl_path.'\mkd_vimwiki\template\footer.tpl'
"    elseif MySys() == "linux"
"        " let mkd_wiki.path        = '~/mkd_vimwiki/'
"        " let mkd_wiki.path_html   = '~/mkd_vimwiki/html/'
"        " let mkd_wiki.template_path='~/mkd_vimwiki/template/'
"        let mkd_wiki.path        = g:ywl_path.'/mkd_vimwiki/'
"        let mkd_wiki.path_html   = g:ywl_path.'/mkd_vimwiki/html/'
"        let mkd_wiki.template_path=g:ywl_path.'/mkd_vimwiki/template/'
""       let mkd_wiki.html_header = g:ywl_path.'/mkd_vimwiki/template/header.tpl'
""       let mkd_wiki.html_footer = g:ywl_path.'/mkd_vimwiki/template/footer.tpl'
"    endif
"    let mkd_wiki.template_default = 'site'
"    let mkd_wiki.template_ext     = '.htm'
"    let mkd_wiki.auto_export      = 0
"    let mkd_wiki.diary_link_count = 5
"    let mkd_wiki.css_name         = 'style.css'
"    let mkd_wiki.ext              = '.mkd'
"    let mkd_wiki.syntax           = 'markdown'
"    let mkd_wiki.nested_syntaxes  = {'python': 'python', 'c++': 'cpp','html': 'html',}
"
"    let g:vimwiki_list = [mkd_wiki,blog]
""}}}
""}}}

"{{{
"   snipMate
"   let g:snips_author = 'MelonLin'
"   if MySys() == 'windows'
"       let g:snippets_dir=g:ywl_path.'\vimfiles\snippets\'
"   elseif MySys() == 'linux'
"       let g:snippets_dir=g:ywl_path.'/vimfiles/snippets/'
"   endif
"}}}

"{{{
"   Yggdroot/vim-mark
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

"{{{
"   winManager setting
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

"   Trinity of wesleyche"{{{
"   " Open and close all the three plugins on the same time 
"   nmap <F8>  :TrinityToggleAll<CR> 
"
""  Open and close the Source Explorer separately 
"   nmap <F9>  :TrinityToggleSourceExplorer<CR> 
"
""}}}

"   Txtbrowser"{{{
"   定制自己的搜索引擎:h txt-search-engine
    " let Txtbrowser_Search_Engine='https://www.google.com.hk/#newwindow=1&q=text&safe=strict'
"   定制自己的词典:h txt-dict
    " let TxtBrowser_Dict_Url='http://dict.youdao.com/search?q=text&keyfrom=dict.index'
"}}}

"{{{
"   FromtonRouge/OmniCppcomplete.vim
""""""""""""""""""""""""""""""
"}}}
"}}}
