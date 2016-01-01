#! /usr/bin/env python
# -*- coding=utf-8 -*-

# 考虑答案内容里面的标签的处理 ，转化成简单的 markdown 格式 
# 定制 class , delete , counter
# 多个parser的data 处理

from html.parser import HTMLParser
from html.entities import entitydefs
import os
import pdb # pdb.set_trace()
import logging
logging.basicConfig(level = logging.INFO)

unique_tag=['br','img']
open_tag = ['ul','li','p','title']

# 定义 tag, Serve for ZhihuAnswerParser
class filter_tag_attrs(object):
    def __init__(self,tag,attrs, p_nest=None):
        self.tag = tag
        self.attrs = attrs

        self.p_nest = p_nest
        
        self.p_last = None
        self.tag_stack = []
        self.data = ""
        pass

    def set_tag_data(self, data):
        self.data += data
        pass

    def get_tag_data(self):
        return self.data

class ZhihuAnswerParser(HTMLParser):
    
# 调用父类HTMLParser的初始化函数
# 在创建实例的时候，把一些我们认为必须绑定的属性强制填写进去。
# 通过定义一个特殊的__init__方法
# 这里给子类添加 title 和 readingQuesionLink 这两个属性

    def __init__(self, list_parser):
        self.Question = []
        self.data = ""

        self.processingparser = None
        self.readingflag = 0

        self.parenturl = "www.zhihu.com"

        self.list_parser = list_parser
        
        HTMLParser.__init__(self)

    def handle_end_answer_parser(self,tag):
        if self.processingparser and self.processingparser.tag_stack :
            if tag==self.processingparser.tag_stack[-1]:
                self.processingparser.tag_stack.pop()
                if self.processingparser.tag_stack :
                    self.format_endtag(tag)
                else: 
                    self.handle_data(os.linesep)
                    self.readingflag = 0
                    if self.processingparser :
                        self.processingparser = self.processingparser.p_last
        pass

    def handle_starttag(self, tag, attrs):
    # tag是的html标签，attrs是 (属性，值)元组(tuple)的列表(list). 
        if tag in unique_tag : 
            self.format_tag(tag)
            return

        if self.processingparser and not self.processingparser.p_nest :
            self.processingparser.tag_stack.append(tag)
            self.format_tag(tag)
            return
        elif not self.processingparser:     # 如果当前没有在执行的Parser
            list_parser = self.list_parser
        elif self.processingparser.p_nest :  #如果当前执行的Parser属于嵌套
            list_parser = self.processingparser.p_nest

        for parser in list_parser:
            if tag == parser.tag:
                tag_attrs = parser.attrs
                # if tag_attrs and set(tag_attrs) <= set(attrs):
                if set(tag_attrs) <= set(attrs):
                    parser.p_last = self.processingparser
                    self.processingparser = parser
                    parser.tag_stack = [parser.tag]
                    if not parser.p_nest :
                        self.readingflag = 1
                    # if parser.func:
                    #     getattr(self,parser.func)(parser)
                    return
        # 如果正在处理一个parser且paser.p_nest为空  
        if self.processingparser :
            self.processingparser.tag_stack.append(tag)
            self.format_tag(tag)
        return

    def format_tag(self, tag):
        # self.handle_data("<%s>" % tag)
        pass
    
    def format_endtag(self, tag):
        # self.handle_data("</%s>" % tag)
        pass

    def handle_data(self, data):
        if self.readingflag:
            self.processingparser.set_tag_data(data)
            self.data += data
            return

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

    # f = open('./response.txt', 'w', encoding ='utf-8')
    answer_parser1_next = filter_tag_attrs("div", 
            [("class","zm-editable-content clearfix")]
            )
    answer_parser2_next = filter_tag_attrs("div", 
            [("class","zh-summary summary clearfix" )]
            )
    answer_wrap2 = filter_tag_attrs("div", 
            [("data-action","/answer/content"), ("data-author-name","Laurel Dong" )]
            , [answer_parser1_next])
    answer_wrap1 = filter_tag_attrs("div", 
            [("data-action","/answer/content")]
            ,[answer_parser1_next])
    question_parser1_next = filter_tag_attrs("a", 
            [("class","question_link")]
             )
    
    with open ("./temp.txt",'r', encoding='utf-8') as fd :
        tp = ZhihuAnswerParser([question_parser1_next])
        tp.feed(fd.read())
        print(question_parser1_next.get_tag_data())

        # f.write(tp.getZhihuAnswerData())
    # f.close()
