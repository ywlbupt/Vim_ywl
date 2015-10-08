#!/usr/bin/env python3
# coding:utf-8

import math

def quadratic(a, b, c):
# 一元二次方程求解
# 先检查三个参数是否符合类型要求
# 再检查 b*b-4*a*c >0，否则无解
    if not isinstance(a, (int, float)):
        raise TypeError ("Wrong Type Input")
    if not isinstance(b, (int, float)):
        raise TypeError ("Wrong Type Input")
    if not isinstance(c, (int, float)):
        raise TypeError ("Wrong Type Input")
# 再检查 a 是否等于0，等于0时该方程式属于一元一次方程
    if a ==0 :
        return -1*c/b
    else:
        if b*b-4*a*c < 0 :
            return "There is not result, For b^2-4ac < 0 !!!"
        else:
            delta = math.sqrt(b*b-4*a*c)
            return (-1*b+delta)/(2*a) , (-1*b-delta)/(2*a)

# # 测试:
# print(quadratic(2, 3, 1)) 
# # => (-0.5, -1.0)
# print(quadratic(1, 3, -4)) 
# # => (1.0, -4.0)
# print(quadratic(2, 2, 1)) 
