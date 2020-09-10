#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python
import MySQLdb
class DBDonn:
    conn = None
    #建立和数据库的链接
def connect(self):
    self.conn = MySQLdb.connect(host="localhost",port=3306,user="house",passwd="house",db="house",charset="utf8")
    #获取操作游标
def cursor(self):
    try:
        return self.conn.cursor()
    except(AttributeError.MySQLDB.OperationError):
        self.connect()
        return self.conn.cursor()
def commit(self):
    return self.conn.commit()

#关闭连接
def close(self):
    return self.conn.close()

