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
    autocmd FileType markdown,text nmap <silent><buffer> <leader>ii <leader>i*
    autocmd FileType markdown,text vmap <silent><buffer> <leader>ii <leader>i*
augroup END

augroup html_event
    autocmd! html_event
    " autocmd FileType html,xml nnoremap <silent><buffer> <leader>f :call tool#Html_Prettify()<cr>
augroup END

augroup text_format_event
    autocmd! text_format_event
    " nnoremap <silent> <leader>uf1 :g/^$\n^$/d<CR>
    vnoremap <silent> <leader>uf1 :g/^$\n^$/d<CR> " 删除连续空行，保留一行
    " nnoremap <silent> <leader>uf2 :g/^\s*$/d<CR>
    vnoremap <silent> <leader>uf2 :g/^\s*$/d<CR> " 删除空行
    nnoremap <silent> <leader>uf3 :s/\s\+$//g<CR> " 删除行末空格
    vnoremap <silent> <leader>uf3 :s/\s\+$//g<CR>
augroup END
