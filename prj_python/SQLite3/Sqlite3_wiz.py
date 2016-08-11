#!/usr/bin/env python
# -*- coding:utf-8 -*-

# env : python3
# Description: Operation for Wiz_note 

import sqlite3
import os



''' Wiz_note table structure
WIZ_TAG,
WIZ_STYLE,
WIZ_DOCUMENT,
WIZ_DOCUMENT_ATTACHMENT,
WIZ_DOCUMENT_PARAM,
WIZ_DOCUMENT_TAG,
WIZ_DELETED_GUID,
WIZ_META,
WIZ_MESSAGE,
WIZ_USER
'''




if __name__=='__main__':
    print("This is an operation file to handle sqlite3 database for wiz")
    if os.path.exists("wiz_index.db"):
        # sqlite3.connect()，如果文件不存在，会自动在当前目录创建:
        wiz_conn = sqlite3.connect("wiz_index.db")
        print("db open successfully")
    
        # 获取数据库中的表格名字List
        cursor = wiz_conn.cursor()
        cursor.execute("SELECT tbl_name FROM sqlite_master WHERE type='table';")
        # 此处，wiz_tables中每一个元素都是一个元素的tuple，如: ('WIZ_TAG',)
        wiz_tables=tuple(cursor.fetchall())
        cursor.execute("SELECT sql FROM sqlite_master WHERE type='table' AND \
                 tbl_name='WIZ_DOCUMENT';")
        sql_doc = tuple(cursor.fetchall())
        with open("./temp.txt", "w", encoding='utf-8') as f:
            for tbl_name in sql_doc:
                f.write("%s,\n" % (tbl_name[0]))
                print(tbl_name[0])


        cursor.close()
        wiz_conn.close()
        print("db close successfully")
    else:
        print("File not exists!")
    pass
