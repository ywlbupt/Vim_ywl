#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import io
import re
# path operation
from git import Repo
from git import RemoteProgress
from git import Remote
from datetime import date

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
            print ("repo_name:{0} clone".format(repo_name))
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
    from const import VIM_PLUG_URL,VIM_PLUG_PATH,FONTS_PATH,FONTS_GIT_URL
    from osoperator import check_create_dir
    import requests
    # 下载 raw 文件
    if not os.path.exists(VIM_PLUG_PATH):
        check_create_dir(VIM_PLUG_PATH)
        vim_plug_content = requests.get(VIM_PLUG_URL, timeout = 20).content
        with open(VIM_PLUG_PATH, "wb") as output :
            output.write(vim_plug_content)
    else:
        print("file already exists")

    # clone git 仓库
    if not os.path.exists(FONTS_PATH):
        check_create_dir(FONTS_PATH)
        GitUtil.repo_clone_from(FONTS_GIT_URL, os.path.dirname(FONTS_PATH))
    else:
        print("file already exists")
