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

<div class="zm-editable-content clearfix">
 1. 把公司名字，自己的联系方式写错的，通通秒杀，特别是把“创新工场”写成“创新工厂”的<br><br>2. 放些无意义的照片；<br><br>3. 太jumpy的；<br><br>4. 简历好像写自传，长篇大论，没有条理的；<br><br>5. 过分邀功，且精通各项技能的；<br><br>6. 写无关紧要的东西的，例如：每天做500个俯卧撑；<br><br>7. 要求薪水达到多少多少，否则免谈的； 

</div>
<p class="story">...</p>
</body>
</html>
"""

re_tag = "a"
re_dict = {"class_": "question_link"}


fd = open("./answer.html", 'r', encoding="utf-8")
if fd:
    soup = BeautifulSoup(fd.read(), "lxml")
    # soup = BeautifulSoup(html_doc, "lxml")
    zhihu_title = soup.find("head").find("title")
    print ("Title : ",zhihu_title.string.strip())

    i=0
    question_set = soup.find_all(re_tag, **re_dict)
    for  question in question_set:
        i += 1
        # print(i,"\t:", question.string,":",question["href"] )

    i = 0 
    re_dict_answer = {"data-action":"/answer/content"}
    answer_set = soup.find_all("div",re_dict_answer)
    # answer_set = soup.find_all("div",class_="zm-editable-content clearfix")
    for answer in answer_set:
        print (answer.find("div",
            class_="zm-editable-content clearfix").get_text().strip())


    fd.close()


# [("data-action","/answer/content"), ("data-author-name","Laurel Dong" )]
