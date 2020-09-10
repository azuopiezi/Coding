#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python

'''显示出所有的组合'''
for a in [1,2]:
    for b in ['a','b']:
        print a,b

'''判断tmp 是否是目录'''
import os
if os.path.isdir("/tmp"):
    print "/tmp is a directory"
else:
    print "/tmp is not a directory"


class Server(object):
    def __init__(self,ip,hostname):
        self.ip=ip
        self.hostname=hostname
    def set_ip(self,ip):
        self.ip=ip
    def set_hostname(self,hostname):
        self.hostname=hostname
    def ping(self,ip_addr):
        print "Pinging %s from %s (%s)" % (ip_addr,self.ip,self.hostname)
if __name__ =='__main__':
    server = Server('10.10.0.102','bumbly')
    server.ping('10.10.0.108')
import this

import subprocess
subprocess.call(["ls","-l","/tmp"])
subprocess.call

print a

