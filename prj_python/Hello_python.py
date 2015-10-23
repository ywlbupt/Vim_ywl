#!/usr/bin/env python3
# coding:utf-8

from urllib import request
url = "https://api.douban.com/v2/book/2129650"
Urequest = request.Request(url)
with request.urlopen(Urequest, timeout=5) as f:
    data = f.read()
    print ('Status:', f.status, f.reason)
    # print(f.read().decode('utf-8'))
    for k, v in f.getheaders() :
        print ("%s : %s" % (k, v))
    print("Data: ", data.decode('utf-8'))



# -----------------------------------------------------------------
# from urllib import request

# with request.urlopen('https://api.douban.com/v2/book/2129650') as f:
#     data = f.read()
#     print('Status:', f.status, f.reason)
#     for k, v in f.getheaders():
#         print('%s: %s' % (k, v))
#     print('Data:', data.decode('utf-8'))
# ------------------------------------------------------------------

def TestisStrOrUnicdeOrString():
  bs = b'Hello'
  ustr = 'abc'
  print (isinstance(bs, str))  #False
  print (isinstance(bs,bytes)) #True
  print (isinstance(ustr,str)) #True
  print (isinstance(ustr, bytes)) #False
  print (isinstance(bs,(bytes,str))) #True


# if __name__ == '__main__': 
#     TestisStrOrUnicdeOrString()
