if exists('g:vs_terminal_loaded')
    " finish
end

if !exists('g:vs_terminal_custom_pos')
    let g:vs_terminal_custom_pos = 'bottom'
endif

if !exists('g:vs_terminal_custom_height')
    let g:vs_terminal_custom_height = 10
endif

if !exists('g:vs_terminal_custom_command')
    let g:vs_terminal_custom_command = ''
endif

if(has('win32') || has('win64') || has('win95') || has('win16'))
    let g:vs_os="win"
else
    let g:vs_os="linux"
endif

let g:vs_terminal_loaded = 1

let g:vs_terminal_current_number = 0
let g:vs_terminal_delete_bufer_number = 0
let g:vs_is_terminal_open = 0

let g:vs_called_by_toggle = 0
let g:vs_terminal_map = {}
let g:vs_lazyload_cmd = 0

function! s:VSTerminalToggle()
    call s:VSLazyLoadCMD()
    if g:vs_is_terminal_open == 1
        if bufexists(str2nr(g:vs_terminal_current_number))
            call s:VSTerminalCloseWin()
        else
            let g:vs_is_terminal_open = 0
            call s:VSTerminalOpenWin()
            call s:VSTerminalOpenBuffer()
        endif
    else
        call s:VSTerminalOpenWin()
        call s:VSTerminalOpenBuffer()
    endif
endfunction

function! s:VSTerminalJudgeAndOpenWin()
    if g:vs_is_terminal_open == 0
        call s:VSTerminalOpenWin()
        let g:vs_is_terminal_open = 1
    else
        let l:current_win_number = bufwinnr(str2nr(g:vs_terminal_current_number))
        exec l:current_win_number . 'wincmd W'
    endif
endfunction

function! s:VSTerminalOpenNew()
    call s:VSLazyLoadCMD()
    call s:VSTerminalJudgeAndOpenWin()
    call s:VSTerminalCreateNew()
endfunction

function! s:VSTerminalOpenWithIndex(i)
    call s:VSLazyLoadCMD()
    let l:keys = keys(g:vs_terminal_map)
    let l:index = a:i - 1
    if (a:i > len(g:vs_terminal_map))
        echoe 'Terminal not exists!'
        return
    endif
    let l:bufnr = l:keys[l:index]
    if !bufexists(str2nr(l:bufnr))
        echoe 'Terminal not exists!'
        return
    endif
    call s:VSTerminalJudgeAndOpenWin()
    exec 'b ' . l:bufnr
    let g:vs_terminal_current_number = l:bufnr
    call s:VSTerminalRenderStatuslineEvent()

endfunction

function! s:VSTerminalDeleteWithIndex(i)
    let l:keys = keys(g:vs_terminal_map)
    let l:index = a:i - 1
    if (a:i > len(g:vs_terminal_map))
        echoe 'Terminal not exists!'
        return
    endif
    let l:bufnr = l:keys[l:index]
    if !bufexists(str2nr(l:bufnr))
        echoe 'Terminal not exists!'
        return
    endif
    let g:vs_terminal_delete_bufer_number = l:bufnr
    call s:VSGetCurrentNumberAfterDelete(l:bufnr)
    call s:VSTerminalRenderStatuslineEvent()
    exec 'bd! ' . l:bufnr
endfunction

function! s:VSTerminalCloseWin() abort
    if bufexists(str2nr(g:vs_terminal_current_number))
        if winnr() == bufwinnr(str2nr(g:vs_terminal_current_number))
            exec 'wincmd p'
            exec bufwinnr(str2nr(g:vs_terminal_current_number)) . 'wincmd w'
        else
            exec bufwinnr(str2nr(g:vs_terminal_current_number)) . 'wincmd w'
        endif
        close
    endif
    let g:vs_is_terminal_open = 0
endfunction

function! s:VSTerminalCreateNew()
    " Terminal init finished.
    let g:vs_called_by_toggle = 1
    if has('nvim')
        exec 'enew'
        exec "call termopen(\'zsh\')"
    else
        exec 'terminal ++curwin ' . g:vs_terminal_custom_command
    endif
endfunction

