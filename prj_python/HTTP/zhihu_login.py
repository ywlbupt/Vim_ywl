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

captchaURL = r"http://www.zhihu.com/captcha.gif"
homeURL = r"http://www.zhihu.com"
LoginURL = r"https://www.zhihu.com/login/email"
ses = requests.Session()
req = ses.get(homeURL, timeout = 10)

# 添加请求requests headers
ses.headers = headers

soup = BeautifulSoup(req.text, "lxml")
param_xsrf = soup.find('input', {'name':'_xsrf'})['value']
print (param_xsrf)
print ("file path : ", captchaFile)
# post data表单数据

# response.content返回二进制数据
captcha = ses.get(captchaURL, timeout = 20).content
with open(captchaFile, "wb") as output :
# 写入图片的二进制数据，保存
    output.write(captcha)
print("=" * 50)
print("已打开验证码图片，请识别！")
# subprocess.call(['eog',captchaFile], shell = True)
subprocess.call(['eog',captchaFile])
captcha = input("请输入验证码：")
os.remove(captchaFile)
print("captcha: ", captcha)

data = {
    '_xsrf': param_xsrf,
    'password':'yanweilin',
    'email':'ywlywl48@foxmail.com',
    'remember_me':'true',
    'captcha': captcha
        }

res = ses.post(LoginURL, data = data, timeout = 20)
print("=" * 50)
# print(res.text) # 输出脚本信息，调试用
if res.json()["r"] == 0:
    print("登录成功")
    print("登录成功 --->", res.json()["msg"])
else:
    print("登录失败")
    print("错误信息 --->", res.json()["msg"])

print("url: ", res.url)
print("history: ", res.history)
print("res.json: ", res.json())
print("res.header[content-type]: ", res.headers['Content-Type'])
