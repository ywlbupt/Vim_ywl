" 中英文的切换 From 依云
" set ttimeoutlen = 100
" set timeout timeoutlen=3000 ttimeoutlen=100
" (映射上的超时在三秒以后发生，键码上的超时在十分之一秒后发生)。
" Plugin 'lilydjwg/fcitx.vim'
" 针对Ubuntu下中文输入法的切换
" if MySys() == "linux" || hostname() =~ "E420"
    " set timeout timeoutlen=3000 ttimeoutlen=100
" endif

" 日历插件
" Plugin 'itchyny/calendar.vim'
" Calendar Setting"{{{
" " -position=left -width={50} 
" " specify the view of the calendar on starting the buffer
    " let g:calendar_view = "event"
    " " fix problem 5, refer to  help
    " let g:calendar_frame = 'default'
    " " a Toggle command
    " nmap <expr> <leader>cv &ft ==#'calendar'? "\<Plug>(calendar_exit)" :
                " \ ":\<C-u>Calendar -position=topright -view=week\<CR>"
"}}}
