#!/usr/bin/env python3
# coding:utf-8

import logging
# logging.basicConfig(level=logging.INFO)
# import pdb

def fact(n):
    '''
    >>> fact(1)
    1
    >>> fact(8)
    40320
    >>> fact(-2)
    Traceback (most recent call last):
        ...
    ValueError
    '''
    if n < 1:
        raise ValueError()
    if n == 1:
        return 1
    return n * fact(n - 1)

if __name__ == '__main__':
    import doctest
    doctest.testmod()
