if exists('g:user_debug_loaded')
    finish
endif
let g:user_debug_loaded = 1

function! s:InitVar(var, value)
    if !exists(a:var)
        exec 'let '.a:var.'='.string(a:value)
    endif
endfunction

call s:InitVar('g:user_complie_gdb', '1')
call s:InitVar('g:user_complie_c11', '0')

let s:cmd_cat = "&&"


"{{{
" 定义CompileRun函数，用来调用编译和运行
func! ComplieX() abort
    let l:opt_c11 = g:user_complie_c11 == 1 ? '-std=c++11 ': ''
    let l:opt_gdb = g:user_complie_gdb == 1 ? '-ggdb ': ''
    let l:cc={"cpp": "g++", "c":"gcc",}
    exec "w"
    if &filetype == 'c'
        exec 'AsyncRun gcc '.l:opt_gdb .' -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)"'
    elseif &filetype == 'cpp'
        exec 'AsyncRun g++ '.l:opt_gdb.l:opt_c11.'-Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)"'
    endif
endfunc

func! ComplieX_noasync() abort
    if &filetype == 'cpp'
        exec 'AsyncRun -mode=1  g++ -g -Wall -std=c++11 -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)"'
    endif
endfunc
"}}}

"{{{
" 定义Run函数
func! RunX() abort
    if &filetype == 'c' || &filetype == 'cpp'
        if MySys() == "windows"
            exec 'AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)"'
            " run in cmd as vs
            " exec 'AsyncRun -raw -cwd=$(VIM_FILEDIR) -mode=4 "$(VIM_FILEDIR)/$(VIM_FILENOEXT)"'
        elseif MySys() == 'linux'
            exec "! %<"
        endif
    elseif &filetype == 'python'
        exec "w"
        exec "AsyncRun -raw python %"
        " exec "copen"
        exec "wincmd p"
    endif
endfunc
"}}}

"{{{
" async complie and run
func! Complie_and_RunX()
    let l:opt_c11 = g:user_complie_c11 == 1 ? '-std=c++11 ': ''
    let l:opt_gdb = g:user_complie_gdb == 1 ? '-ggdb ': ''
    let l:cc={"cpp": "g++", "c":"gcc",}
    exec "w"
    if &filetype == 'cpp'
        exec 'AsyncRun -raw -cwd=$(VIM_FILEDIR) g++ '.l:opt_gdb .l:opt_c11
                    \ .'-Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)"'
                    \ .s:cmd_cat.
                    \ '"$(VIM_FILEDIR)/$(VIM_FILENOEXT)"'
    elseif &filetype == 'c'
        exec 'AsyncRun -raw -cwd=$(VIM_FILEDIR) gcc '.l:opt_gdb
                    \ .'-Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)"'
                    \ .s:cmd_cat.
                    \ '"$(VIM_FILEDIR)/$(VIM_FILENOEXT)"'
    endif
endfunc
"}}}

"{{{
" 定义Debug函数，用来调试程序
func! DebugX() abort
    exec "w"
    if g:term_support
        let s:debug = "Termdebug"
    else
        let s:debug = "!gdb "
    endif
    if &filetype == 'c' || &filetype == 'cpp'

        let l:winnr = winnr()
        let s:file_name = expand("%<")
        " noautocmd windo call TermDebugSendCommand('file '.s:file_name)
        noautocmd silent! exec ''.l:winnr.'wincmd w'
    endif
endfunc
"}}}

"{{{
" autocmd
augroup cfamilyDebug
    autocmd! cfamilyDebug
    autocmd FileType c,cpp nnoremap <silent><buffer> <F7> :call ComplieX()<CR>
    autocmd FileType c,cpp nnoremap <silent><buffer> <F5> :call RunX()<CR>
    autocmd FileType c,cpp nnoremap <silent><buffer> <C-F5> :call Complie_and_RunX()<CR>
    " autocmd FileType c,cpp nnoremap <silent><buffer> <C-F7> :call ComplieX_noasync()<CR>:ccl<CR>:call terminal#exec_file()<CR>
    autocmd FileType c,cpp nnoremap <silent><buffer> <leader>te :call terminal#exec_file()<CR>
augroup END

augroup pydebug
    autocmd! pydebug
    autocmd FileType python nnoremap <silent><buffer> <F5> :call RunX()<CR>
    autocmd FileType python nnoremap <silent><buffer> <leader>te :call terminal#exec_file(expand('%<')."py")<CR>
augroup END
"}}}
