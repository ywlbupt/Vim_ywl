#!/usr/bin/env python
# -*- coding:utf -8-*-
# RSA的加密解密

import rsa,binascii

# pubkey , n
# 65537 , e
# rkey , d

# 65537 = int("10001", 16)
def pwdrsa_encrypt(pubkey , password ):
    rsaPublickey = int(pubkey, 16)
    key = rsa.PublicKey(rsaPublickey, 65537) #创建公钥
    message =  password #拼接明文js加密文件中得到
    passwd = rsa.encrypt(message.encode(), key) #加密
    passwd = binascii.b2a_hex(passwd) #将加密信息转换为16进制，并转换成byte型。
    return passwd

def pwdrsa_decrypt(pubkey , password, rkey):
    # passwd = binascii.a2b_hex(pwd)
    c = int(password , 16)
    n = int(pubkey, 16)
    d = int(rkey, 16)
    messageint = (c**d)%n
    pass

    
if __name__ == '__main__' :
    pubkey = "bd0938e8312a91f31f8f15e575246b0fcd068d33c2b730e0f1bed18678649e3f"
    rkey = "47fd626fc836a5aac66995a8cd960384"
    password = "tianmeng"
    pwd = pwdrsa_encrypt(pubkey , password )
    print(pwd)




    # pwd = pwdrsa_decrypt(pubkey, pwd , rkey )
    # print("decrypt pwd: ", pwd)

# pwd,tianmeng: 0361f62725e7927dfaaf58e32f815b6f2c60083df82097f175b97b67ae503e06
