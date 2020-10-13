#!/usr/bin/env python

import os
import requests
import logging

from .const import (VIM_PLUG_URL,VIM_PLUG_PATH,FONTS_PATH,FONTS_GIT_URL)
from .osoperator import check_create_dir
from .GitUtil import GitUtil
from .loghandler import LogHandler
from .cmdhandler import cmdhandler

logger = LogHandler(__name__)
logging.basicConfig(level= logging.INFO)

##### 下载 plug.vim raw 文件
if not os.path.exists(VIM_PLUG_PATH):
    check_create_dir(VIM_PLUG_PATH)
    logger.info("file plug.vim downloading")
    vim_plug_content = requests.get(VIM_PLUG_URL, timeout = 20).content
    with open(VIM_PLUG_PATH, "wb") as output :
        output.write(vim_plug_content)
else:
    logger.info("file plug.vim is already exists")

##### clone git font 仓库
if not os.path.exists(FONTS_PATH):
    check_create_dir(FONTS_PATH)
    logger.info("Git repo FONT downloading")
    GitUtil.repo_clone_from(FONTS_GIT_URL, os.path.dirname(FONTS_PATH))
else:
    logger.info("Git repo FONT is already exists")

