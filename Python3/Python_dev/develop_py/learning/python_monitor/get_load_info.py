#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python

import os
def load_stat():
    loadavg = {}
    f = open("/proc/loadavg")
    con = f.read().split()
    f.close()
    loadavg['lavg_1'] = con[0]
    loadavg['lavg_5'] = con[1]
    loadavg['lavg_15'] = con[2]
    loadavg['nr'] = con[3]
    loadavg['lavg_pid'] = con[4]
    return loadavg
print "loadavg" ,load_stat()['lavg_15']




