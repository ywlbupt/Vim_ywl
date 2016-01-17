#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Author: LoveNight

import requests
from bs4 import BeautifulSoup
import lxml

import time
import json
import os
import re
import sys
import subprocess

headers = {
    'Host':'www.zhihu.com', 
    'Referer':'http://www.zhihu.com/',
    'Upgrade-Insecure-Requests':'1',
    'Connection':'keep-alive',
    'Accept-Encoding':'gzip, deflate, sdch', 
    'Accept':'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
    'User-Agent':'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36'
        }

# 存放验证码的路径及文件名
captchaFile = os.path.join(sys.path[0], "captcha.gif")

capachaURL = r"http://www.zhihu.com/captcha.gif"
homeURL = r"http://www.zhihu.com"
ses = requests.Session()
req = ses.get(homeURL)

# 添加请求requests headers
ses.headers = headers

soup = BeautifulSoup(req.text, "lxml")
param_xsrf = soup.find('input', {'name':'_xsrf'})['value']
print (param_xsrf)
print ("file path : ", captchaFile)
# post data表单数据
data = {
    '_xsrf': param_xsrf,
    'password':'yanweilin',
    'email':'ywlywl48@foxmail.com',
    'remember_me':'true',
    # 'captcha':
        }


