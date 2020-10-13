#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os

def check_create_dir(rfile_path):
    ''' rfile_path 仅支持相对路径 format "./relative"
    '''
    stack_rdir = []
    rpath, file_name = os.path.split(rfile_path)

    while rpath and rpath!="." and not os.path.exists(rpath):
        stack_rdir.append(rpath)
        rpath ,rpath_dir = os.path.split(rpath)

    while stack_rdir:
        dir_n = stack_rdir.pop()
        os.mkdir(dir_n)

if __name__ == "__main__":
    pass
