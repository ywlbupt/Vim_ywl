#!/usr/bin/env python3
# coding:utf-8


def is_palindrome(n):
    s = str (n)
    i = 0
    while i <= len(s)/2:
        if s[i] != s[-1-i]:
            return False
        i += 1
    return True


# 测试:
output = filter(is_palindrome, range(1, 1000))
# 输出的output是一个迭代对象
print(list(output))
