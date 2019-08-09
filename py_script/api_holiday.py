#!/usr/bin/env python
# -*- coding: utf-8 -*-
''' 
api: 获取指定日期的节假日信息
1、接口地址：http://api.goseek.cn/Tools/holiday?date=数字日期，支持https协议。 
2、返回数据：正常工作日对应结果为 0, 法定节假日对应结果为 1, 节假日调休补班对应的结果为 2，休息日对应结果为 3 
3、节假日数据说明：本接口包含2017年起的中国法定节假日数据，数据来源国务院发布的公告，每年更新1次，确保数据最新 
4、示例： 
http://api.goseek.cn/Tools/holiday?date=20170528 
https://api.goseek.cn/Tools/holiday?date=20170528 
返回数据： 
{"code":10000,"data":1}
'''
from datetime import date
from datetime import timedelta
import os
import sys
import configparser
from sqlite_holiday import Handle_sqlite3


def get_someday_info(_date):
    """TODO: Docstring for get_someday_info.
    :day:(format) 20190415
    :returns: 0 正常工作日；1 法定节假日；2 节假日补班；3 休息日；99 请求错误
    """
    import requests
    import json

    HOLIDAY_API_URL = "http://api.goseek.cn/Tools/holiday?date="
    holiday_request_url = HOLIDAY_API_URL + _date
    r = requests.get(holiday_request_url, timeout=20)
    if r.status_code != 200:
        return 99
    # print(r.json())
    return r.json()['data']


RANDOM_TIMESEP = 30


def check_sql_timeupdate(db_path):
    fifth_days = timedelta(days=15)
    cmp_day = date.today() + fifth_days
    with Handle_sqlite3(db_path) as m:
        date_max_str = m.select_max_DATE()[1]
        if date_max_str:
            date_max = date(
                int(date_max_str[0:4]), int(date_max_str[4:6]),
                int(date_max_str[6:]))
            # true is update , false is keep
            return (cmp_day > date_max, cmp_day, date_max)
        else:
            return (True, cmp_day, None)


def read_ini():
    # iniFileUrl = "./conf.ini"
    iniFileUrl = os.path.join(sys.path[0], "conf.ini")
    conf = configparser.ConfigParser()  #生成conf对象
    conf.read(iniFileUrl)  #读取ini配置文件
    return (conf.get("path", "db_path"))


"""
param :  20190625 返回该日期的状态，工作日，周末 or 法定节假日
param = none : 更新日期状态
"""
if __name__ == "__main__":
    db_path = os.path.expanduser(read_ini())
    if len(sys.argv) == 2:
        with Handle_sqlite3(db_path) as m:
            res = m.sql_query(sys.argv[1])
            if res:
                print(res[1])
            else:
                # print(99)
                status = get_someday_info(sys.argv[1])
                print(status)
    # now_date = date.today().strftime("%Y%m%d")
    # print(get_someday_info(now_date))
    # print("nowtime: %s", now_date)
    res = check_sql_timeupdate(db_path)
    res_l = []
    if res[0]:
        try:
            if res[2]:
                iter_day = res[2] + timedelta(days=1)
            else:
                iter_day = date.today()
            while (iter_day <= res[1]):
                status = get_someday_info(iter_day.strftime("%Y%m%d"))
                res_l.append([iter_day.strftime("%Y%m%d"), status])
                iter_day = iter_day + timedelta(days=1)

        finally:
            print(res_l)
            with Handle_sqlite3(db_path) as m:
                m.insert_multi_item_m(res_l)
                m.sql_commit()
