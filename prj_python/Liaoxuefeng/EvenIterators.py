#!/usr/bin/env python3
# coding:utf-8

class EvenIterators(object):
    '''
    自定义偶数迭代器
    '''
    def __init__(self, n):
        self.stop = n
        self.value = 0
    
    def __iter__(self):
        return self
    
    def __next__(self):
        if self.value > self.stop:
            raise StopIteration
        r = self.value
        self.value += 2
        return r

even_iter = EvenIterators(9)

for x in EvenIterators(9):
    print(x)
