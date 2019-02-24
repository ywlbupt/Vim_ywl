#!/usr/bin/env python
# -*- coding: utf-8 -*-

import requests
import platform
# path operation
import os

def Mysys():
    ''' return Windows or Linux '''    
    return platform.system()

vim_plug_url = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

# windows : C:\Vim_ywl\vimfiles\autoload
# linux : ~/Vim_ywl/vimfiles/autoload
if Mysys() == 'Windows':
    YWL_PATH = "C:\Vim_ywl"
    VIMFILE_AUTOLOAD_PATH = os.path.join(YWL_PATH, 'vimfiles', 'autoload')
elif Mysys() == "Linux":
    YWL_PATH = "~/Vim_ywl"
    VIMFILE_AUTOLOAD_PATH = os.path.join(YWL_PATH, 'vimfiles', 'autoload')
# vim-plug.vim path
vim_plug_file = os.path.join(VIMFILE_AUTOLOAD_PATH, "plug.vim")

def main():
    if not os.path.exists(vim_plug_file):
    # response.content返回二进制数据
        vim_plug_content = requests.get(vim_plug_url, timeout = 20).content
        if not os.path.exists(VIMFILE_AUTOLOAD_PATH):
            os.mkdir(VIMFILE_AUTOLOAD_PATH)
        with open(vim_plug_file, "wb") as output :
            output.write(vim_plug_content)

if __name__ == "__main__":
    main()
