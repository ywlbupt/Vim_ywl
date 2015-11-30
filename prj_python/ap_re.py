#!/usr/bin/env python3
# encoding: UTF-8

import re

# s="1-abc,2-abc,3-abc"
# pattern=r'(?P<name>\d)-(\w{3}),' #命名捕获组(?P<名字>) 注意：这里的P要大写
# m=re.search(pattern,s)
# print (m.group(),m.group(0))
# print (m.group(1))
# print (m.group(2))
# print (m.group(1,2,0))
# print (m.group('name'))
# m = re.search(pattern,s)
# print (m.groups())






with open("./Spider/temp.txt", 'r') as fo :
    data = fo.read()




# # a=re.compile(r'(\w{2})+')
# a=re.compile(r'(a)(b)a')
# m = a.match("ababa")
# # m = re.match(r'(\w{2})+','aabbcc')
# if m:
#     print m.groups()

# encoding: UTF-8
# pattern = re.compile(r'h')
# m = pattern.match('hi,hello world!')
# if m:
#     print m.groups()
