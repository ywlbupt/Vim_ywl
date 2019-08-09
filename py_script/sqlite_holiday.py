#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sqlite3
import os

one_item = [20190418, 0]
multi_item = [["20190415", 0], ["20190414", 1], ["20190413", 3]]

class Handle_sqlite3():
    def __init__(self, db_path):
        self.db_path = db_path
        self.master_table = "DATE_TABLE_OF_WORK_OR_HOLIDAY"
        self.tables = {
            self.master_table:
            "create table " + self.master_table +
            " (DATE TEXT primary key, STATUS INTEGER)",
            "PRE_MACRO":
            "create table PRE_MACRO \
                       (START_TIME TEXT , END_TIME TEXT)"
        }

    def __enter__(self):
        self.conn = sqlite3.connect(self.db_path)
        self.cur = self.conn.cursor()
        self.check_and_create_tables()
        return self

    def __exit__(self, *args):
        self.cur.close()
        self.conn.close()

    def check_and_create_tables(self):
        res = self.conn.execute(
            "SELECT name FROM sqlite_master WHERE type='table';")
        table_list = [tbl[0] for tbl in res]
        for k in self.tables.keys():
            if k not in table_list:
                print("creating tbl: %s" % k)
                self.conn.execute(self.tables[k])

    def get_table_m(self):
        self.cur.execute("select * from "+ self.master_table)
        # return res_list
        return self.cur.fetchall()

    def insert_one_item_m(self, _item):
        try:
            self.conn.execute("insert into "+ self.master_table+ " values (?,?)", _item)
        except sqlite3.IntegrityError:
            print("insert item: %s fail,  same DATE ID" % _item)
        finally:
            pass

    def insert_multi_item_m(self, _items):
        for _item in _items:
            self.insert_one_item_m(_item)

    def sql_query(self, _date):
        self.cur.execute("SELECT * from "+ self.master_table + " WHERE DATE = ?", (_date,))
        return self.cur.fetchone()

    def sql_commit(self):
        self.conn.commit()

    def select_max_DATE(self):
        self.cur.execute("SELECT max(DATE) from "+ self.master_table)
        _max = self.cur.fetchone()[0]
        res = self.cur.execute("SELECT min(DATE) from "+ self.master_table)
        _min = self.cur.fetchone()[0]
        return (_min, _max)


if __name__ == "__main__":
    db_path = os.path.expanduser("~/Vim_ywl/cache/test.db")
    db_dir, db_name = os.path.split(db_path)
    if not os.path.exists(db_dir):
        os.mkdir(db_dir)
    if not os.path.exists(db_path):
        print("create db")


    with Handle_sqlite3(db_path) as m:
        # m.insert_multi_item_m(multi_item)
        # m.insert_one_item_m(one_item)
        # m.sql_commit()
        res = m.get_table_m()
        for row in res:
            print(row)
        # 打印最早最晚日期
        print(m.select_max_DATE())
        # 查询固定日期的状态，仅能查询已保存在数据库中的信息，无法联网更新
        print(m.sql_query("20190427"))
    pass
