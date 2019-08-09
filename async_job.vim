" async_job

function! OnWorking(chann, msg)
    echomsg a:msg
endfunction

function! DoneWork(job)
    echomsg 'well work done'
    " echomsg job_status(s:job_ls)
    " 分行处理 list string
    " echomsg s:dir_list
endfunction

let s:translator_file = expand('<sfile>:p:h')."/py_script/api_holiday.py"

function! StartWork()
    let s:dir_list = ''
    let l:option = {'callback': 'OnWorking', 'close_cb':'DoneWork'}
    " let s:job_ls = job_start('powershell -command dir', l:option)
    let s:str_time = strftime("%Y%m%d")
    let s:py_cmd = "python ".s:translator_file." ".s:str_time
    let s:job_ls = job_start(s:py_cmd, l:option)
    echomsg "job called"
endfunction
