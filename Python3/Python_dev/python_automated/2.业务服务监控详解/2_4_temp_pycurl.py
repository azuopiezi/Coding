#!/usr/bin/python
# _*_ coding: UTF-8 _*_
'''
Created on Jun 29, 2016
用pycurl实现探测Web 服务质量
@author: shixingwen
'''
import os
import time
import sys
import pycurl
URL = "www.baidu.com" #探测的目标URL
c = pycurl.Curl() # 创建一个Curl对象
c.setopt(pycurl.URL,URL) #定义请求的URL常量
c.setopt(pycurl.CONNECTTIMEOUT,5)#定义请求连接的等待时间
c.setopt(pycurl.TIMEOUT,5) #定义请求超时时间
c.setopt(pycurl.NOPROGRESS,1) #屏蔽下载进度条
c.setopt(pycurl.FORBID_REUSE,1)#完成交互后强制断开连接，不重用
c.setopt(pycurl.MAXREDIRS,1)#指定HTTP重定向的最大数为1
c.setopt(pycurl.DNS_CACHE_TIMEOUT,30)#设定保存DNS信息的时间为30秒
#创建一个文件对象，以“wb” 方式打开，用来存储返回的http头部及页面内容

indexfile = open(os.path.dirname(os.path.realpath(__file__))+ "/content.txt","wb")
c.setopt(pycurl.WRITEHEADER,indexfile) #将返回的http header 定向到indexfile文件对象
c.setopt(pycurl.WRITEDATA,indexfile) #将返回的html内容定向到indexfile文件对象

try:
    c.perform() #提交请求
except Exception,e:
    print "connetion error:" +str(e)
    indexfile.close()
    c.close()
    sys.exit()


NAMELOOKUP_TIME = c.getinfo(c.NAMELOOKUP_TIME) #获取DNS解析时间
CONNECT_TIME = c.getinfo(c.CONNECT_TIME) #获取简历连接时间
PRETRANSFER_TIME = c.getinfo(c.PRETRANSFER_TIME)#获取从建立连接到准备传输所消耗的时间
STARTTRANSFER_TIME = c.getinfo(c.STARTTRANSFER_TIME) #获取从建立连接到传输开始消耗的时间
TOTAL_TIME = c.getinfo(c.TOTAL_TIME) #获取传输的时间
HTTP_CODE = c.getinfo(c.HTTP_CODE) #获取HTTP状态吗
SIZE_DOWNLOAD = c.getinfo(c.SIZE_DOWNLOAD) #获取下载数据包大小
HEADER_SIZE = c.getinfo(c.HEADER_SIZE) #获取HTTP头部大小
SPEED_DOWNLOAD = c.getinfo(c.SPEED_DOWNLOAD) #获取平均下载数度
####
####打印输出相关数据
print "HTTP状态吗： %s" % (HTTP_CODE)
print "DNS接续时间： %s" % (NAMELOOKUP_TIME*1000)
print "建立连接时间： %s" % (CONNECT_TIME*1000)
print "准备传输时间： %s" % (PRETRANSFER_TIME*1000)
print "传输开始时间： %s" % (STARTTRANSFER_TIME*1000)
print "传输结束总时间： %s" % (TOTAL_TIME*1000)
print "下载数据包大小： %s" % (SIZE_DOWNLOAD)
print "HTTP头部大小： %s" % (HEADER_SIZE)
print "平均下载数度： %s" % (SPEED_DOWNLOAD)

#关闭文件及Curl对象
indexfile.close()
c.close()






