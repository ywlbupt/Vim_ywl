#!/usr/bin/env python

import os
import requests

from pytool.const import *
from pytool.osoperator import check_create_dir
from pypytool.GitUtil import GitUtil
import logging
from pypkg.loghandler.loghandler import LogHandler

# log = LogHandler("install_init", level=logging.WARN)
log = LogHandler("install_init", level=logging.DEBUG)
logging.basicConfig(level=logging.INFO)

##### 下载 plug.vim raw 文件
if not os.path.exists(VIM_PLUG_PATH):
    check_create_dir(VIM_PLUG_PATH)
    log.info("file plug.vim downloading")
    vim_plug_content = requests.get(VIM_PLUG_URL, timeout = 20).content
    with open(VIM_PLUG_PATH, "wb") as output :
        output.write(vim_plug_content)
else:
    log.info("file plug.vim is already exists")

##### clone git font 仓库
if not os.path.exists(FONTS_PATH):
    check_create_dir(FONTS_PATH)
    log.info("Git repo FONT downloading")
    GitUtil.repo_clone_from(FONTS_GIT_URL, os.path.dirname(FONTS_PATH))
else:
    log.info("Git repo FONT is already exists")
