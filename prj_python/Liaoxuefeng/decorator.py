#!/usr/bin/env python3
# coding:utf-8

import functools

def log(arg):
    # text = '' if hasattr(arg, '__call__') else arg    
    text = '' if callable(arg) else arg    
    # @functools.wraps(func)
    def decorator(func):
        @functools.wraps(func)
        def wrapper(*args, **kw):
            print('begin %s %s:' % (text, func.__name__))
            func(*args, **kw)
            print('end %s %s:' % (text, func.__name__))
        return wrapper
    # return decorator(arg) if hasattr(arg, '__call__') else decorator
    return decorator(arg) if callable(arg) else decorator


# @log('execute')
# def now():
#     print("new")

@log
def now():
    print("now")

now()
print(now.__name__)
