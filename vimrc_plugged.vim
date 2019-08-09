" Dependency
" python : [flake8](http://flake8.readthedocs.io/en/latest/#quickstart)
" project root markers, used for gutentags and asyncrun

let b:project_marker_list = ['.root', '.svn', '.git', '.project']
set wildignore=*.o,*~,*.pyc,*.class,*.so,*.swp,*.zip

" altercation/vim-colors-solarized" "主题方案"{{{
    " if g:colors_name == 'solarized'
    " 非gui模式的时候
    if &term !~ "gui"
        let g:solarized_termcolors= 16
    endif
        let g:solarized_termtrans = 1
        let g:solarized_contrast = "normal"    " 'normal' 'high' or 'low'
        let g:solarized_visibility= "normal"
    " endif
"}}}

if count(g:plugin_function_groups, 'hexo')
    let g:hexo_blogpath = expand('~/hexo_blog')

endif

" vim-airline/vim-airline  "好看轻量级的powerline，不依赖python "{{{
    if count(g:plugin_function_groups, "airline")
        let g:airline_powerline_fonts = 1
        " let g:airline_theme = "base16_google"
        if MySys() == 'windows'
            set guifont=DejaVu_Sans_Mono_for_Powerline:h11:cANSI

        else
            if has("gui_gtk2")
                set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 11
            endif
        endif

        " tagbar和vim-airline冲突了
        let g:airline#extensions#tagbar#enabled = 0
        " 打开tabline功能,方便查看Buffer和切换，这个功能比较不错
        let g:airline#extensions#tabline#enabled = 1
        " let g:airline#extensions#tabline#show_splits = 1
        " let g:airline#extensions#tabline#show_buffers = 1
        " let g:airline#extensions#tabline#alt_sep = 1
        " show just the filename
        let g:airline#extensions#tabline#fnamemod = ":t"
        " show buffer number
        let g:airline#extensions#tabline#buffer_nr_show = 1
        if count(g:plugin_function_groups, "YouCompleteMe")
            " enable/disable YCM integration >
            let g:airline#extensions#ycm#enabled = 1
            " set error count prefix >
            let g:airline#extensions#ycm#error_symbol = 'E:'
            " set warning count prefix >
            let g:airline#extensions#ycm#warning_symbol = 'W:'
        endif
        " enable/disable detection of whitespace errors. >
        let g:airline#extensions#whitespace#enabled = 1
        " must be all spaces or all tabs before the first non-whitespace character
        let g:airline#extensions#whitespace#mixed_indent_algo = 0
    endif

"}}}

" colorscheme "{{{
try
    " exec 'colorscheme solarized'
    exec 'colorscheme gruvbox'
    " exec 'colorscheme github'
catch
    exec 'colorscheme desert'
endtry
    exec 'set background=light'
"}}}

" vim-scripts/Load_Template file setting " 模板文件"{{{
    let g:template_path = join([$PLUG, 'load_template','template'], g:os_sep)
" Load_template 说明
" 1. 静态模板文件中，`TEMPLATE_CURSOR`标明载入模板后光标所在位置
" 2. 动态模板，Vim 脚本放置在`EXE_BEGIN_TEMPLATE (NEEDNEW)``EXE_END_TEMPLATE`
"}}}

" scrooloose/nerdtree  " 侧边文件导航栏 "{{{

" The-NERD-Tree / netrw setting "{{{
    let g:netrw_nogx = get(g:, 'netrw_nogx', 1) " disable netrw's gx mapping.
    let g:netrw_winsize = 31
    " Vexplore!为在左侧打开netrw
    " nnoremap <silent> <leader>fe :Vexplore<cr>
    nnoremap <silent> <leader>fe :NERDTreeToggle<cr>

    " 设置书签目录
    let g:NERDTreeBookmarksFile = expand('$VIMFILES/plugindata/NERDTreeBookmarks.txt')
    " 将 NERDTree 的窗口设置在 vim 窗口的右侧（默认为左侧）
    let  g:NERDTreeWinPos="right"
    " 当打开 NERDTree 窗口时，自动显示 Bookmarks
    let g:NERDTreeShowBookmarks=1
    " 让Tree把自己给装饰得多姿多彩漂亮点
    let g:NERDChristmasTree=1
    let g:NERDTreeWinSize=40
    " 当输入 [:e filename]不再显示netrw,而是显示nerdtree
    let g:NERDTreeHijackNetrw=1
    " Nerdtree Display line numbers
    let NERDTreeShowLineNumbers=1
    " 处理文件夹下单一文件夹的显示
    let NERDTreeCascadeOpenSingleChildDir=0
    " When to Change the current Working directory (CWD) for vim
    let NERDTreeChDirMode = 2
    " Don't show these file types
    let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
    " " Change default arrows
    " let g:NERDTreeDirArrowExpandable = '▸'
    " let g:NERDTreeDirArrowCollapsible = '▾'

    " " Note: Now start vim with plain `vim`, not `vim .`
    " if has("autocmd")
        " autocmd StdinReadPre * let s:std_in=1
        " autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    " endif
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

" Raimondi/delimitMate : 自动补全括号 "{{{
" --------Brief help------------
" <BS>         is mapped to <Plug>delimitMateBS
" <S-BS>       is mapped to <Plug>delimitMateS-BS
" <S-Tab>      is mapped to <Plug>delimitMateS-Tab
" <C-G>g       is mapped to <Plug>delimitMateJumpMany
if count(g:plugin_function_groups, "delimitMate")
    " let g:delimitMate_matchpairs = "(:),[:],{:}"
    imap <BS> <Plug>delimitMateBS
    let delimitMate_matchpairs = "(:),[:],{:},<:>"
    let g:delimitMate_expand_cr = 1
    let g:delimitMate_expand_space = 1
    " 关闭某类型文件的自动补全
    " au FileType mail,text let b:delimitMate_autoclose = 0
    " for python docstring ",优化输入
    augroup delimitMateevent
        autocmd! delimitMateevent
        au FileType python let b:delimitMate_nesting_quotes = ['"']
        au FileType c,cpp let b:delimitMate_matchpairs = "(:),[:],{:}"
        au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}
            \ let b:delimitMate_quotes = "' ` \"" |
            \ let b:delimitMate_excluded_regions = " "
    augroup END
endif

"}}}

" Valloric/YouCompleteMe" 可能是最好用的自动补全工具 TODO:syntastic"{{{
    " Turn on or off YCM
    " 主动补全：<c-space>
if count(g:plugin_function_groups, 'YouCompleteMe')
    nnoremap <silent> <leader>ry :YcmRestartServer<cr>
    let g:ycm_key_list_stop_completion = ['<C-y>']
    " nnoremap <leader>y :let g:ycm_auto_trigger=0<cr> "turn off YCM nnoremap
    " nnoremap <leader>Y :let g:ycm_auto_trigger=1<cr> "turn on YCM nnoremap
    " let g:ycm_python_binary_path = '/home/ywl/.pyenv/versions/anaconda3-2.4.0/bin/python'
    let g:ycm_python_binary_path = 'python'
    if MySys() == 'windows'
        " Only used for ycm server, default to use python embemdded in vim
        let g:ycm_server_python_interpreter = 'C:/Anaconda3/python'
    endif

    let g:ycm_global_ycm_extra_conf = $SETTING.g:os_sep.'.ycm_extra_conf_backup.py'
    " make YCM compatible with UltiSnips (using supertab)
    " c-k, c-j is Ok
    let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
    let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

    let g:ycm_add_preview_to_completeopt = 0
    let g:ycm_error_symbol = '>>'
    let g:ycm_warning_symbol = '>*'
    let g:ycm_complete_in_comments = 1  "在注释输入中也能补全
    let g:ycm_complete_in_strings = 1   "在字符串输入中也能补全
    " 注释和字符串中的文字也会被收入补全
    let g:ycm_collect_identifiers_from_comments_and_strings = 1
    let g:ycm_collect_identifiers_from_tags_files = 1
    " nnoremap <F4> :YcmDiags<CR>
    " 往前跳和往后跳的快捷键为Ctrl+O以及Ctrl+I
    " 开启语法关键字补全
    let g:ycm_seed_identifiers_with_syntax=1
    " 黑名单策略
    let g:ycm_filetype_blacklist = {'tagbar': 1,}

    " 关闭语法检测提示
    let g:ycm_enable_diagnostic_signs = 0
    let g:ycm_enable_diagnostic_highlighting = 0
    let g:ycm_show_diagnostics_ui = 0
    " 语义补全的触发
    let g:ycm_semantic_triggers =  {
                \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
                \ 'cs,lua,javascript': ['re!\w{2}'],
                \ }
    " let g:ycm_filetype_whitelist = {
                " \ "c":1,
                " \ "cpp":1,
                " \ "python":1,
                " \ "markdown":1,
                " \ "vim":1,
                " \ "objc":1,
                " \ "sh":1,
                " \ "zsh":1,
                " \ "zimbu":1,
                " \ }
endif
"}}}

" coc.nvim "{{{
if count(g:plugin_function_groups, "coc.nvim")
    inoremap <silent><expr> <c-space> coc#refresh()
endif
"}}}

" SirVer/UltiSnips "{{{
    " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsListSnippets="<c-tab>"

    let g:UltiSnipsJumpForwardTrigger="<tab>"
    let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

    " If you want :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit="vertical"
    " 进入对应filetype的snippets进行编辑
    map <leader>eu :UltiSnipsEdit<CR>
    " Explicityly tell UltiSnips To use python version 3.x
    " let g:UltiSnipsUsePythonVersion = 2
    " Snippets的文件夹名字，查找rtp路径下的UltiSnips文件夹< plugin vim-snippets
    let g:UltiSnipsSnippetDirectories = ["UltiSnips"]
    let g:UltiSnipsSnippetsDir = expand('$VIMFILES/UltiSnips')

    " set 0 to use snippets in both UltiSnips and snippets
    " let g:UltiSnipsEnableSnipMate = 0
"}}}

" xolox/vim-session" 会话，工作区保留"{{{
" --------Brief help------------
" :SaveSession sessionname  - 如果不提供sessionname，默认保存为default会话
" :OpenSession sessionname  - 如果不提供sessionname，默认打开default会话
" :CloseSession  - 关闭当前会话，关闭所有标签，打开一个空缓冲区
" :DeleteSession - 关闭会话，当前标签保留

" Session保存路径
"   g:os_sep
    let g:session_directory=expand('$VIMFILES/Workspace')

    " 每次打开空Vim，不提示是否打开 default session
    let g:session_autoload='no'

    " 每次退出session时，是否提示保存会话
    let g:session_autosave='no'

    " 每十分钟自动保存Session
    " let g:session_autosave_periodic = 10
"}}}

" SimpylFold " Python 的智能折叠 "{{{
    let g:SimpylFold_docstring_preview=1
"}}}

" fs111/pydoc " python帮助文档 "{{{
" --------Brief help------------
" <c-k> 快捷键查询光标下的帮助文档
    let g:pydoc_cmd = "python -m pydoc"
    "
    let b:pydoc_width = '70 '
    let g:pydoc_open_cmd = b:pydoc_width.'vsplit'
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

" tpope/vim-surround.vim " 快速增加括号／引号／自定义符号"{{{
" :echo char2nr('-')=45
" :echo char2nr('=')=61
" :echo char2nr('b')=98

    let g:surround_indent = 0
    let g:surround_45 = "```\r```"
    " let g:surround_45 = "```\n\r```"
    let g:surround_61 = "~~\r~~"
    let g:surround_98 = "**\r**"
"}}}

" plasticboy/vim-markdown : markdown　syntax"{{{
"TODO 我修改了原文件中 Toc的打开命令,ftplugin中,vertical topleft lopen
" --------Brief help------------
" :Toc " 左侧打开目录栏quickfix Windows
    " set the initial foldlevel
    let g:vim_markdown_initial_foldlevel=2
    " Markdown Toc width autofit
    let g:vim_markdown_toc_autofit = 1
    " 列表的自动缩进
    let g:vim_markdown_new_list_item_indent = 0
    " g:vim_markdown_folding_level' setting is not active with this fold style.
    let g:vim_markdown_folding_style_pythonic = 1
    " Highlight YAML front matter as used by Jekyll or Hugo [7].
    let g:vim_markdown_frontmatter = 1
    " 链接的显示方式
    " let g:vim_markdown_conceal = 0
    " 隐藏链接
    " set conceallevel =2
    " Disable vim-markdown mapping :1 disable ; 0: enable
    let g:vim_markdown_no_default_key_mappings = 1
    " if g:vim_markdown_no_default_key_mappings
        " map ]u <Plug>Markdown_MoveToParentHeader
        " map [[ <Plug>Markdown_MoveToPreviousSiblingHeader
        " map ]] <Plug>Markdown_MoveToNextSiblingHeader
    " endif
"}}}

" scrooloose/nerdcommenter" 代码注释 :TODO "{{{
" --------Brief help------------
" <leader>cc  - Comment out the current line or text selected in visual mode.
" <leader>cn  - Nested Comment
" <leader>cu  - Uncomments
" <leader>cm  - multiple line NERDComMinimalComment 包裹性的注释时管用

    " Add spaces after comment delimiters by default
    let g:NERDSpaceDelims = 0
    let g:NERDDefaultAlign = 'none'
    let NERDCreateDefaultMappings = 1

    let g:NERDCustomDelimiters = { 'vim': { 'left': '" ' },
                \ 'cpp': {'left':'// ', 'leftAlt':'/* ', 'rightAlt':' */'},
                \ 'c': {'left':'// '}
                \ }
    " unmap该快捷键的想法是尽量让十指不离开主键盘区太远
    " nmap \\\ <Plug>NERDCommenterToggle
    " xmap \\ <Plug>NERDCommenterToggle
    nmap <leader>cc <plug>NERDCommenterComment
    xmap <leader>cc <plug>NERDCommenterComment
    nmap <leader>cu <plug>NERDCommenterUncomment
    xmap <leader>cu <plug>NERDCommenterUncomment
    xmap <leader>cm <Plug>NERDComMinimalComment
"}}}

" tpope/vim-fugitive " tpope 大神的git wrapper，gvdiff 同步滚动"{{{
" 快捷键
    nnoremap <leader>ge :Gvdiff<CR>
    " :only<cr>

"}}}

" airblade/gitgutter　同用于git diff "{{{
" 神器，与fugitive的区别在于，gitgutter单窗口较之前的文件显示
" 修改，增加，和删除。且可能单独的就某处修改staged/undo
" --------Brief help------------
" ]c : jump to next hunk (change):
" [c : jump to previous hunk (change):
" <leader>hs : staged the hunk where cursor in it
" <leader>hu : undo it
    " 同git diff,实时展示文件中修改的行
    " 只是不喜欢除了行号多一列, 默认关闭,gs时打开
    let g:gitgutter_map_keys = 0
    let g:gitgutter_enabled = 0
    let g:gitgutter_highlight_lines = 1
    " customed mapping
    " nmap [c <Plug>GitGutterPrevHunk
    " nmap ]c <Plug>GitGutterNextHunk
    " nmap <Leader>gs <Plug>GitGutterStageHunk
    " nmap <Leader>gu <Plug>GitGutterUndoHunk
    nmap <Leader>gp <Plug>GitGutterPreviewHunk
    nmap <leader>gn <Plug>GitGutterNextHunk
    nnoremap <leader>gs :GitGutterToggle<CR>
    command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                \ | wincmd p | diffthis
"}}}

" sjl/gundo.vim 打开quickfix窗口查看修改历史"{{{
    noremap <leader>hs :GundoToggle<CR>
" }}}

" majutsushi/tagbar"{{{
    if count(g:plugin_function_groups, "tagbar")
        nnoremap <silent> <F8> :TagbarToggle<CR>
        " 打开Tagbar窗口后自动focus到Tagbar窗口
        let g:tagbar_autofocus = 1
        " Tagbar 显示行号
        let g:tagbar_show_linenumbers = 1
        " Set Windows Width
        let g:tagbar_width = 35
        " tagbar 默认显示在右边，如需令其在左边显示，设置一下option
        let g:tagbar_left = 1

        " [Support for addtional filetype](https://github.com/majutsushi/tagbar/wiki)
        " 自定义 tagbar 支持 markdown , g:tagbar_type_{vim filetype}
        " 这里的 markdown2ctags 需要是可执行文件，TODO : win下如何处理？
        if MySys() == "linux"
            let b:tagbar_tail = "py"
        elseif MySys() == 'windows'
            let b:tagbar_tail = "exe"
            let g:tagbar_ctags_bin = $CTAGS_WIN
        endif
        let g:tagbar_type_markdown = {
            \ 'ctagstype': 'markdown',
            \ 'ctagsbin' : expand('$VIMFILES/Tagbar_support/markdown2ctags.').b:tagbar_tail ,
            \ 'ctagsargs' : '-f - --sort=yes',
            \ 'kinds' : [
                \ 's:sections',
                \ 'i:images'
            \ ],
            \ 'sro' : '|',
            \ 'kind2scope' : {
                \ 's' : 'section',
            \ },
            \ 'sort': 0,
            \ }
    endif
"}}}

"{{{
" Ctags
" """"""""""""""""""""""""""""""
" 将当前的工程的tags导入
" 如果源文件在当前文件夹下没有找到tags,可以到它的上层目录下继续寻找
    " set tags=./tags;
    set tags=./.tags;,.tags
    " 解释一下，首先我把 tag 文件的名字从“tags” 换成了".tags"，
    " 前面多加了一个点，这样即便放到项目中也不容易污染当前项目的文件，删除时也好删除，
    " gitignore也好写，默认忽略点开头的文件名即可。
    " 前半部分 "./.tags;" 代表在文件的所在目录下（不是 “:pwd”返回的 Vim 当前目录）查找名字为".tags"的符号文件，
    " 后面一个分号代表查找不到的话向上递归到父目录，直到找到 .tags文件或者递归到了根目录还没找到
    " 这样对于复杂工程很友好，源代码都是分布在不同子目录中，而只需要在项目顶层目录放一个 ".tags"文件即可；
    " 逗号分隔的后半部分 .tags 是指同时在 Vim的当前目录（“:pwd”命令返回的目录，可以用 :cd ..命令改变）下面查找 .tags 文件。
    "
    " 少用 CTRL-] 直接在当前窗口里跳转到定义，多使用 CTRL-W ]
    " 用新窗口打开并查看光标下符号的定义，或者 CTRL-W } 使用 preview 窗口预览光标下符号的定义。
"}}}

" vim-easy-align"{{{

" start interactive easyalign in visual mode (e.g. vip<enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"}}}

"{{{
" vista.vim
if count(g:plugin_function_groups, "vista.vim")
    nnoremap <silent> <leader>tv :Vista!!<cr>
    " let g:vista_icon_indent = ["▸ ", "-> "]
    let g:vista_sidebar_position="vertica topleft"
    let g:vista_default_executive = 'ctags'
    " let g:vista_ctags_cmd = {
        " \ 'haskell': 'hasktags -o - -x',
        " \ }
        " \ 'cpp': 'ctags --c++-kinds=+pf --fields=+nKil --extras=+q -f -',
        " \ 'cpp': 'ctags --languages=c++ --format=2 --excmd=pattern --fields=nksSaf --extras=q --file-scope=yes --sort=no --append=no -f - ',
        " --options=/my/options/ctag
endif
"}}}

" leaderF "{{{
"   rg : ripgrep
"   move rg.exe to C:\windows\System32
"   vimrun 搜索路径
"   if executable

    if MySys() == "windows"
        let g:Lf_Ctags = $UCTAGS_WIN
    endif
    " preview code when navigating
    let Lf_WindowPosition = "bottom"
    let g:Lf_ShowRelativePath = 0
    let g:Lf_PreviewCode  = 0
    let g:Lf_PreviewResult = {
            \ 'File': 0,
            \ 'Buffer': 0,
            \ 'Mru': 0,
            \ 'Tag': 0,
            \ 'BufTag': 0,
            \ 'Function': 0,
            \ 'Line': 0,
            \ 'Colorscheme': 1
            \}
    let g:Lf_WildIgnore = {
            \ 'dir': ['.svn','.git','.hg'],
            \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
            \}

    let g:Lf_CtagsFuncOpts = {
            \ 'c': '--c-kinds=fp',
            \ 'cpp': '--c++-kinds=+px',
            \ 'rust': '--rust-kinds=f',
            \ }
    " function! LeaderfTag_cword()
        " let w = expand("<cword>") " 在当前光标位置抓词
        " exec 'LeaderfTag'
    " endfunction
    let g:Lf_ShortcutF = '<C-P>'
    noremap <c-n> :LeaderfMru<cr>
    nnoremap <leader>fu :LeaderfFunction!<cr>
    nnoremap <leader>ft :LeaderfBufTag!<cr>
    let g:Lf_RootMarkers = copy(b:project_marker_list)
    " search word recursive
    " nnoremap <leader>ff :Leaderf! rg --stayOpen -e
    if executable("rg")
        nnoremap <leader>ff :<C-U><C-R>=printf("Leaderf! rg --stayOpen -e ")<CR>
        " search word under cursor, the pattern is treated as regex, and enter normal mode directly
        nnoremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --stayOpen -e %s ", expand("<cword>"))<CR><CR>
        " search word under cursor literally only in current buffer
        nnoremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -F --stayOpen --current-buffer -e %s ", expand("<cword>"))<CR><CR>
    else
        echom "leaderf rg not install"
    endif
" }}}

" ctrlpvim/ctrlp.vim " 文件导航插件" && tacahiroy/ctrlp-funky {{{
" --------Brief help------------
" :CtrlP for file mode.
" :CtrlPBuffer  for buffer or find MRU file mode.
" :CtrlPMRU for Most Recently Used mode
" :CtrlPMixed to search in Files, Buffers and MRU files at the same time.

    " " c-j/k : 在导航窗口上下选择
    " " c-v : 垂直分屏打开选择文件
    " " c-x : 水平分屏打开文件
    " " c-z : 多选文件
    " " c-f/b : 在导航窗口进行模式的切换
    " " c-d : 在全路径搜索和文件名搜索间切换。
    " "  默认的mapping 与 Binding 的命令
    " let g:ctrlp_map = '<c-p>' | let g:ctrlp_cmd = 'CtrlP'
    " " Working diretory setting
    " " -r : diretory of current file
    " let g:ctrlp_working_path_mode = 'ra'

    " " NOTE: 这些ignore的内容在使用custom_command的时候不生效
    " set wildignore=*.o,*~,*.pyc,*.class,*.so,*.swp,*.zip
    " if MySys()=='linux'
        " set wildignore+=*/tmp/*,*/undodirfile/*,*/vimfiles/view/*
        " " set wildignore+=*/.git/* " 此处会和fugitive 冲突
        " " MacOSX/Linux Use a custom file listing command
        " " let g:ctrlp_user_command = 'find %s -type f'
    " elseif MySys()=='windows'
        " set wildignore+=*\\tmp\\*,*.exe,*\\undodirfile\\*,*\\vimfiles\\view\\*
        " " set wildignore+=*\\.git\\* " 此处会和fugitive 冲突
        " " Windows , Use a custom file listing command
        " " let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'
    " endif
    " let g:ctrlp_custom_ignore = {
        " \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
        " \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
        " \ }

" tacahiroy/ctrlp-funky complementary func navigator for ctrlp.vim"
    " nnoremap <Leader>fu :CtrlPFunky<Cr>
    " narrow the list down with a word under cursor
    " nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
"}}}

" vim-gutentags replace of easytags, work async Successful"{{{
    " gutentags插件启动后，会从文件当前路径递归往上查找 gutentags_project_root
    " 中指定的文件或目录名，直到第一次找到对应目标文件或目录名停止。若没有找到
    " gutentags_project_root
    " 变量指定的文件或目录名，则gutentags不会生成tag文件。
    " 想要避免的话，你可以在你的野文件目录中放一个名字为 .root 的空白文件，主动告诉 gutentags 这里就是工程目录。

    " gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
    " let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']
    let g:gutentags_project_root = copy(b:project_marker_list)

    "  所生成的数据文件的名称 "
    let g:gutentags_ctags_tagfile = '.tags'

    "  将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录 "
    let s:vim_tags = expand('~/.cache/tags')
    let g:gutentags_cache_dir = s:vim_tags
    "  检测 ~/.cache/tags 不存在就新建 "
    if !isdirectory(s:vim_tags)
       silent! call mkdir(s:vim_tags, 'p')
   endif

    "  配置 ctags 的参数 "
    let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
    let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
    let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
    if MySys() == "windows"
        let g:gutentags_ctags_executable = $UCTAGS_WIN
        " 使用 u-ctags 增加这一行
        let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
    endif
    " or use .notags instead for each project
    " let g:gutentags_exclude_project_root = [expand('$VIMY')]

    let g:gutentags_file_list_command = 'rg --files'
    " let g:gutentags_ctags_exclude_wildignore='*/plugged/*'
    " autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
    " autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>
    " To know when Gutentags is generating tags, add this to your vimrc:
    " set statusline+=%{gutentags#statusline()}
    " help trace execute :call gutentags#toggletrace() and then  :GutentagsUpdate!
    " the update script will also leave a tags.log file next to your tags file
"}}}

" w0rp/ale Asynchronous linting 异步代码检查"{{{
" Dependency : pip install autopep8
" Dependency : pip install yapf
" clang 是LLVM 的子项目，clang-format in LLVM
    if count(g:plugin_function_groups, "ale")
        " show errors or warnings in my statusline
        if count(g:plugin_function_groups, "airline")
            let g:airline#extensions#ale#enabled = 1
        endif
        let g:ale_sign_column_always = 1
        let g:ale_sign_error = '>>'
        let g:ale_sign_warning = '--'

        let g:ale_set_highlights = 0
        let g:ale_lint_on_text_changed = 'never'
        "打开文件时不进行检查
        let g:ale_lint_on_save =0
        let g:ale_lint_on_enter = 0
        "普通模式下，cp前往上一个错误或警告，cn前往下一个错误或警告
        " nmap <silent> cp <Plug>(ale_previous_wrap)
        " nmap <silent> cn <Plug>(ale_next_wrap)
        " "<Leader>d查看错误或警告的详细信息
        " nnoremap <Leader>cd :ALEDetail<CR>
        " use quickfix list instead of the loclist
        let g:ale_set_loclist = 0
        let g:ale_set_quickfix = 1

        " 使用clang对c和c++进行语法检查，对python使用pylint/flake8进行语法检查
        let g:ale_linters = {
                \   'cpp': ['clang'],
                \   'c': ['clang'],
                \'python': ['pylint'],
        \}
        " let g:ale_fixers = {'python': ['remove_trailing_lines', 'trim_whitespace', 'autopep8']
        let g:ale_fixers = {
                    \'python': ['autopep8', 'yapf'],
                    \ 'cpp': ['clang-format'],
                    \ 'c': ['clang-format'],
                    \ 'vim': ['remove_trailing_lines', 'trim_whitespace'],
                    \}
                    " \'python': ['remove_trailing_lines', 'trim_whitespace', 'autopep8',
                    " \'add_blank_lines_for_python_control_statements'
        if !executable("clang-format") && !executable("clang")
            echom "clang or clang-format isn't installed"
        else
            augroup format_cpp
                autocmd! format_cpp
                autocmd FileType c,cpp vnoremap <silent><buffer> <leader>fx :!clang-format<CR>
            augroup END
        endif
        if !executable("autopep8") && !executable("yapf")
            echom "autopep8 or yapft isn't installed"
        else
            augroup format_python
                autocmd! format_python
                autocmd FileType python vnoremap <silent><buffer> <leader>fx :!yapf<CR>
            augroup END
        endif
        let g:ale_fix_on_save = 0
        " let g:ale_fix_on_enter
        " let g:ale_fix_on_insert_leave
        " let g:ale_fix_on_text_changed
        " :ALEFixSuggest
        " :ALEFix
        nnoremap <silent><leader>fx :ALEFix<cr>
        nnoremap <Leader>fc :ALELint<CR>
    endif
"}}}

" skywind3000/asyncrun.vim"{{{
    " stop the runing job
    " :AsyncStop{!}

    " 自动打开 quickfix window ，高度为 6
    let g:asyncrun_open = 10

    " 设置 F10 打开/关闭 Quickfix 窗口
    " nnoremap <F10> :call asyncrun#quickfix_toggle(10)<cr>
    let $PYTHONUNBUFFERED=1
    let g:asyncrun_rootmarks = copy(b:project_marker_list)
    let g:asyncrun_trim = 1
"}}}

" vim-youdao-translater "{{{
    nnoremap <silent> gw :<C-u>Ydc<CR>
    " vnoremap <silent> <m-f> :<C-u>Ydv<CR>
"}}}

" Windows和linux的单文件编译 "{{{
    func! ComplieRunCpp()
        if &filetype == 'cpp'
            exec "w"
            exec "!g++ % -g -Wall -o %<"
            if MySys() == 'linux'
                " %< 表示没有后缀的本文件 ，参考 :help %<
                exec "! ./%<"
            elseif MySys() == 'windows'
                exec "!%<"
            endif
        endif
        if &filetype == 'c'
            exec "w"
            exec "!gcc % -g -Wall -o %<"
            if MySys() == 'linux'
                " %< 表示没有后缀的本文件 ，参考 :help %<
                exec "! ./%<"
            elseif MySys() == 'windows'
                exec "!%<"
            endif
        endif
    endfunc

" " 单文件编译运行
    " nnoremap <silent> <C-F5> :call ComplieRunCpp()<CR>
" make
    " autocmd FileType c,cpp map <silent><buffer> <leader><space> :make<CR>


    " for reference of python from zhihu zhangyiteng
    " nnoremap <F5> :call CompileRunGcc()<cr>
    func! CompileRunGcc()
        exec "w"
        if &filetype == 'python'
            if search("@profile")
                exec "AsyncRun kernprof -l -v %"
                exec "copen"
                exec "wincmd p"
            elseif search("set_trace()")
                exec "!python3 %"
            else
                exec "AsyncRun -raw python3 %"
                exec "copen"
                " 光标移动到上一个窗口
                exec "wincmd p"
            endif
        endif
    endfunc
"}}}

" vim-which-key "{{{
if count(g:plugin_function_groups, "vim-which-key")
    cabbrev WK WhichKey
    " nnoremap <silent> <leader> :<c-u>WhichKey  ','<CR>
    nnoremap <silent> <leader>t :<c-u>WhichKey  ',t'<CR>
    " nnoremap <silent> <leader>q :<c-u>WhichKey  ',q'<CR>
    nnoremap <silent> <leader>f :<c-u>WhichKey  ',f'<CR>
    nnoremap <silent> <leader>g :<c-u>WhichKey  ',g'<CR>
    nnoremap <silent> <leader>uf :<c-u>WhichKey  ',uf'<CR>
    let g:which_key_timeout = 300
    let g:which_key_vertical = 1
    let g:which_key_position = 'botright'
    let g:WhichKeyFormatFunc = function('which_key#util#format')
    " let g:which_key_map =  {}
    " :WhichKey! g:which_key_map.w
    " let g:which_key_map.w = {
      " \ 'name' : '+windows' ,
      " \ 'w' : ['<C-W>w'     , 'other-window']          ,
      " \ 'd' : ['<C-W>c'     , 'delete-window']         ,
      " \ '-' : ['<C-W>s'     , 'split-window-below']    ,
      " \ '|' : ['<C-W>v'     , 'split-window-right']    ,
      " \ '2' : ['<C-W>v'     , 'layout-double-columns'] ,
      " \ 'h' : ['<C-W>h'     , 'window-left']           ,
      " \ 'j' : ['<C-W>j'     , 'window-below']          ,
      " \ 'l' : ['<C-W>l'     , 'window-right']          ,
      " \ 'k' : ['<C-W>k'     , 'window-up']             ,
      " \ 'H' : ['<C-W>5<'    , 'expand-window-left']    ,
      " \ 'J' : ['resize +5'  , 'expand-window-below']   ,
      " \ 'L' : ['<C-W>5>'    , 'expand-window-right']   ,
      " \ 'K' : ['resize -5'  , 'expand-window-up']      ,
      " \ '=' : ['<C-W>='     , 'balance-window']        ,
      " \ 's' : ['<C-W>s'     , 'split-window-below']    ,
      " \ 'v' : ['<C-W>v'     , 'split-window-below']    ,
      " \ }
endif
"}}}

" neoterm REPL"{{{
" "h mods
if g:term_support && count(g:plugin_function_groups, 'neoterm')
    let g:neoterm_default_mod="vertical botright"
    tnoremap <leader>tt <c-w>:Ttoggle<cr>
    nnoremap <leader>tt :Ttoggle<cr>
    nnoremap <leader>tl :TREPLSendLine<cr>
    let g:neoterm_keep_term_open = 1
    if MySys() == 'windows'
        " let g:neoterm_eof="\r"
        " let g:neoterm_repl_python = 'python.exe --no-autoindent'
        " let g:neoterm_eof="\r\n"
        " let g:neoterm_eof="<cr>"
    endif
    " let g:neoterm_autoinsert = 1
    " let g:neoterm_autojump = 1

    " Use gx{text-object} in normal mode
    " nmap gx <Plug>(neoterm-repl-send)

    " Send selected contents in visual mode.
    " xmap gx <Plug>(neoterm-repl-send)
endif
"}}}

"{{{
" tyru/open-browser.vim 
"   This is my setting. 
let g:netrw_nogx = 1 " disable netrw's gx mapping. 
nmap gx <Plug>(openbrowser-smart-search) 
" vmap gx <Plug>(openbrowser-smart-search) 
" vnoremap gob :OpenBrowser http://www.baidu.com/s?wd=<C-R>=expand("<cword>")<cr><cr>
" nnoremap gob :OpenBrowser http://www.baidu.com/s?wd=<C-R>=expand("<cword>")<cr><cr>
"}}}

" c cpp quick switch jump and mkdir c/h file
" :A

"{{{
" cpp enhanced hightlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
" let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1
" let g:cpp_no_function_highlight = 1
let c_no_curly_error=1
"}}}

" SimpylFold "{{{
    let g:SimpylFold_docstring_preview = 1
"}}}

" vimgrep.vim "{{{
" 对搜索的设置
    " map <leader>ff :call Search_Word("CurrentFile")<CR>:copen<CR>
    " map <leader>fF :call Search_Word("RecursiveFile")<CR>:copen<CR>
    " function! Search_Word(opt)
        " let w = expand("<cword>") " 在当前光标位置抓词
        " if a:opt == 'CurrentFile'
            " " execute "vimgrep " w " %"
            " " 在当前文件%中查找 光标下的单词
            " execute "Grep " w " %"
        " elseif a:opt == 'RecursiveFile'
            " execute "Grep -r" w " *"
        " endif
    " endfunction
""""""""""""""""""""""""""""""
"  在hexo中使用grep搜索笔记  "
""""""""""""""""""""""""""""""
    " if count(g:plugin_function_groups, 'hexo')
        " function! Search_word_in_hexo()
            " call inputsave()
            " let w = input ("searching word in hexo :")
            " call inputrestore()
            " if !empty(w)
                " let searchpath = join([g:hexo_blogpath, 'source', '_posts'],g:os_sep)
            " execute "Grep -r ".w." ".searchpath
            " else
                " echo "nothing to search"
            " endif
        " endfunc
        " map <leader>fn :call Search_word_in_hexo()<CR>

    " endif

""""""""""""""""""""""""""""""
" grep setting
""""""""""""""""""""""""""""""
    " nnoremap <silent> <F3> :Grep<CR>
    "}}}

" scrooloose/syntastic 代码检查"{{{
" Recommend setting
    if count(g:plugin_function_groups, 'syntastic')
        let g:syntastic_always_populate_loc_list = 1
        let g:syntastic_auto_loc_list = 2
        let g:syntastic_check_on_open = 1
        let g:syntastic_check_on_wq = 0

        " syntax checkers :help syntastic-checkers
        let g:syntastic_python_checkers=['pyflakes', 'pep8'] "
        " 使用pyflakes,速度比pylint快
        let g:syntastic_python_pep8_args='--ignore=E501,E225,E124,E712'
        let g:syntastic_mode_map = {
            \ "mode": "passive",
            \ "active_filetypes": ["ruby", "php"],
            \ "passive_filetypes": ["puppet"] }
        " nnoremap <leader>ck :SyntasticCheck<cr>
        nnoremap <leader>ck :SyntasticCheck<cr>:Error<cr>
    endif

"}}}

" Plug 'Valloric/ListToggle' " Valloric/ListToggle"{{{
    " let g:lt_quickfix_list_toggle_map = '<F4>'
"}}}

"{{{
" vim-terminal at $VIMFILES/plugin/
nnoremap <silent> <leader>tt :VSTerminalToggle<cr>
if has('nvim')
    tnoremap <silent><leader>tt <C-\><C-n> :MXTerminalToggle<cr>
    tnoremap <C-w> <C-\><C-n><C-w>
else
    tnoremap <silent> <leader>tt <c-w>:MXTerminalToggle<cr>
endif
" let g:vs_terminal_custom_height = 10
let g:vs_terminal_custom_height = 70
let g:vs_terminal_custom_pos ="right"
"}}}

"
" Plugin 'octol/vim-cpp-enhanced-highlight'
" h switchbuf
