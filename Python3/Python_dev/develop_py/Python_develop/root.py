#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python

import sys,time
sys.stderr = open("record.log","a")
f = open(r"./hello1.txt","r")
t = time.strftime("%Y-%m-%d%x",time.localtime())
context = f.read()
if context:
    sys.stderr.write(t + "\n " +context)
else:
    raise Exception,t + "异常信息"

