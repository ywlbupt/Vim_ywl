if !exists('g:plugin_function_groups')
    " optional :
    " "syntastic", "hexo" , "YouCompleteMe" , "ale", "airline",
    " "tagbar" , "LeaderF", "coc.nvim"
    " "neoterm", "delimitMate"
    let g:plugin_function_groups = ['hexo',  "airline" ,"ale",
                \ "LeaderF", "tagbar",
                \ "vim-youdao-translater",
                \ "YouCompleteMe",
                \ "delimitMate",
                \ "quickmenu",
                \ "vista.vim",
                \]
                " \ "vim-which-key",
                " \ "vista.vim",
                " \ "neoterm",
                " \ "coc.nvim",
endif

" vim-plug 异步插件管理"
call plug#begin('$VIMFILES/plugged')
    " Plug '~/my-prototype-plugin' " 表示不用github托管的本地vim插件；
    Plug 'junegunn/vim-easy-align'
" Initialize plugin system
    Plug 'ludovicchabant/vim-gutentags'
    " Group dependencies, vim-snippets depends on ultisnips
    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
    " 括号显示增强
    Plug 'kien/rainbow_parentheses.vim'
    " for didn't work as expected in plugin vim-markdown
    Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
    Plug 'skywind3000/asyncrun.vim'
    Plug 'skywind3000/quickmenu.vim'
    Plug 'xolox/vim-misc' |  Plug 'xolox/vim-session'
    " tpope 大神
    Plug 'tpope/vim-repeat' | Plug 'tpope/vim-surround'
    " -------------------- Python ----------------
    " fold for python
    Plug 'tmhedberg/SimpylFold', {'for': 'python'}
    " python vim built-in help
    Plug 'fs111/pydoc.vim', {'for': 'python'}
    " syntasitc checkers
    Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}
    " Git 集成工具
    Plug 'tpope/vim-fugitive'
    "---------模板输入 快捷输入--------
    Plug 'ywlbupt/load_template'
    Plug 'scrooloose/nerdcommenter'
    Plug 'scrooloose/nerdtree'

    " autocomplete pairs自动补全括号
    Plug 'Raimondi/delimitMate'
    " colors
    Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
    " gitgutter
    Plug 'airblade/vim-gitgutter'
    " gundo " edit history, 可以查看回到某个历史状态
    Plug 'sjl/gundo.vim'
    Plug 'tyru/open-browser.vim'

    " cpp enhanced hightlight
    Plug 'octol/vim-cpp-enhanced-highlight'

    " new added
    if count(g:plugin_function_groups, "vim-which-key")
        Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
    endif
    if count(g:plugin_function_groups, 'neoterm')
        Plug 'kassio/neoterm'
    endif
    if count(g:plugin_function_groups, "ale")
        " Plug 'w0rp/ale',{'tag' : 'v2.3.0'}
        Plug 'w0rp/ale'
    endif
    if count(g:plugin_function_groups, "tagbar")
        Plug 'majutsushi/tagbar'
    endif
    if count(g:plugin_function_groups, 'vista.vim')
        Plug 'liuchengxu/vista.vim'
    endif
    if count(g:plugin_function_groups, "LeaderF")
        if MySys() == 'windows'
            Plug 'Yggdroot/LeaderF',{ 'do': '.\install.bat' }
        elseif MySys() == 'linux'
            Plug 'Yggdroot/LeaderF',{ 'do': './install.sh' }
        endif
    endif
    if count(g:plugin_function_groups, "coc.nvim")
        Plug 'neoclide/coc.nvim', {'do': 'yarn install'}
    endif
    Plug 'altercation/vim-colors-solarized'
    Plug 'acarapetis/vim-colors-github'
    Plug 'morhetz/gruvbox'
    if count(g:plugin_function_groups, 'vim-youdao-translater')
        Plug 'ianva/vim-youdao-translater'
    endif
    if count(g:plugin_function_groups, 'YouCompleteMe')
        " Plug 'Valloric/YouCompleteMe', { 'do': 'python ./install.py clang-completer' }
        " Plug 'Valloric/YouCompleteMe', { 'do': 'python ./install.py' }
        " Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
        Plug 'Valloric/YouCompleteMe'
    endif
call plug#end()
