#! /usr/bin/env python3
# coding:utf-8

from html.parser import HTMLParser
from html.entities import entitydefs

class TitleParser(HTMLParser):
    
# 调用父类HTMLParser的初始化函数
# 在创建实例的时候，把一些我们认为必须绑定的属性强制填写进去。
# 通过定义一个特殊的__init__方法
# 这里给子类添加 title 和 readingtitle 这两个属性
    def __init__(self):
        self.title = ""
        self.readingtitle = 0
        HTMLParser.__init__(self)

    def handle_starttag(self, tag, attrs):
        if tag == 'title' :
            self.readingtitle = 1

    def handle_data(self, data):
        if self.readingtitle:
            self.title += data
    
# 翻译HTML实体，如&amp;的函数，这里的变量 name = 'amp'
    def handle_entityref(self, name):
# 表达式1 
        if name in entitydefs :
# entitydefs应该是一个字典，name 属性与对应的翻译
            self.handle_data(entitydefs[name])
        else:
            self.handle_data('&' + name + ';')
# 表达式2
        self.handle_data(entitydefs[name] if name in entitydefs else '&' + name + ';')

# 转换字符参考
    def handle_charref(self, name):
        try :
            charnum = int (name)
        except ValueError as e :
            return
        
        self.handle_data(chr(charnum))


    def handle_endtag(self, tag):
        if tag == 'title':
            self.readingtitle = 0

    def gettitle(self):
        return self.title

# HTMLParser的子方法 feed()会恰当调用 handle_starttag, handle_data, handle_endtag
# 方法，handle_data()方法会检查是否从TITLE元素中取得数据，如果是，己保存数据
if __name__ == '__main__' :
    fd = open ("./temp1.txt")
    tp = TitleParser()
    tp.feed(fd.read())
    print ("Title is : %s" % tp.gettitle())

