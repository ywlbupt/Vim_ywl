#! /usr/bin/env python
# coding:utf-8

import os
import io
import sys
from ZhihuParser import ZhihuParser


if os.name == 'nt' :
    # TextIOWrapper  
#   sys.stdout 系统标准输出流
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer,encoding='gb18030')
elif os.name == 'posix':
    pass
    
with open ("./temp1.txt",'r', encoding='utf-8') as fd :
    tp = ZhihuParser()
    tp.feed(fd.read())
    print (tp.getZhihuQuestion())
