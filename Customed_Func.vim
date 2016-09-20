" Mapping
nmap <leader>ud :call CurrentLineUpdate("LastUpdate")<cr>

" 更新光标下当前行的 `LastUpdate` "{{{
function! CurrentLineUpdate(varname)
    " 获取当前光标下当前行的内容
    " LastUpdate : 2016-09-17
    let l:str_lastupdate = getline('.')
    if l:str_lastupdate =~ a:varname.'\v\s*:\s*(\d{4}-\d{2}-\d{2})'
        echo 'Change datetime to :'.strftime("%Y-%m-%d")
        call setline('.', substitute(l:str_lastupdate, 
                    \ a:varname.'\v\s*:\s*\d{4}-\d{2}-\d{2}\s+.*$',
                    \ a:varname." : ".strftime("%Y-%m-%d %T")
                    \ ,''))
    else 
        echo "This line contain not date" 
    endif
    " TODO 此处我决定上python
endfunction
" call CurrentLineUpdate('LastUpdate')
" "}}}

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
        " 上行中的 . 为连接符号，连接前面的字符串和后面的字符变量
        exec ":r ! " . s:text
    else
        echo "no find"
    endif
endfunction
    
" 将当前行作为命令行在shell/cmd中执行
    " map <F4> :call RunmeCmd()<CR>
" 将当前行作为命令行在shell/cmd中执行，并写入当前行中
    " map <S-F4> :call RunmeCmdRead()<CR>
"}}}


