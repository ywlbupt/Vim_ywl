#!/etc/bin/env python
# -*-coding:utf-8-*-

import requests
import json

class ByrSpider():

    url = r"http://bbs.byr.cn/index"
    loginurl = r"http://bbs.byr.cn/user/ajax_login.json"
    LOGINMODE = {"nForum":'0', "PHONE":'2'}
    COOKIEDATE = {'nosave':'0','day':'1','month':'2','year':'3'}
    
    headers = {
            'Connection':'keep-alive', 
            'User-Agent':'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36',
            'X-Requested-With':'XMLHttpRequest'
            }

    def __init__(self):
        self.__session = requests.Session()
        self.__session.headers = self.headers
        print("try loging.....")
        self.__login()
        pass

    def __login(self, usrname= 'ywlbupt', password='yanweilin'):

        login_data = {
                "id" :usrname , 
                "passwd" : password ,
                'mode' : self.LOGINMODE['nForum'], 
                'CookieDate' : self.COOKIEDATE['year']
                }
        # res = self.__session.get(self.url, timeout = 10)
        # res = self.__session.post(self.loginurl,data=json.dumps(login_data),timeout = 10)
        res = self.__session.post(self.loginurl,data=login_data,timeout = 10)
        print(res.text)


if __name__ == '__main__':
    client = ByrSpider()
    pass


# X-Requested-With":"XMLHttpRequest 是Ajax异步请求headers
