# coding:utf-8

import sys  
  
print(sys.version)


function! Bar()
python << EOF
import vim
cur_buf = vim.current.buffer
print "Lines: {0}".format(len(cur_buf))
print "Contents: {0}".format(cur_buf[-1])
EOF
endfunction

