#!/usr/bin/env python
# -*- coding: utf-8 -*-

import requests
# path operation
import os
from git import Repo
from git import RemoteProgress
from git import Remote
import io
import re
from datetime import date


# import platform
# def Mysys():
    # ''' return Windows or Linux '''
    # return platform.system()
# windows : C:\Vim_ywl\vimfiles\autoload
# linux : ~/Vim_ywl/vimfiles/autoload

vim_plug_url = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
vim_plug_path = r"./vimfiles/autoload/plug.vim"
fonts_git_url = "https://github.com/powerline/fonts.git"
fonts_path = r"./mass_repo/fonts"

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

class MyProgressPrinter(RemoteProgress):
    def update(self, op_code, cur_count, max_count=None, message=''):
        pass
        # print(op_code, cur_count, max_count, cur_count / (max_count or 100.0), message or "NO MESSAGE")
                                            # end
class GitUtil(object):
    ''' dox
    '''
    @classmethod
    def bare_repo_init(rw_dir="."):
        """
        initialize a bare repository, used for git repos
        """
        bare_repo = Repo.init(os.path.join(rw_dir, 'bare_repo'), bare=True)
        return bare_repo

    @classmethod
    def empty_repo_init(rw_dir="."):
        """
        initialize a new empty repository
        """
        empty_repo = Repo.init(os.path.join(rw_dir, 'new_repo'))
        return empty_repo

    @classmethod
    def repo_to_tarfile(ins_repo, rw_dir = "."):
        """
        Archive the repository contents to a tar file.
        ex:
            repo_m = Repo (os.path.join(rw_dir, "proxy_pool"))
            GitUtil.repo_to_tarfile(repo_m, rw_dir)
        """
        if isinstance(ins_repo, Repo):
            # TODO repo.tar 修改成 仓库名
            with open(os.path.join(rw_dir, 'repo.tar'), 'wb') as fp:
                ins_repo.archive(fp)

    @classmethod
    def repo_clone_from(cls, url, rw_dir):
        # for clone_info in Repo.clone_from(url, os.path.join(rw_dir, 'repo'),progress = MyProgressPrinter(), branch='master'):
            # print("Updated %s to %s" % (clone_info.local_ref      , clone_info.remote_ref))
        # return repo
        if cls.repo_url_check(url):
            p = re.compile('(.*)/(?P<name>.*)\.git')
            m = p.match(url)
            if m:
                repo_name = m.group('name')
            else:
                repo_name = 'repo'
            print ("repo_name:{0}".format(repo_name))
            repo = Repo.clone_from( url, os.path.join(rw_dir, repo_name ),progress = MyProgressPrinter(), branch='master')
            return repo

    @classmethod
    def repo_url_check(cls, url):
        # TODO 
        """
        check whether url_path's format is correct
        """
        return True

if __name__ == "__main__":
    if not os.path.exists(vim_plug_path):
        check_create_dir(vim_plug_path)
        vim_plug_content = requests.get(vim_plug_url, timeout = 20).content
        with open(vim_plug_path, "wb") as output :
            output.write(vim_plug_content)
    else:
        print("file already exists")

    if not os.path.exists(fonts_path):
        check_create_dir(fonts_path)
        GitUtil.repo_clone_from(fonts_git_url, os.path.dirname(fonts_path))
    else:
        print("file already exists")


