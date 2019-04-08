""""""""""""""""""""""""""
"  autoload -> tool.vim  "
""""""""""""""""""""""""""

command! -nargs=* QToggle call tool#Toggle_LQlist(<f-args>)
nnoremap <silent> <leader>tl :call tool#Toggle_LQlist('l')<cr>
nnoremap <silent> <leader>tq :call tool#Toggle_LQlist('q')<cr>

augroup quickfix_event
    autocmd! quickfix_event
    au BufWinEnter * if &buftype == 'quickfix' | set nobuflisted | endif
augroup END

command! -nargs=? -range  ULineinsertnum  <line1>,<line2>call tool#Line_insert_num(<f-args>)
augroup markdown_edit
    autocmd! markdown_edit
    autocmd FileType markdown,text vnoremap <silent><buffer> <leader>in :call tool#Line_insert_num("n")<cr>
    autocmd FileType markdown,text nnoremap <silent><buffer> <leader>in :call tool#Line_insert_num("n")<cr>
    autocmd FileType markdown,text vnoremap <silent><buffer> <leader>i* :call tool#Line_insert_num("*")<cr>
    autocmd FileType markdown,text nnoremap <silent><buffer> <leader>i* :call tool#Line_insert_num("*")<cr>
    autocmd FileType markdown,text vnoremap <silent><buffer> <leader>i- :call tool#Line_insert_num("-")<cr>
    autocmd FileType markdown,text nnoremap <silent><buffer> <leader>i- :call tool#Line_insert_num("-")<cr>
augroup END
