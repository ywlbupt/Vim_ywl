#!/usr/bin/env python
# -*- coding: utf-8 -*-

def a():
    hehe=6
    def f():
        global hehe
        print(hehe)
        hehe=3
    f()
    print(hehe) 
a()
