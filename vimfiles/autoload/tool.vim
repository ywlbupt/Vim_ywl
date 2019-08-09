"  tool.vim

"{{{
function! tool#Toggle_LQlist(...) abort
" a:1 -> 'q' for quickfix ; 'l' for location_list
	function! s:WindowCheck(mode)
		if getbufvar('%', '&buftype') == 'quickfix'
			let s:quickfix_open = 1
			return
		endif
		if a:mode == 0
			let w:quickfix_save = winsaveview()
		else
			call winrestview(w:quickfix_save)
		endif
	endfunc
    let l:buf_type = 'q'
    let l:size = 10
    if a:0 >=1
        let l:buf_type = a:1
    endif
	let s:quickfix_open = 0
	let l:winnr = winnr()
	let l:pwinnr = winnr("#")
	windo call s:WindowCheck(0)
	if s:quickfix_open == 0
        windo call s:WindowCheck(1)
		exec 'botright '.(l:buf_type=='l' ? 'lopen':'copen')." ".l:size
        silent exec ''.l:winnr.'wincmd w'
	else
        " quickfix and location_list are all quickfix buftype
        if getbufvar(winbufnr(l:winnr),'&buftype') == 'quickfix'
            silent exec ''.l:pwinnr.'wincmd w'
        else
            silent exec ''.l:winnr.'wincmd w'
        endif
        " cclose
        exec (l:buf_type=='l' ? 'lclose':'cclose')
    endif
endfunc

" command! -nargs=* QToggle call tool#Toggle_LQlist(<f-args>)
" nnoremap <silent> <leader>tq :call tool#Toggle_LQlist('l')<cr>
" nnoremap <silent> <leader>tl :call tool#Toggle_LQlist('q')<cr>

" augroup quickfix_event
    " autocmd! quickfix_event
    " au BufWinEnter * if &buftype == 'quickfix' | set nobuflisted | endif
" augroup END
"}}}

"{{{
function! tool#Line_insert_num(...) abort range
" param : "n", "*", "-"
    let l:prefix = '*'
    if a:0 == 1
        let l:prefix = a:1[0]
    endif
    let l:tabstop = getbufvar("%", "&tabstop")
    if l:tabstop < 4 | let l:tabstop = 4 | endif
    let l:oldmagic = &magic
    set magic
    for l:line in range(a:firstline, a:lastline)
        let l:sLine = getline(l:line)
        if l:prefix == 'n'
            let l:char_ahead = (l:line - a:firstline + 1)."."

        else
            let l:char_ahead = l:prefix
        endif
        " 在行首插入 数字左对齐
        " let l:sLine = printf("%-".l:tabstop."d%s",l:line,l:sLine)
        let l:sLine = substitute(l:sLine, '^\s*', '\0'.printf("%-".l:tabstop."s", l:char_ahead),"")
        " printf("%-".l:tabstop."d%s",l:line,l:sLine)
        call setline(l:line, l:sLine)
    endfor
    if l:oldmagic==1 |set magic| else| set nomagic | endif
endfunction
" command! -nargs=? -range  UTextinsertnum  <line1>,<line2>call tool#Line_insert_num(<f-args>)
" augroup markdown_edit
    " autocmd! markdown_edit
    " autocmd FileType markdown,text vnoremap <silent><buffer> <leader>in :call tool#Line_insert_num("n")<cr>
    " autocmd FileType markdown,text nnoremap <silent><buffer> <leader>in :call tool#Line_insert_num("n")<cr>
    " autocmd FileType markdown,text vnoremap <silent><buffer> <leader>i* :call tool#Line_insert_num("*")<cr>
    " autocmd FileType markdown,text nnoremap <silent><buffer> <leader>i* :call tool#Line_insert_num("*")<cr>
    " autocmd FileType markdown,text vnoremap <silent><buffer> <leader>i- :call tool#Line_insert_num("-")<cr>
    " autocmd FileType markdown,text nnoremap <silent><buffer> <leader>i- :call tool#Line_insert_num("-")<cr>
" augroup END
"}}}

"{{{
function! tool#Html_Prettify() abort
	if &ft != 'html'
		echo "not a html file"
		return
	endif
	silent! exec "s/<[^>]*>/\r&\r/g"
	silent! exec "g/^$/d"
	exec "normal ggVG="
endfunc
"}}}
