#! /usr/bin/env python3
# -*- coding=utf-8 -*-

from html.parser import HTMLParser
from html.entities import entitydefs
import os

unique_tag={'br'}

class ZhihuAnswerParser(HTMLParser):
    
# 调用父类HTMLParser的初始化函数
# 在创建实例的时候，把一些我们认为必须绑定的属性强制填写进去。
# 通过定义一个特殊的__init__方法
# 这里给子类添加 title 和 readingQuesionLink 这两个属性
    def __init__(self):
        self.Question = []
        self.AnswerData = ""
        self.readingQuesionLink = 0
        self.readingAnswer = 0
        self.div_stack = []
        self.parenturl = "www.zhihu.com"
        self.dict_attrs={"div":("data-action","/answer/content"),"a":("class",\
            "question_link")}
        HTMLParser.__init__(self)

    def handle_starttag(self, tag, attrs):
    # tag是的html标签，attrs是 (属性，值)元组(tuple)的列表(list). 
        if tag in unique_tag : pass
        if tag == 'a':
            if len(attrs)== 0 : pass
            else :
                for(variable, value) in attrs:
                    if variable=='class' and value == 'question_link' :
                        self.readingQuesionLink = 1
                    if variable== 'href' and self.readingQuesionLink :
                        self.Question.append (
                                {"Question":"","link":(value+self.parenturl)})
        elif tag == 'div' and attrs :
            if not self.readingAnswer :
                for (variable, value) in attrs :
                    if variable=="data-action" and value =="/answer/content":
                    # if variable in dict_attrs and dict_attrs[variable]==value:
                        self.readingAnswer = 1
                        self.div_stack=['div']
            else : self.div_stack.append('div')
            
        # print(tag)
        pass

    def get_close_tag_data(tag, attrs):
        pass

    def end_close_tag_data(tag):
        pass

    def handle_data(self, data):
        if self.readingQuesionLink:
        #     self.Question += data
            self.Question[-1]["Question"]=data
        if self.readingAnswer :
            print(data)
    
    def handle_entityref(self, name):
    # 翻译HTML实体，如&amp;的函数，这里的变量 name = 'amp'
    # 表达式1 
        if name in entitydefs :
    # entitydefs应该是一个字典，name 属性与对应的翻译
            self.handle_data(entitydefs[name])
        else:
            self.handle_data('&' + name + ';')
    # 表达式2
        # self.handle_data(entitydefs[name] if name in entitydefs else '&' + name + ';')

    # 转换字符参考
    def handle_charref(self, name):
        try :
            charnum = int (name)
        except ValueError as e :
            return
        
        self.handle_data(chr(charnum))


    def handle_endtag(self, tag):
        if tag == 'a':
            self.readingQuesionLink = 0
        if tag == 'div' and self.readingAnswer :
            self.div_stack.pop()
            if not self.div_stack:
                self.readingAnswer = 0

    def getZhihuQuestion(self):
        return self.Question

# HTMLParser的子方法 feed()会恰当调用 handle_starttag, handle_data, handle_endtag
# 方法，handle_data()方法会检查是否从TITLE元素中取得数据，如果是，己保存数据
if __name__ == '__main__' :
    with open ("./temp1.txt",'r', encoding='utf-8') as fd :
        print("begin")
        tp = ZhihuAnswerParser()
        tp.feed(fd.read())
        # for l in tp.getZhihuQuestion():
        #     print (l)
