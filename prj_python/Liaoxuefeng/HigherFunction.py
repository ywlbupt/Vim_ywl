#!/usr/bin/env python3
# coding:utf-8

# map
# def normalize(name):
#     return name[0].upper() + name[1:].lower()

# # 测试:
# L1 = ['adam', 'LISA', 'barT']
# L2 = list(map(normalize, L1))
# print(L2)


# reduce
## from functools import reduce
# import functools

# def prod(L):
#     return functools.reduce(lambda x,y : x*y, L)

# print(prod([1,2,3,4,5]))


# reduce map
import functools

def str2float(s):
    strx = s.split('.')
    Part1 = functools.reduce(lambda x,y:10*x+y, list(map(int,strx[0])))
    if len(strx)==2 :
        Part2 = functools.reduce(lambda x,y:10*x+y, list(map(int,strx[1])))
        return Part1+Part2/10**len(strx[1])
    return Part1

print('str2float(\'123.456\') =', str2float('123.456'))
