#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python

def __virtual__():
    '''调用时的名字'''
    return "local_return"
def returner(ret):
    f=open('/var/log/salt/local_returner.log','a+')
    f.write(str(ret)[1:-1]+'\n')
    f.close()