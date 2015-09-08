# coding:UTF-8
# 字符窗函数find
# 列表list[-x:-y]
# 文件读写操作
# 循环体While
# 正则表达式
# list findall
# re.search

import urllib
import re
import HTMLParser
# -----------处理编码问题-------
import sys
reload(sys)
sys.setdefaultencoding('utf-8')
# ------------------------------

# -----------处理转义字符-------
html_parser = HTMLParser.HTMLParser()
# str0 = '这一代人&nbsp;（2012年版）'
# print html_parser.unescape(str0)
# ------------------------------


# str0 = '<a title="《论电影的七个元素》——关于我对电影的一些看法以及《后会无期》的一些消息" target="_blank" href="http://blog.sina.com.cn/s/blog_4701280b0102eo83.html">《论电影的七个元素》——关于我对电…</a>'

urlhh='http://blog.sina.com.cn/s/articlelist_1191258123_0_1.html'
# 韩寒博客的网址
content=urllib.urlopen(urlhh).read()
urllist=[] # append

hh_titile_href = re.compile(r'(?<=<a title)\s*=\s*"(?P<titlename>.*?)"\s.*?href\s*=\s*"(?P<href_content>.*\.html).*</a>')

m = hh_titile_href.search(content)
while m:
    print html_parser.unescape(m.group('titlename'))
    print m.group('href_content')
    m = hh_titile_href.search(content, m.end())

