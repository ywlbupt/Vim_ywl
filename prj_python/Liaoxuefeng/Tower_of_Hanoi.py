#!/usr/etc/env python3
# coding:utf-8

# Tower_of_Hanoi , 汉诺塔
# 尾递归优化

def move(n, a, b, c):
    if n == 1 :
        print ("%s --> %s" % (a, c))
    else:
        move(n-1, a, c, b)
        print ("%s --> %s" % (a, c))
        move(n-1, b, a, c)

# 期待输出:
# A --> C
# A --> B
# C --> B
# A --> C
# B --> A
# B --> C
# A --> C

move(3, 'A', 'B', 'C')
