#!/usr/bin/env python
# coding:utf-8
# Filename: Zhihu.py

from urllib import request
from ZhihuParser import ZhihuParser
import logging
import os

# logging.basicconfig (level = logging.INFO)

# 新建一个文件，存放读取的内容供Debug
f = open('./temp.txt', 'w', encoding ='utf-8')
f.write ("------------New Test begin ----------------\n")

# 某个知乎用户的主页，未登录情况下
url = "http://www.zhihu.com/people/lycheeorange"

ZhihuRequest = request.Request(url)

with request.urlopen(ZhihuRequest,timeout = 30) as r :
    data = r.read()
# ---------- 解析HTML中的Title 示例
    # tp = ZhihuParser()
    # tp.feed(data.decode('utf-8'))
# ----------

    f.write('Status: %s %s %s'% (r.status , r.reason, os.linesep))
    for key, value in r.getheaders() :
        f.write ("%s : %s %s" % (key, value, '\r\n'))
    f.write("Data:%s%s" % (os.linesep, data.decode('utf-8')))


f.write ("------------New Test End ----------------\n\n")
f.close()

# <img src="https://pic3.zhimg.com/06807028c78a147ffecc1e92c295d142_b.jpg" class="content_image">
