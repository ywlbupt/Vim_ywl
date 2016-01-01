# coding:utf-8

import requests
r = requests.get('https://www.baidu.com')
print(r.text)
print(r.encoding)
print(r.status_code)
