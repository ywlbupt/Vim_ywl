#! /usr/bin/env python3
# -*- coding=utf-8 -*-

# 考虑自闭合标签
# 考虑答案内容里面的标签的处理 ，转化成简单的 markdown 格式 
# 应该以 Parser的内容为Key值 
# 以指针的形式指向嵌套的标签内容
# dingzhi class , delete , counter
# 多个parser的data 处理

from html.parser import HTMLParser
from html.entities import entitydefs
import os
import pdb

unique_tag={'br','ul','li'}

# 定义 tag, 
class filter_tag_attrs(object):
    tags = []
    def __init__(self,tag,func,attrs,p_next=None ):
        self.tag = tag
        self.func = func
        self.attrs = attrs

        self.p_next = p_next
        self.p_last = None
        self.tag_stack = []
        pass



class ZhihuAnswerParser(HTMLParser):
    
# 调用父类HTMLParser的初始化函数
# 在创建实例的时候，把一些我们认为必须绑定的属性强制填写进去。
# 通过定义一个特殊的__init__方法
# 这里给子类添加 title 和 readingQuesionLink 这两个属性
    def __init__(self):
        self.Question = []
        self.AnswerData = ""

        self.processingparser = None
        self.readingQuesionLink = 0
        self.readingflag = 0
        self.nestreading = 0

        self.tag_stack = []

        self.parenturl = "www.zhihu.com"
        answer_parser1_next = filter_tag_attrs("div", "handle_startparser" ,
                [("class","zm-editable-content clearfix")]
                )
        answer_parser2_next = filter_tag_attrs("div", "handle_startparser" ,
                [("class","zh-summary summary clearfix" )]
                )
        answer_parser3 = filter_tag_attrs("a", None ,
                [("class","question_link")]
                , [answer_parser2_next])
        answer_parser2 = filter_tag_attrs("div", None ,
                [("data-action","/answer/content"), ("data-author-name","阿猫Knight" )]
                , [answer_parser2_next])
        answer_parser1 = filter_tag_attrs("div", None ,
                [("data-action","/answer/content"), ("data-author-name","杨扬" )]
                , [answer_parser1_next])
        self.list_parser = [answer_parser1,answer_parser2, answer_parser3]
        HTMLParser.__init__(self)

    def handle_startparser(self,parser):
        self.readingflag = 1
        pass

    def handle_end_answer_parser(self,tag):
        # if self.readingflag and self.tag_stack :
        if self.processingparser and self.processingparser.tag_stack :
            if tag==self.processingparser.tag_stack[-1]:
                # pdb.set_trace()
                self.processingparser.tag_stack.pop()
                self.handle_data("</%s>" % tag)
            else : pass
            if not self.processingparser.tag_stack :
                print ("ending processing")
                print (self.processingparser.attrs)
                self.readingflag = 0
                if self.processingparser :
                    self.processingparser = self.processingparser.p_last
        pass
   

    def handle_starttag(self, tag, attrs):
    # tag是的html标签，attrs是 (属性，值)元组(tuple)的列表(list). 
        if tag in unique_tag : 
            self.handle_data("<%s>" % tag)
            return

        if self.processingparser and not self.processingparser.p_next :
            self.processingparser.tag_stack.append(tag)
            self.handle_data("<%s>" % tag)
            return
        elif not self.processingparser:
            list_parser = self.list_parser
        elif self.processingparser.p_next :
            list_parser = self.processingparser.p_next

        for parser in list_parser:
            print ("processing paser")
            print (parser.attrs)
            if tag == parser.tag:
                print ("Paser Attrs:", parser.attrs)
                print ("Attrs:", attrs)
                tag_attrs = parser.attrs
                if tag_attrs and set(tag_attrs) <= set(attrs):
                    print ("get right paser")
                    parser.p_last = self.processingparser
                    self.processingparser = parser
                    parser.tag_stack = [parser.tag]
                    if parser.func:
                        getattr(self,parser.func)(parser)
                    self.handle_data("\nbegin <%s>" % tag)
                    return
        if self.processingparser :
            self.processingparser.tag_stack.append(tag)
            self.handle_data("<%s>" % tag)
        return


        # if tag == 'a':
        #     if len(attrs)== 0 : pass
        #     else :
        #         for(variable, value) in attrs:
        #             if variable=='class' and value == 'question_link' :
        #                 self.readingQuesionLink = 1
        #             if variable== 'href' and self.readingQuesionLink :
        #                 self.Question.append (
        #                         {"Question":"","link":(value+self.parenturl)})

    def handle_data(self, data):
        if self.readingflag:
            self.AnswerData += data
        pass
    
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
        self.handle_end_answer_parser(tag)
        pass

    def getZhihuAnswerData(self):
        return self.AnswerData

# HTMLParser的子方法 feed()会恰当调用 handle_starttag, handle_data, handle_endtag
# 方法，handle_data()方法会检查是否从TITLE元素中取得数据，如果是，己保存数据
if __name__ == '__main__' :
    with open ("./temp1.txt",'r', encoding='utf-8') as fd :
        tp = ZhihuAnswerParser()
        tp.feed(fd.read())
        print(tp.getZhihuAnswerData())
