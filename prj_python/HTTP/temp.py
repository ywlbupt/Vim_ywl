#!/usr/bin/env python
# -*- coding: utf-8 -*-


from bs4 import BeautifulSoup as BS

with open("temp.html", "r", encoding = 'utf-8') as output:
    soup= BS(output.read(), "html.parser")
    question_set = soup.find_all("a", class_="question_link")
    for question in question_set :
        print(question.string)
