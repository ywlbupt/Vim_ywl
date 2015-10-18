#!/usr/bin/env python3
# coding:utf-8

L = [('Bob', 75), ('Adam', 92), ('Bart', 66), ('Lisa', 88)]

def by_score(t):
    return t[1]

# 按照分数从高到低排序
L2 = sorted (L , key = by_score, reverse=True)
print(L2)
L3 = sorted(L, key = lambda x : x[1], reverse=True)
print (L3)

