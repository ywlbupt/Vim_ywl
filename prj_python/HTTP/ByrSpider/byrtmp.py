#!/usr/bin/env python
# -*- coding:utf-8 -*-

import lxml
import requests
import os
import sys
import re
from bs4 import BeautifulSoup


defaulturl = r"http://bbs.byr.cn/#!default"
contenturl = r"http://bbs.byr.cn/default?_uid=guest"

tmpresonse = os.path.join(sys.path[0], "response.html")

headers = {
        'User-Agent':'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.111 Safari/537.36',
        'Connection' : 'keep-alive'
        }
bbsreq = requests.Session()
bbsreq.headers=headers

bbsreq.headers["X-Requested-With"]= "XMLHttpRequest"

# res=bbsreq.get(contenturl)
# print (res.url)
with open(tmpresonse, "r") as f:
    # f.write (res.text)
    text=f.read()
m = re.finditer (r'<span class="widget-title"><a href.*?>(?P<content>.*?)</a></span>', text)
# for widget_title in m :
#     print(widget_title.group("content"))


soup = BeautifulSoup(text, "lxml")
widget_title = soup.find_all("span", class_="widget-title")
for title in widget_title:
    print(title.get_text()) 

# <span class="widget-title"><a href="/board/recommend">近期热点活动</a></span>
# widget-title : 版面

