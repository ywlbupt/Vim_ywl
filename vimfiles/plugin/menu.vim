if !count(g:plugin_function_groups, 'quickmenu')
    finish
endif
" ref : [https://github.com/skywind3000/vim/blob/master/asc/menu.vim]

" choose a favorite key to show/hide quickmenu
noremap <silent><F12> :call quickmenu#toggle(0)<cr>

" enable cursorline (L) and cmdline help (H)
let g:quickmenu_options = "HL"

"----------------------------------------------------------------------
" menu initialize
"----------------------------------------------------------------------
" clear all the items
call quickmenu#current(0)
call g:quickmenu#reset()

" section 1, text starting with "#" represents a section (see the screen capture below)
call g:quickmenu#append('# Code', '')

call g:quickmenu#append('<C-F7>: Complie and Run', 'call Complie_and_RunX()', 'complie c/cpp', "c,cpp")
call g:quickmenu#append('<F7>: Complie', 'call ComplieX()', 'complie c/cpp', "c,cpp")
call g:quickmenu#append('<F5>: Run', 'call RunX()', 'run c/cpp after complie',"c,cpp")
call g:quickmenu#append('<F7>: Run', 'call RunX()', 'run python prog', 'python')
call g:quickmenu#append('<lr>+fx: ALEFix', 'ALEFix', 'fix prog format','c,cpp,python,vim')
call g:quickmenu#append('<lr>+fc: ALELint', 'ALELint', 'check prog grammar','c,cpp,python')
call g:quickmenu#append('user format pretty', 'call tool#Html_Prettify()', 'format prety','html,xml')
call g:quickmenu#append('<lr>+[n*-]: insert prefix', 'call tool#Line_insert_num()', 'insert prefix','markdown, text')
call g:quickmenu#append('<lr>+p: markdown preview', 'call tool#Line_insert_num()', 'insert prefix','markdown, text')

" section 
call g:quickmenu#append('# text format Tips', '')
call g:quickmenu#append('<c-b>  : Leaderf在所有buffers中查找光标下词','','')
call g:quickmenu#append('<c-f>  : Leaerf在当前buffer中查找光标下词','','')
call g:quickmenu#append('<lr>+ff: Leaderf在所有buffer中查找光标下词','','')
call g:quickmenu#append('v<lr>+uf1: 多个空行删成一行','g/^$\n^$/d','del multi line')
call g:quickmenu#append('v<lr>+uf2: 删除空行', 'g/^\s*$/d','del blank lines')
call g:quickmenu#append('v<lr>+uf3: 删除行后空格', '%s/\s\+$//g','del tail spaces')
call g:quickmenu#append('<lr>+eu: EditCustomSnips', 'UltiSnipsEdit', 'EditCustomSnips')
