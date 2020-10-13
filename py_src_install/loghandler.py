# -*- coding: utf-8 -*-

import os

import logging

from logging.handlers import TimedRotatingFileHandler
from logging import FileHandler
from datetime import datetime

# 日志级别
LOG_LEVELS = {
        'DEBUG': logging.DEBUG,
        'INFO': logging.INFO,
        'WARNING': logging.WARNING,
        'ERROR': logging.ERROR,
        'CRITICAL': logging.CRITICAL,
}

LOG_FORMATS = {
        'DEBUG': '%(levelname)s %(name)s: %(message)s',
        'INFO': '%(levelname)s: %(message)s',
}

CRITICAL = 50
FATAL = CRITICAL
ERROR = 40
WARNING = 30
WARN = WARNING
INFO = 20
DEBUG = 10
NOTSET = 0


class LogHandler(logging.Logger):
    """
    LogHandler
    """
    def __init__(self, name, level=logging.DEBUG):
        current_path = os.path.dirname(os.path.abspath(__file__))
        # 当前文件的上一级路径下的LOG文件夹下
        # root_path = os.path.join(current_path, os.pardir)
        self.log_path = os.path.join(current_path, 'log')
        if not os.path.exists(self.log_path):
            os.mkdir(self.log_path)
        self.name = name
        self.level = level
        # logging.Logger.__init__(self, self.name, level=level)
        super().__init__(self.name, level=level)
        # self.__set_timed_rotating_file_handler__()
        self.__set_file_handler__()
        self.__set_stream_handler__()


    def __set_file_handler__(self, level=None):
        file_name = os.path.join(
            self.log_path, '{name}{time}.log'.format(
                name=self.name,
                time=datetime.today().strftime("_%Y_%m_%d_%H_%M"))
        )
        formatter = logging.Formatter(
            '%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s'
        )
        file_handler = FileHandler(file_name, mode="w")
        file_handler.setFormatter(formatter)
        self.addHandler(file_handler)

    def __set_timed_rotating_file_handler__(self, level=None):
        """
        set file handler
        :param level:
        :return:
        """
        file_name = os.path.join(
            self.log_path, '{name}_rotate_{time}.log'.format(
                name=self.name, time=datetime.today().strftime("_%Y_%m_%d")))
        # 设置日志回滚, 保存在log目录, 一天保存一个文件, 保留15天
        # file_handler = TimedRotatingFileHandler(filename=file_name, when='D', interval=1, backupCount=15)
        file_handler = TimedRotatingFileHandler(filename=file_name,
                                                when='D',
                                                interval=2,
                                                backupCount=15)
        file_handler.suffix = '%Y%m%d_%H-%M.log'
        if not level:
            file_handler.setLevel(self.level)
        else:
            file_handler.setLevel(level)
        formatter = logging.Formatter(
            '%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s'
        )

        file_handler.setFormatter(formatter)
        self.addHandler(file_handler)

    def __set_stream_handler__(self, level=None):
        """
        set stream handler
        :param level:
        :return:
        """
        stream_handler = logging.StreamHandler()
        formatter = logging.Formatter(
            '%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s'
        )
        stream_handler.setFormatter(formatter)
        if not level:
            stream_handler.setLevel(self.level)
        else:
            stream_handler.setLevel(level)
        self.addHandler(stream_handler)


if __name__ == '__main__':
    import time
    log = LogHandler(__name__, level=logging.DEBUG)
    t_start = time.time()
    DURATION_TIME = 900
    while time.time() - t_start < DURATION_TIME:
        log.info('this is a test msg')
        time.sleep(10)
