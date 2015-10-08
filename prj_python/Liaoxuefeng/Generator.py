#!/usr/bin/env python3
# coding:utf-8

def triangles():
    L = [1]
    yield L
    L = [1] + [1]
    yield L
    while True:
        L.insert(0,0)
        L.append(0)
        for i in range(len(L)-1):
            L[i]=L[i]+L[i+1] 
        L.pop()
        yield L


# 期待输出:
# [1]
# [1, 1]
# [1, 2, 1]
# [1, 3, 3, 1]
# [1, 4, 6, 4, 1]
# [1, 5, 10, 10, 5, 1]
# [1, 6, 15, 20, 15, 6, 1]
# [1, 7, 21, 35, 35, 21, 7, 1]
# [1, 8, 28, 56, 70, 56, 28, 8, 1]
# [1, 9, 36, 84, 126, 126, 84, 36, 9, 1]
n = 10
for t in triangles():
    if len(t) <= n :
        print(t)
    else: break
