#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Author: LoveNight
# Date : 20160120
# From: http://lovenight.github.io/2015/11/11/Python%E6%A8%A1%E6%8B%9F%E7%99%BB%E5%BD%95%E7%9F%A5%E4%B9%8E/

import requests
import time
import json
import os
import re
import sys
import subprocess
from bs4 import BeautifulSoup as BS

# http://login.weibo.cn/login/?backURL=http%3A%2F%2Fweibo.cn%2F&backTitle=%E5%BE%AE%E5%8D%9A&vt=4&revalid=2&ns=1&pt=1
"""
backURL:http://weibo.cn/
backTitle:微博
vt:4
revalid:2
ns:1
pt:1
"""



class WeiboClient(object):

    """连接微薄的工具类，维护一个Session
    2016.01.20

    用法：

    client = WeiboClient()

    # 第一次使用时需要调用此方法登录一次，生成cookie文件
    # 以后可以跳过这一步
    client.login("username", "password")

    # 用这个session进行其他网络操作，详见requests库
    session = client.getSession()
    """

    # 网址参数是账号类型
    TYPE_PHONE_NUM = "phone_num"
    TYPE_EMAIL = "email"
    loginURL = r"http://www.zhihu.com/login/{0}"
    homeURL = r"http://www.zhihu.com"
    captchaURL = r"http://www.zhihu.com/captcha.gif"

    headers = {
        'User-Agent':'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36',
        "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
        "Accept-Encoding": "gzip, deflate",
        "Host": "login.weibo.cn",
        "Upgrade-Insecure-Requests": "1",
        "Connection": "keep-alive", 
    }

    captchaFile = os.path.join(sys.path[0], "weibo-captcha.gif")
    cookieFile = os.path.join(sys.path[0], "weibo-cookie")

    def __init__(self):
        os.chdir(sys.path[0])  # 设置脚本所在目录为当前工作目录

        self.__session = requests.Session()
        self.__session.headers = self.headers  # 用self调用类变量是防止将来类改名
        # 若已经有 cookie 则直接登录
        self.__cookie = self.__loadCookie()
        if self.__cookie:
            print("检测到cookie文件，直接使用cookie登录")
            self.__session.cookies.update(self.__cookie)
            soup = BS(self.open(r"http://www.zhihu.com/").text, "html.parser")
            print("已登陆账号： %s" % soup.find("span", class_="name").get_text())
        else:
            print("没有找到cookie文件，请调用login方法登录一次！")

    # 登录
    def login(self, username, password):
        """
        验证码错误返回：
        {'errcode': 1991829, 'r': 1, 'data': {'captcha': '请提交正确的验证码 :('}, 'msg': '请提交正确的验证码 :('}
        登录成功返回：
        {'r': 0, 'msg': '登陆成功'}
        """
        self.__username = username
        self.__password = password
        self.__loginURL = self.loginURL.format(self.__getUsernameType())
        # 随便开个网页，获取登陆所需的_xsrf
        html = self.open(self.homeURL).text
        soup = BS(html, "html.parser")
        _xsrf = soup.find("input", {"name": "_xsrf"})["value"]
        # 下载验证码图片
        while True:
            captcha = self.open(self.captchaURL).content
            with open(self.captchaFile, "wb") as output:
                output.write(captcha)
            # 人眼识别
            print("=" * 50)
            print("已打开验证码图片，请识别！")
            subprocess.call(self.captchaFile, shell=True)
            captcha = input("请输入验证码：")
            os.remove(self.captchaFile)
            # 发送POST请求
            data = {
                "_xsrf": _xsrf,
                "password": self.__password,
                "remember_me": "true",
                self.__getUsernameType(): self.__username,
                "captcha": captcha
            }
            res = self.__session.post(self.__loginURL, data=data)
            print("=" * 50)
            # print(res.text) # 输出脚本信息，调试用
            if res.json()["r"] == 0:
                print("登录成功")
                self.__saveCookie()
                break
            else:
                print("登录失败")
                print("错误信息 --->", res.json()["msg"])

    def __getUsernameType(self):
        """判断用户名类型
        经测试，网页的判断规则是纯数字为phone_num，其他为email
        """
        if self.__username.isdigit():
            return self.TYPE_PHONE_NUM
        return self.TYPE_EMAIL

    def __saveCookie(self):
        """cookies 序列化到文件
        即把dict对象转化成字符串保存
        """
        with open(self.cookieFile, "w") as output:
            cookies = self.__session.cookies.get_dict()
            json.dump(cookies, output)
            print("=" * 50)
            print("已在同目录下生成cookie文件：", self.cookieFile)

    def __loadCookie(self):
        """读取cookie文件，返回反序列化后的dict对象，没有则返回None"""
        if os.path.exists(self.cookieFile):
            print("=" * 50)
            with open(self.cookieFile, "r") as f:
                cookie = json.load(f)
                return cookie
        return None

    def open(self, url, delay=0, timeout=20):
        """打开网页，返回Response对象"""
        if delay:
            time.sleep(delay)
        return self.__session.get(url, timeout=timeout)

    def getSession(self):
        return self.__session

if __name__ == '__main__':
    try:
        client = WeiboClient()

        # 第一次使用时需要调用此方法登录一次，生成cookie文件
        # 以后可以跳过这一步
        # client.login("ywlywl48@foxmail.com", "yanweilin")

        # 用这个session进行其他网络操作，详见requests库
        session = client.getSession()
        response = session.get("http://www.zhihu.com",timeout = 20)
        # with open("temp.html", "wb") as output:
        #     output.write(response.content)
        zhihu_soup = BS(response.text, "html.parser")
        question_set = zhihu_soup.find_all("a", class_="question_link")
        for question in question_set :
             # print(question.string)
             print(question.get_text())
    except requests.exceptions.ConnectionError as e :
        print ("ConnectionError : ", e)
    except requests.exceptions.RequestException as e :
        print ("Error : ", e)

