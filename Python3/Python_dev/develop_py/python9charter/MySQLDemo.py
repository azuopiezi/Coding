#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python
"""
created on 20160427
@auther:Steven
Mysql 操作Demo
Done:创建表，删除表，数据增、删、改、批量插入
"""
import MysqlDBConn
dbconn = MysqlDBConn.DBDonn()
def process():
    #建立连接
    dbconn.connect()
    #删除表
    dropTable()
     #创建表
    createTable()
    #批量插入数据
    insertDatas()
      #单条插入
    insertData()
    #更新数据
    updateData()
    #删除数据
    deleteData()
    #查询数据
    queryData()
    #释放连接
    dbconn.close()

def insertDatas():
    sql = "insert into lifeba_users(name,realname,age) values(%s,%s,%s)"
    tmp = (('steven1','测试1',26),('steven2','测试2',25))
    executemany(sql,tmp)
def updateData():
    sql = "update lifeba_users set realname = '%s' WHERE name = 'steven1'" %("测试1修改")
    execute(sql)
def deleteData():
    sql = "delete from lifeba_users where id = 2"
    execute(sql)
def queryData():
    sql = "select * from lifeba_users"
    rows = query(sql)
    printResult(rows)

def insertData():
    sql = "insert into lifeba_users(name,realname,age)values('%s','%s','%s')"%("steven3","测试3","26")
    print sql
    execute(sql)

###定义名词

def executemany(sql,tmp):
    """插入多条数据"""
    conn = dbconn.cursor()
    conn.executemany(sql,tmp)
def execute(sql):
    """执行sql"""
    conn = dbconn.cursor()
    conn.execute(sql)
def query(sql):
    '''查询sql'''
    conn = dbconn.cursor()
    conn.execute(sql)
    rows = conn.fetchmany(10)
    return rows
def createTable():
    '''创建表'''
    conn = dbconn.cursor()
    conn.execute('''
    CREATE TABLE 'lifeba_users'(
    'ID' int(11) NOT NULL auto_increment,
    'name' VARCHAR(50) DEFAULT NULL ,
    'realName'VARCHAR (50) DEFAULT NULL ,
    'age' int(11) DEFAULT NULL ,
    PRIMARY KEY ('ID')
    )ENGINE = MyISAM DEFAULT CHARSET = utf8;
    ''')

#dbconn.commit()

def dropTable():
    '''删除表'''
    conn = dbconn.cursor()
    conn.execute('''
    DROP TABLE IF EXISTS 'lifeba_users'
    ''')
#dbconn.commit()

def printResult(rows):
    for row in rows:
        for i in range(0,len(row)):
            print row[i]
        print ''
if __name__== '__main__':
    process()













