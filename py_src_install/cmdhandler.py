#!/usr/bin/env python
##=============================================================================
##
## Author: ywlbupt - ywlbupt@163.com
##
## Last modified:	2020-10-12 14:59
##
## Filename:		cmdhandler.py
##
## Description: 
##
##=============================================================================
import os

class cmdhandler():
    """Wrapper of cmd"""
    def __init__(self):
        pass

    def cmdpy(self, cmdstr):
        with os.popen(cmdstr) as f:
            pass

    def cmdpy_get(self, cmdstr):
        with os.popen(cmdstr) as f:
            res = f.read()
        return res

    def get_environ(self, VAR):
        """TODO: 获取环境变量值
        :arg1: 环境变量
        :returns: 环境变量返回值
        """
        return os.getenv(VAR)

    def get_OS_HOME(self):
        return self.get_environ("HOME")

if __name__ == "__main__":

    ##################### 设置临时环境变量 
    # 设置环境变量
    # os.environ['WORKON_HOME']="value"
    # # 获取环境变量方法1
    # os.environ.get('WORKON_HOME')
    # #获取环境变量方法2(推荐使用这个方法)
    # os.getenv('path')
    # # 删除环境变量
    # del os.environ['WORKON_HOME']
    m = cmdhandler()
    res = m.get_environ("PATH")
    print(res)
