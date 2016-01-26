#!/usr/bin/env python
# -*- coding:utf -8-*-
# author : Wlin
# Date : Sat Jan 23 19:56:21 CST 2016
# Description: 登录renren.com，并爬取我的好友的列表

import requests
import lxml
from bs4 import BeautifulSoup
import re
import strrsa
import encrypt
import os,sys
import json
import pickle

class RenrenSpider():

    url = "http://www.renren.com"

    loginurl = "http://www.renren.com/ajaxLogin/login?1=1&uniqueTimestamp={0}"
    uniqueTimestamp = "2016001924316"
    loginurl = loginurl.format(uniqueTimestamp)
    #  Login do not need timestamp
    loginurl = "http://www.renren.com/ajaxLogin/login?1=1"

    getEncryptKeyurl = "http://login.renren.com/ajax/getEncryptKey"
    showcaptchaurl = "http://www.renren.com/ajax/ShowCaptcha"
    #  验证码获取网址
    captchaurl = "http://icode.renren.com/getcode.do?t=web_login"
    # 验证码图片保存路径与名字，sys.path[0]为当前工作目录
    captchaFile = os.path.join(sys.path[0], "captcha.jpg")
    cookieFile = os.path.join(sys.path[0], "cookie")
    
    headers = {
    'Connection':'keep-alive',
    'User-Agent':'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36'
}
    def __init__(self):
        self.__session = requests.Session()
        self.__session.headers = self.headers
        
        self.__cookies = self.__loadCookies()
        # self.__cookies字典的形式
        # print(self.__cookies)

        if self.__cookies:
            print("检测到cookie文件，直接使用cookie登录")
            # self.__session.cookies.update(self.__cookies)
            # res = self.__session.get(self.url, timeout=10)
            res = self.__session.get(self.url, cookies = self.__cookies, timeout=10)
            m = re.search ('name\s*:\s*"(?P<name>.*?)"', res.text)
            print ("Login usr :", m.group("name"))

            pass
        else:
            print("没有找到cookie文件，请调用login方法登录一次！")
            self.__login()
        pass
   
    def __login(self, usrname="ywlywl48@gmail.com", password="yanweilin"):
        res = self.__session.get(self.getEncryptKeyurl, timeout = 10)
        print("=" * 50)
        rkey = res.json()["rkey"]
        e = res.json()["e"]
        n = res.json()["n"]
        self.maxdigits = res.json()["maxdigits"]
        print("rkey :", res.json()["rkey"])
        print("n :", res.json()["n"])
        print("e :", res.json()["e"])
        print("maxdigits :", res.json()["maxdigits"])
        print("=" * 50)

        res = self.__session.get(self.url, timeout = 10)
        # print(res.text)
        m = re.search ("_rtk\s*:\s*'(?P<rtk>\w+)'", res.text)
        print("=" * 50)
        rtk = m.group("rtk")
        print(m.group("rtk"))
        print("=" * 50)

        captchadata = {
            "email" : usrname , 
            "_rtk" : rtk
                }
        res = self.__session.post(self.showcaptchaurl, data = captchadata, timeout = 10)
        print ("yanzhengma:", res.text)
        if res.text.strip()=="0" :
            captcha_flag = 0
            print ("不需要验证码")
            pass
        else :
            captcha_flag = 1
            print ("需要输入验证码")

        login_data = {
                'email': usrname , 
                'autoLogin':'true' ,
                'origURL': 'http://www.renren.com/homea',
                'domain': 'renren.com',
                'key_id': '1',
                'captcha_type':'web_login',
                # 'password' : strrsa.pwdrsa_encrypt(n , password), 
                'password' : str(encrypt.encryptString(e, n , password)), 
                'rkey' : rkey 
                }
        if captcha_flag: # 如果需要验证码，人工输入
            res = self.__session.get(self.captchaurl)
            captcha = res.content
            with open(self.captchaFile, "wb") as output:
                output.write(captcha)
            captcha = input("请输入验证码：")
            login_data["icode"] = captcha
            os.remove(self.captchaFile)

        res = self.__session.post(self.loginurl, data = login_data, timeout = 10)
        print (str(encrypt.encryptString(e, n , password)))
        print (res.text)
        # code == True represent login succeed
        if res.json()['code']:
            print("Login successed!")
            self.__savecookies(res.cookies)
        else :
            print("Login Failed!")

    def __savecookies(self, requests_cookiejar):
        """cookies 序列化到文件
        即把dict对象转化成字符串保存
        """
        with open(self.cookieFile, "wb") as f:
            # cookies = self.__session.cookies.get_dict()
            # json.dump(cookies, f)
            pickle.dump(requests_cookiejar, f)
            print("=" * 50)
            print("已在同目录下生成cookie文件：", self.cookieFile)

    def __loadCookies(self):
        """读取cookie文件，返回反序列化后的dict对象，没有则返回None"""
        if os.path.exists(self.cookieFile):
            print("=" * 50)
            with open(self.cookieFile, "rb") as f:
                # cookies = json.load(f)
                # cookies = [key + "=" + value for key, value in cookies.items()]
                # cookies = ";".join(cookies)
                # return {'Cookie': cookies}
                # return cookies
                return pickle.load(f)
        return None

    def getSession(self):
        return self.__session

if __name__ == '__main__' :
    client = RenrenSpider()
    pass
