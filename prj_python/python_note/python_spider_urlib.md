# [Python][Spider][urllib]爬虫基础-urlib
[python|urllib|spider]

注:  
_python 3.x中urllib库和urilib2库合并成了urllib库。  
其中urllib2.urlopen()变成了urllib.request.urlopen()  
urllib2.Request()变成了urllib.request.Request()_

## urllib.request.(urlopen, Request)

使用urllib.request库中的urlopen(url)函数来打开网页，函数参数url只能接受utf-8编码方式(因为Python脚本文件用utf-8编码)

urlopen一般接受三个参数，它的参数如下：`urlopen(url, data, timeout)`
> 第二三个参数是可以不传送的，data默认为空 None，timeout默认为 `socket._GLOBAL_DEFAULT_TIMEOUT`

> 第一个参数URL是必须要传送的，执行urlopen方法之后，返回一个**response对象**，返回信息便保存在这里面。

``` python
from urllib import request
url = "https://api.douban.com/v2/book/2129650"
Urequest = request.Request(url)
with request.urlopen(Urequest, timeout=5) as f:
    print(f.read().decode('utf-8'))
```

## HTTP 请求报文

``` python
from urllib import request
url = "https://api.douban.com/v2/book/2129650"
Urequest = request.Request(url)
with request.urlopen(Urequest, timeout=5) as f:
    data = f.read()
    print ('Status:', f.status, f.reason)
    # print(f.read().decode('utf-8'))
    for k, v in f.getheaders() :
        print ("%s : %s" % (k, v))
    > print("Data: ", data.decode('utf-8'))
```
## User-Agent

如何让网站们把我们的Python爬虫当成正规的浏览器来访. 因为如果不这么伪装自己, 有的网站就爬不回来了（有的网站专门拦截爬虫程序）. 如果看过理论方面的知识, 就知道我们是要在 GET 的时候将 User-Agent 添加到header里.

urllib提供的功能就是利用程序去执行各种HTTP请求。如果要模拟浏览器完成特定功能，需要把请求伪装成浏览器。伪装的方法是先监控浏览器发出的请求，再根据浏览器的请求头来伪装，User-Agent头就是用来标识浏览器的。

**Fiddler**

## Cookie 

有些网站需要登录后才能访问某个页面，在登录之前，你想抓取某个页面内容是不允许的。那么我们可以利用Urllib2库保存我们登录的Cookie，然后再抓取其他页面就达到目的了。

本来处理 Cookies 是个麻烦的事情, 不过 Python 的 http.cookiejar 库给了我们很方便的解决方案, 只要在创建 opener 的时候将一个 HTTPCookieProcessor 放进去, Cookies 的事情就不用我们管了

``` python
import http.cookiejar
import urllib.request
def getOpener(head):
    # deal with the Cookies
    cj = http.cookiejar.CookieJar()
    pro = urllib.request.HTTPCookieProcessor(cj)
    opener = urllib.request.build_opener(pro)
    header = []
    for key, value in head.items():
        elem = (key, value)
        header.append(elem)
    opener.addheaders = header
    return opener
```
getOpener 函数接收一个 head 参数, 这个参数是一个字典. 函数把字典转换成元组集合, 放进 opener. 这样我们建立的这个 opener 就有两大功能:
* 自动处理使用 opener 过程中遇到的 Cookies
* 自动在发出的 GET 或者 POST 请求中加上自定义的 Header

## Proxy 代理 ProxyHandler

示例代码
```
proxy_handler = urllib.request.ProxyHandler({'http': 'http://www.example.com:3128/'})
proxy_auth_handler = urllib.request.ProxyBasicAuthHandler()
proxy_auth_handler.add_password('realm', 'host', 'username', 'password')
opener = urllib.request.build_opener(proxy_handler, proxy_auth_handler)
with opener.open('http://www.example.com/login.html') as f:
    pass
```

## str & bytes 编码问题

1. bytes 不能 encode 为 'gbk'的编码方式
2. bytes has not attribute of 'encode' 
3. python3中默认的str为unicode的，可以使用str.encode来转为bytes类型。
4. python3的`print`函数只支持`unicode`的str，貌似没有对bytes的解码功能，所以对对不能解码的bytes不能正确输出。

