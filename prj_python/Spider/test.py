#!/usr/bin/python
#coding: UTF-8
"""
@author: CaiKnife

根据函数名称动态调用
"""

class filter_tag_attrs(object):
    tags = []
    readingprocess = []
    def __init__(self,tag,func,attrs,p_next=None):
        self.tag = tag
        self.func = func
        self.attrs = attrs

        self.__class__.tags.append(tag)
        self.__class__.readingprocess.append(self.__name__())

        self.p_next = p_next
        self.readingflag = 0
        pass
    
    def __name__(self):
        return "filter_tag_attrs"
    
    def __str__(self):
        return ("self filter_tag_attrs")

    def getreadingflag(self):
        return self.readingflag
        pass


if __name__ == '__main__':
    a = filter_tag_attrs("div", "handle_answer_parser", [("data-action","/answer/content"),
                    ("data-author-name","扬")], None)
    b = filter_tag_attrs("end", "handle_answer_parser", [("data-action","/answer/content"),
                    ("data-author-name","杨扬")], a)
    print(a)
