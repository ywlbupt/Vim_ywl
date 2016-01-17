#!/usr/bin/env python3
# coding:utf-8

from lxml import etree
from bs4 import BeautifulSoup
import requests

import codecs
import re

homeURL = r"http://www.zhihu.com"

ses = requests.Session()
req = ses.get(homeURL)

with codecs.open("./zhihu-login.html","r", encoding = "utf-8" ) as fd :
# 打印内容
    # print(fd.read())
    # soup = BeautifulSoup(fd.read(), "lxml")
    soup = BeautifulSoup(req.text, "lxml")
    xsrf = soup.find('input', {'name':'_xsrf'})['value']
    if xsrf:
        print("xsrf :", xsrf)
    else: 
        print("nonetype")
