#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
Created on Jun 28, 2016

@author: shixingwen
'''
#from decimal import getcontext
'''
#常见解析类型示例说明 A记录
import dns.resolver

domain = raw_input('please input an domain:')
A = dns.resolver.query(domain,'A')
for i in A.response.answer:
    for j in i.items:
        print j.address

#MX 记录

domain1 = raw_input('please input an domain:')
MX = dns.resolver.query(domain1,'MX')
for i in MX:
    print 'MX preference=',i.preference,'mail exchanger =',i.exchange
    
#NS记录查询

domain = raw_input('please input an domain:')
ns = dns.resolver.query(domain,'NS')
for i in ns.response.answer:
    for j in i.items:
        print j.to_text()

#cname 分析
domain = raw_input('please input an domain:')
cname = dns.resolver.query(domain,'CNAME')
for i in cname.response.answer:
    for j in i.items:
        print j.to_text()
''' 

#实践 DNS域名轮询业务监控

import dns.resolver
import os
import httplib
iplist = []
appdomain="www.baidu.com"

def get_iplist(domain = ""):
    try:
        A = dns.resolver.query(domain,'A')
    except Exception,e:
        print "dns resolver error:" + str(e)
        return
    for i in A.response.answer:
        for j in i.items:
            iplist.append(j.address)
    return True

def checkip(ip):
    checkurl = ip + ":80"
    getcontent = ""
    httplib.socket.setdefaulttimeout(5)
    conn = httplib.HTTPConnection(checkurl)
    
    try:
        conn.request("GET","/",headers = {"Host":appdomain})
        r = conn.getresponse()
        getcontent = r.read(15)
    finally:
        if getcontent == "<!doctype html>":
            print ip +"[OK]"
        else:
            print ip + "[Error]"
if __name__ == "__main__":
    if get_iplist(appdomain) and len(iplist) >0:
        for ip in iplist:
            checkip(ip)
    else:
        print "dns resolver error."
        
    
