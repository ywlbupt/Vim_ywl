" async_job

function! OnWorking(chann, msg)
    echomsg 'well work doing:'
    let s:dir_list.= a:msg . "\n"
endfunction

function! DoneWork(job)
    echomsg 'well work done'
    echomsg job_status(s:job_ls)
    " 分行处理 list string
    echomsg s:dir_list
endfunction

function! StartWork()
    let s:dir_list = ''
    let l:option = {'callback': 'OnWorking', 'close_cb':'DoneWork'}
    let s:job_ls = job_start('powershell -command dir', l:option)
    echomsg "job called"
    " call system("dir")
endfunction
