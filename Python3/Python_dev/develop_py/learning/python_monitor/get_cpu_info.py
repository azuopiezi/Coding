#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python
from __future__ import print_function
from collections import OrderedDict
import pprint

def CPUinfo():
    '''
    Return the information in /proc/CPUinfo as a dictionary in the follwing format:
    CPU_info['proc0'] = {...}
    CPU_info['proc1'] = {...}

    '''
    CPUinfo = OrderedDict()
    procinfo= OrderedDict()

    nprocs = 0
    with open('/proc/cpuinfo') as f:
        for line in f:
            if not line.strip():  ###删除两端所有相应的字符,知道没有匹配的字符,(sa)和(as) 删除的都是一样的,strip(),是删除所有两端的空格,
                ###end of one processor
                CPUinfo['proc%s' % nprocs] = procinfo
                nprocs = nprocs +1
                ##Reset
                procinfo=OrderedDict()
            else:
                if len(line.split(':')) == 2:
                    procinfo[line.split(':')[0].strip()] = line.split(':')
                else:
                    procinfo[line.split(':')[0].strip()] = ' '
    return CPUinfo

if __name__ == '__main__':
    CPUinfo = CPUinfo()
    for processor in CPUinfo.keys():
        print (CPUinfo[processor]['model name'])

