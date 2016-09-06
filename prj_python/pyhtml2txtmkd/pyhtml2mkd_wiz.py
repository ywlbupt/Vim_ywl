#!/usr/bin/env python3
# -*- coding:utf-8 -*-

from html.parser import HTMLParser
import os
import sys
import io
import codecs

htmlpath = "./index.html" # 可以是绝对路径，也可以是相对路径
(filepath,ext)=os.path.splitext(htmlpath)
# html的图片保存文件夹
htmlfilepath = filepath + "_files"
# html文件的读入涉及到字符的正确编码


class Wizindex2mkd(HTMLParser):
    def __init__(self):
        HTMLParser.__init__(self)
        self.data=""
        pass

    def handle_starttag(self, tag, attrs):
        # print("Encountered a start tag:", tag)
        pass

    def handle_endtag(self, tag):
        # print("Encountered an end tag :", tag)
        pass

    def handle_data(self, data):
        # print("Encountered some data  :", data)
        self.data+= data
        pass

    def get_dataresult(self):
        return self.data

if __name__=='__main__':
    print("不支持中文")
    print(filepath, ext)
    if os.path.exists(htmlpath) and os.path.exists(htmlfilepath):
        print ("file exist")
        print ("absolute path : %s" % os.path.abspath(htmlpath))
    if len(sys.argv)>1 :
        print ("hello :", sys.argv[1])
   
    # sys.stdout = io.TextIOWrapper(sys.stdout.buffer,encoding='utf8')
    #改变标准输出的默认编码
    parser = Wizindex2mkd()
    with codecs.open(htmlpath, 'r', encoding='utf_16') as fd:
        print(fd.read()) 
        # parser.feed(fd.read())	
    
    # print (codecs.encode(parser.get_dataresult(),encoding="gbk"))
    # print (parser.get_dataresult())
