#!/usr/bin/env python3
# coding:utf-8

from bs4 import BeautifulSoup
import re
import pdb


html_doc = """
<html><head><title>The Dormouse's story</title></head>
<body>
<p class="title"><b>The Dormouse's story</b></p>

<p class="story">Once upon a time there were three little sisters; and their
names were
<a href="http://example.com/elsie" class="sister" id="link1">Elsie</a>,
<a href="http://example.com/lacie" class="sister" id="link2">Lacie</a> and
<a href="http://example.com/tillie" class="sister" id="link3">Tillie</a>;
and they lived at the bottom of a well.</p>

<p class="story">...</p>
"""

# soup = BeautifulSoup(html_doc, "lxml")

# with open("./temp.txt", 'r', encoding= "utf-8") as fd :
fd = open("./temp.html", 'r', encoding="utf-8")
if fd:

    zhihu_title = soup.find("head").find("title")
    print ("Title : ",zhihu_title.string)

    question_no=0
    question_set = soup.find_all("a", class_="question_link")
    for  question in question_set:
        question_no += 1
        print(question_no,"\t:", question.string,":",question["href"] )

    fd.close()
