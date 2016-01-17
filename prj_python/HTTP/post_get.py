#!/usr/bin/env python3
# coding:utf-8

from urllib import request, parse

print("Try logging in douban")

url = "http://www.zhihu.com"
email = "ywlywl48@foxmail.com"
password = "yanweilin12132"

# 从Login的form data中得到
login_douban_data = parse.urlencode([
        ('username', email),
        ('password', password),
        ])

login_data = login_douban_data
# req = request.Request(url, data=login_data.encode('utf-8'))
# 使用cookies登录zhihu.com
req = request.Request(url)


# 添加请求报头Request Header的内容，需F12监控浏览器获取
req.add_header('user-agent', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36')

# zhihu.cookie 201660116
req.add_header('Cookie', '_za=3976a6dd-3d6c-49a4-99a7-8e103080dcba; _ga=GA1.2.1186659886.1436229393; tc=AQAAAKxBlR/8EwAAgAAKPOYmUCi5x1gg; _xsrf=76d42e4972e3d7a540962c3df484334f; cap_id="ZjgwZjE4Nzc4ZTg2NDMyOWE3MWY0MWUwMDI4NTc0ZTg=|1450457542|ee54a9e845f0ea467d3b42d86c5085d8a9997024"; z_c0="QUFDQUIxd2FBQUFYQUFBQVlRSlZUZDNHbTFaU015M3NZQlp3TUZFY2hqTnh1R1VqdFM2YVNRPT0=|1450457565|aac85a06a53c696ced359d08206ee68407cec629"; q_c1=f10da26e26964e118ed5f55fdc3d8325|1452268838000|1436229418000; __utmt=1; __utma=51854390.1186659886.1436229393.1452931688.1452958648.14; __utmb=51854390.5.9.1452958714399; __utmc=51854390; __utmz=51854390.1452477390.6.5.utmcsr=baidu|utmccn=(organic)|utmcmd=organic; __utmv=51854390.100-1|2=registration_date=20130223=1^3=entry_date=20130223=1')

# Connection加速socket访问，不用每次都重新打开新的socket连接
req.add_header('Connection', 'keep-alive')

with request.urlopen(req) as response :
    print(response.geturl())
    print(response.getcode())
    print(response.info())
    # print(response.read())
    with open('./temp.txt', 'w', encoding ='utf-8') as f:
        f.write(response.read().decode('utf-8'))
