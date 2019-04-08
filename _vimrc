" version : 1.0
" Author : WiZero(<ywlbupt@163.com>)
" LastUpdate : 2016-09-17 13:56:35
" Description : vimrc

" Initial setting"{{{
" -----------------------------------------------------------------------------
"  < 判断操作系统是否是 Windows 还是 Linux >
" -----------------------------------------------------------------------------
function! MySys()
    if(has('win32') || has('win64') || has('win95') || has('win16'))
        return 'windows'
    elseif has('unix')
        return 'linux'
    endif
endfunction

if MySys() == 'linux'
    let g:os_sep = '/'
elseif MySys() == 'windows'
    let g:os_sep = '\'
endif


"""""""""""""""
"  v:virable  "
"""""""""""""""

if !exists("$VIMY")
    let $VIMY = expand('~/Vim_ywl')
endif

if !exists("$VIMFILES")
    let $VIMFILES = expand('$VIMY/vimfiles')
endif
let $PLUG = expand("$VIMFILES/plugged")
let $SETTING = expand("$VIMFILES/setting_of_plugin")
let $CTAGS_WIN = expand("$VIMY/Archive_gvim/ctags.exe")

let $CPPPRJ = expand("$HOME/git_repos/Alg_C_Exercise")

"""""""""""""
"   个人文件夹路径的设定
"""""""""""""

if MySys() == 'linux'
    set runtimepath=$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after
    set runtimepath+=$HOME/vimfiles,$HOME/vimfiles/after
    set runtimepath+=$VIMFILES,$VIMFILES\after
elseif MySys() == 'windows'
    set runtimepath=$VIM\vimfiles,$VIMRUNTIME,$VIM\vimfiles\after
    set runtimepath+=$HOME\vimfiles,$HOME\vimfiles\after
    set runtimepath+=$VIMFILES,$VIMFILES\after
endif
" Set mapleader & Fast edit vimrc
let   mapleader = ","
let g:mapleader = ","

if has("nvim")
let g:python3_host_prog='C:\Anaconda3\python.exe'
set clipboard=unnamed
endif


" vim 801 feature support :terminal and termdebu
" man: switch to terminal-normal mode <C-W> N
" if (v:version >= 800 && (!has('nvim')))
if has("terminal")
    let g:term_support = 1
else
    let g:term_support = 0
endif

let g:term_support = has("terminal")



"}}}

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
    "   Fast reloading of the .vimrc
    if exists("$MYVIMRC") && exists("$VIMY")
        nnoremap <silent> <leader>ss :exec 'source '.expand('$VIMY/_vimrc')<cr>
        nnoremap <silent> <leader>rr :source $MYVIMRC<cr>
    "   Fast editing of .vimrc
        nnoremap <silent> <leader>ee :exec 'edit '.expand('$VIMY/_vimrc')<cr>
        nnoremap <silent> <leader>eb :exec 'edit '.expand('$VIMY/vimrc_plugged.vim')<cr>
        nnoremap <silent> <leader>er :edit $MYVIMRC<cr>
    else
        echom exists("$MYVIMRC")?"$MYVIMRC": "$VIMY"."$VIMRC not define"
        finish
	endif

"}}}

" Load Plugin and Customed_Func "{{{

" filtetype open "{{{
""""""""""""""""""""
set nocompatible    " required
" 检测文件类型
filetype on
" 针对不同的文件类型采用不同的缩进格式
filetype indent on
" 允许插件
filetype plugin on
" 启动自动补全
filetype plugin indent on
"}}}
if filereadable(expand('$VIMY/vimrc_plug_list.vim'))
    exec 'source '.expand('$VIMY/vimrc_plug_list.vim')
else
    echo 'No vimrc_plug_list found'
endif

if filereadable(expand('$VIMY/vimrc_plugged.vim'))
    exec 'source '.expand('$VIMY/vimrc_plugged.vim')
else
    echo 'No vimrc_plugged found'
endif

if filereadable(expand('$VIMY/vimrc.func'))
    exec 'source '.expand('$VIMY/vimrc.func')
else
    echo 'No vimrc.func found'
endif
"  matchit.vim插件扩展了%匹配字符的范围,根据不同的filetype来做不同的匹配
    source $VIMRUNTIME/macros/matchit.vim
"}}}

" Base Setting "{{{
" Basic{{{
    set hidden " 允许在有未保存的修改时切换缓冲区，此时的修改由 vim 负责保存
    set history =1000
    " vim命令行补全增强，显示所有匹配的命令或文件名。
    " set wildmode=list:longest
    " Ignore compiled files

    " set wildignore+=*/node_modules/*,_site,*/__pycache__/,*/venv/*,*/target/*,*/.vim$,\~$,*/.log,*/.aux,*/.cls,*/.aux,*/.bbl,*/.blg,*/.fls,*/.fdb*/,*/.toc,*/.out,*/.glo,*/.log,*/.ist,*/.fdb_latexmk
    " 增强模式中的命令行自动完成操作
    set wildmenu
    " 这个貌似会影响到YCM
    " set completeopt=longest,menu
    set completeopt=menu,menuone
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
        " autocmd! BufEnter * silent! lcd %:p:h:gs/ /\\ /
        "开/tmp文件夹下的文件时不自动切换，则设置如下：
        "autocmd! BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif
    endif

    set backupcopy=yes " 设置备份时的行为为覆盖
    set noerrorbells " 关闭错误信息响铃
    set novisualbell " 关闭使用可视响铃代替呼叫
    " 置空错误铃声的终端代码,set silent (no beep)
    set t_vb=

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
      let b:_line=getline(v:foldstart)
      let b:foldcms_1=substitute(&commentstring,'%s',get(split(&foldmarker,','),0),"")
      " if matchstr(b:_line,'^\s*'.a:foldcms_1)!=""
      if '^\s*'.b:foldcms_1=~b:_line
      "if b:_line==a:foldcms_1
          let b:_line=getline(v:foldstart+1)
      endif
      let sub=substitute(b:_line, b:foldcms_1, '', 'g')
      return v:folddashes.sub
      " return b:line
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
    " nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
"}}}

    set viewoptions=cursor,folds,slash,unix
"}}}

" Advanced base setting"{{{
" ref : https://github.com/wsdjeg/vim-galore-zh_cn
    " 防止水平滑动的时候失去选择
    xnoremap <  <gv
    xnoremap >  >gv
    " 快速添加空行, 设置之后，连续按下 5 [ 空格 在当前行上方插入 5 个空行。
    " 这里的  'yel' 字符常量必须为单引号
    " :<c-u>put=printf('yel'))<cr>
    nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
    nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>
    " 智能 Ctrl-l
    " Ctrl + l 的默认功能是清空并「重新绘制」当前的屏幕，就和 :redraw!
    " 的功能一样。下面的这个映射就是执行重新绘制，并且取消通过 / 和 ?
    " 匹配字符的高亮，而且还可以修复代码高亮问题（有时候，由于多个代码高亮的脚本重叠，或者规则过于复杂，Vim
    " 的代码高亮显示会出现问题）。不仅如此，还可以刷新「比较模式」
    nnoremap <c-l> :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr>:redraw!<cr>
    " 命令行下的上下条目映射
    cnoremap <c-n> <down>
    cnoremap <c-p> <up>
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

    set autoindent
    " set whichwrap = b,s,<,>,[,]
    " set backspace=indent,eol,start
    set backspace=indent,eol,start
"}}}

" Text Encoding "{{{
    set fileformats=unix,dos
    " 缩略 set ffs = unix,dos
    set fileformat =unix

    if MySys() == "windows"
        set langmenu=zh_CN.UTF-8
        " language message zh_CN.UTF-8
        set encoding=utf-8
        let &termencoding=&encoding
        " set termencoding =GBK
        set termencoding =GBK
        set fileencodings=utf-8,ucs-bom,gb18030,cp936,big5,euc-jp,euc-kr,latin1
        set fileencoding=utf-8
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
    " exec 'cd '.$VIMY
    exec 'cd '.$CPPPRJ

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
    " nnoremap <F2> :exec exists('g:syntax_on') ? 'syn off' : 'syn enable'<CR>
    " F3 显示可打印字符开关
    " nnoremap <F3> :set list! list?<CR>
    " set paste的Toggle，有格式的代码粘贴
    set pastetoggle=<F6>
    " disbale paste mode when leaving insert mode
    au InsertLeave * set nopaste

    " Quickly close the current window
    nnoremap <silent><leader>q :call Uclose()<cr>
    function! Uclose()
        if winnr('$')==1 | call terminal#all_terms_exit() | endif 
        q
    endfunc

    " Quickly save the current file
    nnoremap <leader>w :w<CR>

    " remap U to <C-r> for easier redo
    nnoremap U <C-r>

    " 方便书签的跳转
    nnoremap ' `
    nnoremap ` '
    " mapping
    " inoremap <expr> <CR> pumvisible()?"\<C-Y>":"\<CR>"
    " 如果下拉菜单弹出，回车映射为接受当前所选项目，否则，仍映射为回车
    if count(g:plugin_function_groups, 'delimitMate')
        imap <expr> <CR> pumvisible()?"\<C-Y>":"<Plug>delimitMateCR"
    else
        inoremap <expr> <CR> pumvisible()?"\<C-Y>":"\<CR>"
    endif
    " 如果下拉菜单弹出，CTRL-U映射为CTRL-E，即停止补全，否则，仍映射为CTRL-U
    " inoremap <expr> <C-U> pumvisible()?"\<C-E>":"\<C-U>"

    " vim default mapping
    " inoremap <c-[> <ESC>
    " inoremap <c-h> <BS>
    " <C-O>    : 依次沿着你的跳转记录向回跳 (从最近的一次开始)
    " <C-I>    : 依次沿着你的跳转记录向前跳
    " :ju(mps) : 列出你跳转的足迹

"{{{ " 自定义／个性化快捷键
" 关于tab buffer 的快捷键
" 跳转，翻页 向下翻半夜  向上翻半夜
" Tab操作快捷方式!
    " nnoremap <C-TAB> :tabnext<CR>
    " nnoremap <C-S-TAB> :tabprev<CR>
    " nnoremap gn :tabnext<CR>
    " nnoremap gp :tabprev<CR>
    " nnoremap <C-t> :tabnew<cr>
    " nnoremap <C-e> :tabclose<cr>
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
    " buffer mapping
    nnoremap <leader>bn :bn<CR>
    nnoremap <leader>bp :bp<CR>
    nnoremap <leader>bd :bd<CR>

    nnoremap <leader>on :only<CR>
"}}}

"{{{
" Smart way to move .btw. windows
" 关于窗口的扩大缩小, :help window-resize
    " noremap <C-j> <C-W>j
    " noremap <C-k> <C-W>k
    " noremap <C-h> <C-W>h
    " noremap <C-l> <C-W>l
    
    inoremap <C-h> <Left>
    inoremap <C-l> <Right>
    inoremap <C-j> <Down>
    inoremap <C-k> <Up>

    " 这个可以用 <C-W>替代
    " <C-B>插入模式下一次性删除一个词
    " inoremap <c-b> <c-o>diw


" Treat long lines as break lines (useful when moving around in them)
    nnoremap j gj
    nnoremap k gk
"}}}

"{{{
" Quickfix
""""""""""""""""""""""""""""""
    " nnoremap <leader>cn :cn<cr>
    " nnoremap <leader>cp :cp<cr>
"}}}

"}}}

" term && gui_running 此行需要在syntax on 之前配置 "{{{
    if exists('g:syntax_on')
        syn off
    endif
    " 这几行会被colorscheme覆盖
    " highlight WhitespaceEOL ctermbg=red guibg=red
    " match WhitespaceEOL /\s\+$/
    " highlight WhitespaceHOL ctermbg=red guibg=red
    " match WhitespaceHOL /^\s\+/
    set cursorline
    " set termguicolors " 会导致term下显示异常
    " set cursorcolumn "突出当前列

    " 使用鼠标操作
    set mouse=cvn

    if has("gui_running")
        set guioptions-=T " 隐藏工具栏
        set guioptions-=m " 隐藏菜单栏
        set guioptions-=L
        " set guioptions-=r
        autocmd GUIEnter * set lines=40 |  set columns=149
        if MySys() == 'linux'
            "exec "winpos 400 70"
        endif
    elseif has ("nvim")
        set t_Co=256
        set guioptions-=T " 隐藏工具栏
        set guioptions-=m " 隐藏菜单栏
        set guioptions-=L
        " set guioptions-=r
        autocmd GUIEnter * set lines=40 |  set columns=149
    else
        " set t_Co=16
        if &term =~ "xterm"
            " set t_Sb=^[[4%dm " 设置背景色
            " set t_Sf=^[[3%dm " 设置前景色
            set t_Co=16
            autocmd VimEnter * set lines=40 | set columns=149
        endif
    endif

    " 防止tmux下vim的背景色显示异常
    " Refer: http://sunaku.github.io/vim-256color-bce.html
    if &term =~ '256color'
        " disable Background Color Erase (BCE) so that color schemes
        " render properly when inside 256-color tmux and GNU screen.
        " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
        set t_ut=
        set notimeout		" don't timeout on mappings
        set ttimeout		" do timeout on terminal key codes
        set timeoutlen=1000	" timeout after 100 msec
    endif

" 开启语法高亮
    syntax on
"}}}

" Autocmd "{{{
if has("autocmd")
    augroup ccevent
        autocmd! ccevent 
        autocmd FileType c,cs,java,perl,
                    \shell,bash,cpp,python,vim,php,ruby  setlocal cc=81
    augroup END

    augroup htmlevent
        autocmd! htmlevent
        autocmd BufRead,BufNewFile *.html
                    \setlocal tabstop=2 |
                    \setlocal softtabstop=2 |
                    \setlocal shiftwidth=2 |
                    \setlocal cc=81
    augroup END

    augroup cppevent
        autocmd! cppevent
        autocmd! FileType c,cpp setlocal smartindent |
                        \setlocal tabstop=2 |
                        \setlocal softtabstop=2 |
                        \setlocal shiftwidth=2 |
    augroup END
    " auto FileType c,cpp  set cindent " Strict rules for C Programs
    " set smartindent " 开启行时使用智能自动缩进，为C程序
    " indent: 如果用了:set indent,
        " :set ai 等自动缩进，想用退格键将字段缩进的删掉，必须设置这个选项。否则不响应。
    " eol:如果插入模式下在行开头，想通过退格键合并两行，需要设置eol。
    " start：要想删除此次插入前的输入，需设置这个。

    augroup xml_fold
        autocmd! xml_fold
        autocmd BufReadPre *.xml
                    \let g:xml_syntax_folding = 1 |
                    \setlocal foldmethod=syntax |
                    \setlocal cc=81
    augroup END


    au! BufNewFile,BufRead *.swig,*.ejs set filetype=javascript

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
                        \nnoremap <buffer> <leader>p :!google-chrome "%:p"<CR>
        elseif MySys() == 'windows'
            " autocmd Filetype html,xml,xsl source $HOME\vimfiles\plugin\closetag.vim
            " autocmd Filetype matlab source $HOME\vimfiles\syntax\matlab.vim|set cms=%\ %s
            " autocmd BufEnter *.m compiler mlint
            autocmd BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn,html}
                        \nnoremap <buffer> <Leader>p :exec "!start ".g:path_chrome." %:p"<CR>
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
                    \ setlocal fileformat=unix |
                    \ let b:match_words = '\<if\>:\<elif\>:\<else\>'
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

" vim81 :terminal support"{{{
if g:term_support
    " SecureCRT 中使用 Vim 8 内嵌终端如看到奇怪字符，使用 :set t_RS= t_SH= 解决
    if &term =~ 'xterm'
        set t_RS= t_SH=
    endif

    au TerminalOpen * if &buftype == 'terminal' | setlocal bufhidden=hide | set nobuflisted | endif
endif
"}}}

" archived operation
" echohl WarningMsg | echom 'You need to install git!' | echohl None