function! s:VSTerminalOpenWin()
    let l:vs_terminal_pos = g:vs_terminal_custom_pos ==# 'bottom' ? 'botright ' : 'topleft '
    let l:vs_terminal_pos = g:vs_terminal_custom_pos ==# 'left' ? 'topleft ' : g:vs_terminal_custom_pos ==# 'right' ? 'botright ' : l:vs_terminal_pos
    let l:vs_terminal_split = g:vs_terminal_custom_pos ==# 'left' ? ' vsplit' : g:vs_terminal_custom_pos ==# 'right' ? ' vsplit' : ' split'
    exec l:vs_terminal_pos . g:vs_terminal_custom_height . l:vs_terminal_split
    let g:vs_is_terminal_open = 1
endfunction

function! s:VSTerminalOpenBuffer()
    if g:vs_terminal_current_number == 0
        call s:VSTerminalCreateNew()
    else
        if bufexists(str2nr(g:vs_terminal_current_number))
            exec 'b ' . g:vs_terminal_current_number
        else
            let g:vs_terminal_current_number = 0
            call s:VSTerminalCreateNew()
        endif
    endif
    call s:VSSetDefaultConfig()
endfunction

function! s:VSSetDefaultConfig()
    exec 'setlocal wfh'
endfunction


function! s:VSTerminalSetDefautlBufferNumber()
    " Save terminal buffer number.
    let l:window_number = winnr()
    let l:buffer_number = winbufnr(l:window_number)
    let g:vs_terminal_current_number = l:buffer_number
endfunction

function! s:VSTerminalOpenEvent()
    if g:vs_called_by_toggle == 1
        " Mark the first terminal as default.
        call s:VSTerminalSetDefautlBufferNumber()
        let l:window_number = winnr()
        let l:buffer_number = winbufnr(l:window_number)
        let g:vs_terminal_map[l:buffer_number] = 0
        let g:vs_called_by_toggle = 0
        call s:VSTerminalRenderStatuslineEvent()

    endif
    if has('nvim')
        exec 'normal! a'
    endif
endfunction

function! s:VSTerminalDeleteEvent()
    let l:buffer_number = 0
    if g:vs_terminal_delete_bufer_number
        let l:buffer_number = g:vs_terminal_delete_bufer_number
    else
        let l:window_number = winnr()
        let l:buffer_number = winbufnr(l:window_number)
    endif

    call s:VSGetCurrentNumberAfterDelete(l:buffer_number)
    call s:VSTerminalRenderStatuslineEvent()
    let g:vs_terminal_delete_bufer_number = 0

endfunction

function! s:VSGetCurrentNumberAfterDelete(n)
    if has_key(g:vs_terminal_map, a:n)
        call remove(g:vs_terminal_map, a:n)
        if a:n == g:vs_terminal_current_number
            let g:vs_terminal_current_number = len(g:vs_terminal_map) > 0 ? keys(g:vs_terminal_map)[0] : 0
        endif
    endif

    if len(g:vs_terminal_map) == 0
        let g:vs_is_terminal_open = 0
    endif
endfunction


function! s:VSTerminalRenderStatuslineEvent()
    " 这个乱涂色，直接跳出
    return
    set statusline=
    let l:count = len(g:vs_terminal_map)
    let l:keys = keys(g:vs_terminal_map)
    if l:count > 0
        if l:keys[0] == g:vs_terminal_current_number
            set statusline +=%1*\ 1\ %*
        else
            set statusline +=%2*\ 1\ %*
        endif
    endif
    if l:count > 1
        if l:keys[1] == g:vs_terminal_current_number
            set statusline +=%1*\ 2\ %*
        else
            set statusline +=%2*\ 2\ %*
        endif
    endif
    if l:count > 2
        if l:keys[2] == g:vs_terminal_current_number
            set statusline +=%1*\ 3\ %*
        else
            set statusline +=%2*\ 3\ %*
        endif
    endif
    if l:count > 3
        if l:keys[3] == g:vs_terminal_current_number
            set statusline +=%1*\ 4\ %*
        else
            set statusline +=%2*\ 4\ %*
        endif
    endif
    if l:count > 4
        if l:keys[4] == g:vs_terminal_current_number
            set statusline +=%1*\ 5\ %*
        else
            set statusline +=%2*\ 5\ %*
        endif
    endif
    if l:count > 5
        if l:keys[5] == g:vs_terminal_current_number
            set statusline +=%1*\ 6\ %*
        else
            set statusline +=%2*\ 6\ %*
        endif
    endif
    hi User1 cterm=bold ctermfg=169 ctermbg=238
    hi User2 cterm=none ctermfg=238 ctermbg=169
    hi StatuslineTerm ctermbg=236 ctermfg=236
    hi StatuslineTermNC ctermbg=236 ctermfg=236
