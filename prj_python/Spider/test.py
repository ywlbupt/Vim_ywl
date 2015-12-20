#!/usr/bin/python
#coding: UTF-8
"""
@author: CaiKnife

根据函数名称动态调用
"""

class filter_tag_attrs(object):
    tags = []
    readingprocess = []
    def __init__(self,tag,attrs,*, p_nest_next=None, p_follow_next=None):
        self.tag = tag
        self.attrs = attrs

        # self.__class__.tags.append(tag)
        # self.__class__.readingprocess.append(self.__name__())

        self.p_nest_next = p_nest_next
        self.p_follow_next = p_follow_next
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
    # a = filter_tag_attrs("div", "handle_answer_parser", [("data-action","/answer/content"),
    #                 ("data-author-name","扬")], None)
    # b = filter_tag_attrs("end", "handle_answer_parser", [("data-action","/answer/content"),
    #                 ("data-author-name","杨扬")], a)
    answer_parser1_next = filter_tag_attrs("div", 
            [("class","zm-editable-content clearfix")]
            )
    answer_wrap2 = filter_tag_attrs("div", 
            [("data-action","/answer/content"), ("data-author-name","Laurel Dong" )]
            , **{"p_nest_next": answer_parser1_next})
