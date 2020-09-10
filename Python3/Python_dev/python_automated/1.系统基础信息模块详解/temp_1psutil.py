#!/usr/bin/python
# -*- coding: UTF-8 -*-
'''
Created on Jun 28, 2016

@author: shixingwen
'''
###cpu信息
import psutil

psutil.cpu_times() # cpu_times 获取cpu完整信息
psutil.cpu_times(percpu=True)
s= psutil.cpu_times().user
psutil.cpu_count(logical=True)
#print s
###获取内存信息
mem = psutil.virtual_memory()
print mem
s1= mem.free
s2 = mem.total
s3 = psutil.swap_memory()
print s1,s2,s3

###磁盘信息
psutil.disk_partitions(all)
s4 = psutil.disk_usage('/')
print s4
##网络信息
s5 = psutil.net_io_counters()
print s5


###1.1.2 系统进程管理方法
#进程信息
s6 = psutil.pids()
print s6
p = psutil.Process(45657)
p.name()
p.exe()
p.cwd()
p.status()
# popen 类的使用