endfunction

function! s:VSTerminalBufEnterEvent()
    if has('nvim')
        exec 'normal! a'
    endif
endfunction


command! -nargs=0 -bar VSTerminalToggle :call s:VSTerminalToggle()
command! -nargs=0 -bar VSTerminalOpenNew :call s:VSTerminalOpenNew()
command! -nargs=1 -bar VSTerminalOpenWithIndex :call s:VSTerminalOpenWithIndex('<args>')
command! -nargs=1 -bar VSTerminalDeleteWithIndex :call s:VSTerminalDeleteWithIndex('<args>')

function! s:VSLazyLoadCMD()
    if g:vs_lazyload_cmd == 0
        augroup VS
        autocmd! VS
            if has('nvim')
                au TermOpen * if &buftype == 'terminal' | call s:VSTerminalOpenEvent() | endif
            else
                au TerminalOpen * if &buftype == 'terminal' | call s:VSTerminalOpenEvent() | endif
            endif
            au Bufunload * if &buftype == 'terminal' | call s:VSTerminalDeleteEvent() | endif
            " BufDelete will be call when rename buffers, terminal rename before open
            " au BufDelete * if &buftype == 'terminal' | call s:VSTerminalDeleteEvent() | endif

            " au BufEnter * if &buftype == 'terminal' | echom "bufenter come" |
                        " \ call s:VSTerminalRenderStatuslineEvent() |
                        " \ call s:VSTerminalBufEnterEvent() |
                        " \ endif
        augroup END
        let g:vs_lazyload_cmd = 1

        """"""""""""""""""""""""""" Compatible with old verion.""""""""""""""""""""""""""""
        if exists("g:mx_terminal_custom_pos")
            let g:vs_terminal_custom_pos = g:mx_terminal_custom_pos
        endif

        if exists("g:mx_terminal_custom_height")
            let g:vs_terminal_custom_height = g:mx_terminal_custom_height
        endif
        """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    endif
endfunction

""""""""""""""""""""""""""" Compatible with old verion.""""""""""""""""""""""""""""
command! -nargs=0 -bar MXTerminalToggle :call s:VSTerminalToggle()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call s:VSLazyLoadCMD()

"{{{
function! s:term_send_text(...) abort
    if a:0 == 1
        let l:text = a:1
        let l:bufnr = str2nr(g:vs_terminal_current_number)
    elseif a:0 == 2
        let l:bufnr = str2nr(a:1)
        let l:text = a:2
    endif
    if bufexists( l:bufnr )
        if g:vs_os == "win"
            call term_sendkeys(l:bufnr, "\<Esc>\<Esc>")
        else
            call term_sendkeys(l:bufnr, "\<C-U>\<C-U>")
        endif
        call term_sendkeys(l:bufnr, l:text."\<CR>")
    else
        echo "no terminal exitst"
    endif
endfunction
"}}}

"{{{
function! terminal#all_terms_exit() abort
    let l:exit_cmd = "exit"
    for l:bufnr in term_list()
        " echom l:bufnr
        call s:term_send_text( l:bufnr, l:exit_cmd)
        call term_wait(l:bufnr, 100)
    endfor
    if !empty(term_list())
        echom "still remain terminal not exit"
    endif
endfunction
"}}}

"{{{
function! terminal#exec_file(...) abort
	function! s:WindowCheck()
		if getbufvar('%', '&buftype') == 'terminal'
			let s:terminal_open = 1
            let s:term_bufnr = bufnr("%")
			return
        endif
    endfunc

    let s:terminal_open = 0
    let s:term_bufnr = 0
    let l:winnr = winnr()
    let l:exec_file_name = "%"
    if a:0 == 1
        let l:exec_file_name = a:1
    endif

    if l:exec_file_name == '%' 
        let l:exec_file_name = expand('%<')
    endif

	windo call s:WindowCheck()
    silent exec l:winnr.'wincmd w'
    if s:terminal_open == 1 && s:term_bufnr != 0
        call s:term_send_text(s:term_bufnr, l:exec_file_name )
    else
        call s:VSTerminalToggle()
        silent exec 'wincmd p'
        let s:term_bufnr = g:vs_terminal_current_number
        " let g:vs_terminal_current_number = 0
        call s:term_send_text(s:term_bufnr, l:exec_file_name )
    endif
endfunction
"}}}
